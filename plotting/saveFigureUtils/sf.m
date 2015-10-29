function [] = sf(figHandle, ext)
% 
% quick utility to save figure to a fig dump directory
%

if nargin < 2
    ext = '.pdf';
end

if nargin < 1
    figHandle = gcf;
end

figRoot = getenv('FIGROOT');
figName = [datestr(datetime, 'yyyy-mm-dd__') datestr(datetime,'hh-mm-ss') ext];
fullFigPath = fullfile(figRoot, figName);

% exportPlot(figHandle, fullFigPath, 'format', 'png')
saveFigure(fullFigPath, figHandle);


