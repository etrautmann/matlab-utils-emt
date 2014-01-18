function [] = linkAxes2(figHandle)


axesList = findall(gcf,'type','axes');
allYLim = get(axesList, {'YLim'});
allYLim = cat(2, allYLim{:});
set(axesList, 'YLim', [min(allYLim), max(allYLim)]);

end
