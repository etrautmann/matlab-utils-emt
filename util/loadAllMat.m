function [matFiles] = loadAllMat(directory, varargin)
% load all .mat files from a specified directory that contain a provided matchstring(s).
% matchStrings can be a single string (or a cell array of strings) which all must be present in the filename.
%
% output: 
%     matFiles - 1 x nFiles struct array containing data in the matfiles(n).data field
% 
% Eric Trautmann, 7/12/14


p = inputParser();
p.addRequired('directory',@ischar);
p.addParamValue('matchStrings',[],@ischar)

p.parse(directory, varargin{:});
directory = p.Results.directory;
matchStrings = p.Results.matchStrings;


if isempty(matchStrings)
    matchStrings = {'\w'};
end
% enclose in a cell iif only a single match string provided.
if ~iscell(matchStrings)
    matchStrings = {matchStrings};
end


% add trailing slash if none is preset
if strcmp(directory(end), '/') == 0
    directory = [directory '/'];
end
fileList = dir([directory '*.mat']);


% delete anything not matching match strings
ignoreMask = false(1, length(fileList));
for iString = 1:length(matchStrings)    
    for iFile = 1:length(fileList)
        
        % if no match, then remove that file from the list
        if ( isempty(regexpi(fileList(iFile).name, matchStrings{iString})) & ~isempty(matchStrings{iString}) )
            ignoreMask(iFile) = 1;
        end
    end
end
fileList(ignoreMask) = [];



% load all files 
matFiles = fileList;
for iFile = 1:length(fileList)
    matFiles(iFile).data = load([directory '/' matFiles(iFile).name]);
end

