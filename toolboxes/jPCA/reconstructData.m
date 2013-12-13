%  This is partly intended as a sanity check, and partly as a way of viewing the quality of the
%  reconstruction as a function of the number of PCs.
%
%  The high-D data are reconstructed from the low-D jPCA projections.  This is basically just as
%  simple as computing projAllTimes * jPCs_highD'.  However, there are pre-processing steps that
%  must be taken into account: the data were normalized before doing PCA, and PCA naturally removes
%  each neuron's overall firing rate (note that jPCA probably also removed the cross-condition mean,
%  but that is a separate step).
%
%  Anyway, this function projets back to the high-D space, appropriately reversing the
%  pre-processing.  The reconstruction should be close to perfect if you asked jPCA to use a large
%  number of PCs.  
%
%  In the likely event that jPCA involved removing the cross-condition mean, the resulting
%  reconstruction will yeild the mean-subtracted firing rates.
%  
%
%  useage: DataRec = reconstructData(Projection, Summary, Data, neuron2Plot)
%
%  inputs:
%           'Projection' and 'Summary' are returned by jPCA
%           'Data' is the the data that you fed to jPCA.
%
% outputs:
%           DataRec.A   The reconstructed data.
%           DataRec.times  The original times from 'Data'
%           DataRec.Aorig  The original A matrix from 'Data'
%           
%
function DataRec = reconstructData(Projection, Summary, Data, neuron2Plot)


%% if cross cond mean was removed, we can only reconstruct the data with the mean removed
if Summary.acrossCondMeanRemoved == 1
    sumA = 0;
    for c = 1:length(Data)
        sumA = sumA + Data(c).A;  % making sure we use the same normalization as above
    end
    meanA = sumA/length(Data);
    
    for c = 1:length(Data)
        Data(c).A = Data(c).A - meanA;  % making sure we use the same normalization as above
    end
    disp('IMPORTANT !!!:  We are reconstrucing only the condition-dependent component');
end


DataRec = Data;

if exist('neuron2Plot', 'var'), figure; end


%% Take the projections in 'Projection' and reconstruct Data.A
for c = 1:length(DataRec)
    DataRec(c).Aorig = DataRec(c).A;  % keep a copy of the original data
    
    % go from the jPCA projections all the way back up to the highD space
    DataRec(c).A = Projection(c).projAllTimes * Summary.jPCs_highD';
    % as a sanity check, also go from the traditional PC projections back up.
    %DataRec(c).A_sanityCheck1 = Projection(c).tradPCAprojAllTimes * Summary.PCs'; 
    
    DforRanges(c).A_fromProj = Projection(c).proj * Summary.jPCs_highD';  %#ok<AGROW> % We ONLY use this to fix the ranges.
end


% now fix the mean and range
for c = 1:length(DataRec)  % now we make those ranges match what they originally were (over those same times) and add back the mean
    DataRec(c).A = bsxfun(@plus, DataRec(c).A,  Summary.preprocessing.meanFReachNeuron);
    DataRec(c).A = bsxfun(@times, DataRec(c).A,  Summary.preprocessing.normFactors);  
end


%% Plot the asked-for example neuron
if exist('neuron2Plot', 'var')
    
    % for the scales
    allData = [vertcat(Data(:).A) ; vertcat(DataRec(:).A)];
    
    maxData = max(allData(:,neuron2Plot));
    minData = min(allData(:,neuron2Plot));
    plotTimes = DataRec(1).times;
    
    padLeft = -200;
    padRight = 60;
    padBottom = -0.25*(maxData-minData);
    padTop = 0.2*(maxData-minData);
    
    
    blankFigure([plotTimes(1)+padLeft, plotTimes(end)+padRight, minData+padBottom, maxData+padTop]);
    
    for c = 1:length(DataRec)
        plot(plotTimes, Data(c).A(:,neuron2Plot), 'color', 0.7*[1 1 1], 'linewidth', 2); hold on;
    end
    for c = 1:length(DataRec)  % all on top
        plot(plotTimes, DataRec(c).A(:,neuron2Plot), 'r', 'linewidth', 1);
        %plot(plotTimes, DataRec(c).A_sanityCheck1(:,neuron2Plot), 'g.');
    end
    
    axisParamsH.tickLocations = [plotTimes(1), 0, plotTimes(end)];
    axisParamsH.axisLabel = 'time w.r.t movement onset';
    axisParamsH.axisOffset = minData - 0.05*(maxData-minData);
    axisParamsH.fontSize = 9;
    AxisMMC(plotTimes(1), plotTimes(end), axisParamsH);
    
    axisParamsV.axisOrientation = 'v';
    axisParamsV.axisOffset = plotTimes(1)-45;
    axisParamsV.fontSize = 9;
    AxisMMC(5*ceil(minData/5), 5*floor(maxData/5), axisParamsV);
    
    text(plotTimes(end), maxData, 'red = reconstruction', 'horizon', 'right');
    if Summary.acrossCondMeanRemoved == 1
        text(plotTimes(end), 0.91*maxData, 'cross-cond mean removed', 'horizon', 'right');
    end
end
    


















