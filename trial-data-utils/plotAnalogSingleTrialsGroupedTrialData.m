function [] = plotAnalogSingleTrialsGroupedTrialData(tdca, analogChan)
%
%
% EMT - 2016-05-27

[data, tvec] = tdca.getAnalogAsMatrixGrouped(analogChan)

condApp = tdca.conditionAppearances;

lines = {};
for iG = 1:length(data)
    lines{iG} = plot(tvec, data{iG}, 'Color', condApp(iG).Color);
end

end
