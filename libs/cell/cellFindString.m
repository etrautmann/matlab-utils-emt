function [matches] = cellFindString(cellIn, matchStr)
%
%
% EMT 2016-04-08


matches = cellfun(@(x) strcmp(x,matchStr), cellIn);

% for iC = 1:length(cellIn)
% 	matches(iC) = strcmp(cellIn{iC}, strIn);
% end

end


