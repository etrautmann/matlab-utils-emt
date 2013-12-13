




%%  *** GENERIC jPCA: QUICK EXAMPLES ****


% Jenkins example
[Projection, Summary] = jPCA(N2GenericJPCAformat(Ns), -50:10:150);
phaseSpace(Projection, Summary);  % plot the first two jPC planes (ordered by eigenvalue)
% note that this exactly replicates our original analysis done before generic jPCA
%


params.numPCs = 12;
params.suppressBWrosettes = 1;
params.suppressHistograms = 1;
params.meanSubtract = 1;  % default anyway
[Projection, Summary] = jPCA(N2GenericJPCAformat(Ns), -50:10:150, params);

plotParams.planes2plot = [1 2 3];
plotParams.crossCondMean = 1;
phaseSpace(Projection, Summary, plotParams);

% now do again but without mean subtraction
params.meanSubtract = 0;  % now don't subtract this
[Projection, Summary] = jPCA(N2GenericJPCAformat(Ns), -50:10:150, params);
phaseSpace(Projection, Summary, plotParams);





%% Load Jenkins data

load keyStructures_JAB_noPCsmooth
load('/data/Jenkins/MATstructs/N/N,2009-09-18,1-2,good-ss.mat');
N18 = Ns;

nDimPCA = 10;
nPlanesToExamine = 3;
timeWindow = -50:10:350;
plotjPCAPlanes = 0;
muscleOverRepFactor = 1;
nMuscleDims = Inf;
nMeanDims = 2;
plotMuscReconstructions = 1;
jPCAWithMusclesOneAtATime(Njs, N18, Mjs, nDimPCA, nPlanesToExamine, timeWindow, muscleOverRepFactor, nMuscleDims, nMeanDims, plotjPCAPlanes, plotMuscReconstructions);




% Re-norm jPCA proj vectors after removing muscle
% Better stats on angle
% Deal with mean subtraction - permit regression onto 2D neural means?
% 4D vector lengths?

% Eventually, sweep lag

% X Override normalization (Use Summary.preprocessing), may be more complicated
% X Pull muscle out of projection (last stage)
% X Muscle reconstructions, R2
% X Assess muscle R2 only on right chunk of data
% X Circular stats on angles

