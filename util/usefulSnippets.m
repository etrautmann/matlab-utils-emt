%% Plotting 

figure(); clf;

grid on
xlim([])
ylim([])
xlabel(' ()')
ylabel(' ()')
title('')

figNameFull = fullfile(figPath, [datasetName '__fig_title.hires.png']);
saveFigure(figNameFull, gcf)


%%

