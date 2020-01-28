% figFullPath ='/Users/erictrautmann/Google Drive/NeuroFAST Shared/Publications/oBMI paper/figures/media/decodePerformanceAllSessions.fig'
figFullPath = '/Users/erictrautmann/Google Drive/NeuroFAST Shared/Publications/oBMI paper/figures/media/decodePerformanceHistogramsAllSessions.fig'

openfig(figFullPath)
figH = gcf;
[figPath, figName, ext] = fileparts(figFullPath);

figNameOut = fullfile(figPath,[figName '.pdf']);
saveFigure(figNameOut)