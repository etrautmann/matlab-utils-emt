function plot3D_emt(seq, xspec, varargin)
%
% plot3D(seq, xspec, ...)
%
% Plot neural trajectories in a three-dimensional space.
%
% INPUTS:
%
% seq        - data structure containing extracted trajectories
% xspec      - field name of trajectories in 'seq' to be plotted
%              (e.g., 'xorth' or 'xsm')
%
% OPTIONAL ARGUMENTS:
%
% dimsToPlot - selects three dimensions in seq.(xspec) to plot
%              (default: 1:3)
% nPlotMax   - maximum number of trials to plot (default: 20)
% redTrials  - vector of trialIds whose trajectories are plotted in red
%              (default: [])
%
% @ 2009 Byron Yu -- byronyu@stanford.edu

dimsToPlot = 1:3;
nPlotMax   = 20;
redTrials  = [];
conditionLabels = ones(1,length(seq));
usePatch = true;
tStart = 1;
tEnd = seq(1).T;  % this method sucks, not aware of different sequence lengths or aware of time in a trial
assignopts(who, varargin);

conditions = unique(conditionLabels);
nConditions = length(conditions);

nTrialsPerCond = ceil(nPlotMax/length(conditions));

% build cell array of indices to plot.  Each cell contains trial indices
condInds = {};


for iCond = 1:length(conditions)
    thisCondInds = find(conditionLabels == conditions(iCond));
    condInds{iCond} = thisCondInds(1:nTrialsPerCond);
end



if size(seq(1).(xspec), 1) < 3
    fprintf('ERROR: Trajectories have less than 3 dimensions.\n');
    return
end

f = figure;
pos = get(gcf, 'position');
set(f, 'position', [pos(1) pos(2) 1.3*pos(3) 1.3*pos(4)]);

colors = flipud(cbrewer('div','RdYlBu',nConditions,'cubic'));


for iCond = 1:nConditions
    theseInds = condInds{iCond};
    col = colors(iCond,:);
    for iTr = 1:nTrialsPerCond
        thisTr = theseInds(iTr);
        
        dat = seq(thisTr).(xspec)(dimsToPlot,:);
        T   = seq(thisTr).T;

%         if ismember(seq(thisTr).trialId, redTrials)
%             col = [1 0 0]; % red
%             lw  = 3;
%         else
%             col = 0.2 * [1 1 1]; % gray
            lw = 3;
%         end

%         if usePatch
%             patchline(dat(1,tStart:tEnd), dat(2,tStart:tEnd), dat(3,tStart:tEnd), 'linewidth', lw, 'edgecolor', col, 'edgeAlpha',.4);
%         else
%             plot3(dat(1,tStart:tEnd), dat(2,tStart:tEnd), dat(3,tStart:tEnd), '.-', 'linewidth', lw, 'color', col);
%         end
        
        hold on;
        plot3(dat(1,tStart), dat(2,tStart), dat(3,tStart), '.','color',[.7 .7 .7], 'markersize', 8)
        hold on
        plot3(dat(1,tEnd), dat(2,tEnd), dat(3,tEnd),'.', 'color',col, 'markersize', 15)
    end
end


axis equal;
au = AutoAxis();
au.xUnits = 'au';
au.yUnits = 'au';
au.addAutoScaleBarX;
au.addAutoScaleBarY;
au.keepAutoScaleBarsEqual = true;
au.update();

if isequal(xspec, 'xorth')
    str1 = sprintf('$$\\tilde{\\mathbf x}_{%d,:}$$', dimsToPlot(1));
    str2 = sprintf('$$\\tilde{\\mathbf x}_{%d,:}$$', dimsToPlot(2));
    str3 = sprintf('$$\\tilde{\\mathbf x}_{%d,:}$$', dimsToPlot(3));
else
    str1 = sprintf('$${\\mathbf x}_{%d,:}$$', dimsToPlot(1));
    str2 = sprintf('$${\\mathbf x}_{%d,:}$$', dimsToPlot(2));
    str3 = sprintf('$${\\mathbf x}_{%d,:}$$', dimsToPlot(3));
end
xlabel(str1, 'interpreter', 'latex', 'fontsize', 24);
ylabel(str2, 'interpreter', 'latex', 'fontsize', 24);
zlabel(str3, 'interpreter', 'latex', 'fontsize', 24);
