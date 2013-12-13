function jPCAWithMusclesOneAtATime(NSingle, NArray, Ms, nDimPCA, nPlanesToExamine, timeWindow, muscleOverRepFactor, nMuscleDims, nMeanDims, plotjPCAPlanes, plotMuscReconstructions)

%% Optional arguments
if ~exist('nPlanesToExamine', 'var')
  nPlanesToExamine = 2;
end

if ~exist('timeWindow', 'var')
  timeWindow = -50:10:350;
end

if ~exist('muscleOverRepFactor', 'var')
  muscleOverRepFactor = 4;
end

mazeSets = unique([NSingle.mazeSet]);
nMuscles = length(Ms) / length(mazeSets);
if ~exist('nMuscleDims', 'var') || isinf(nMuscleDims)
  nMuscleDims = nMuscles;
end

if ~exist('nMeanDims', 'var')
  nMeanDims = 0;
end

if ~exist('plotjPCAPlanes', 'var')
  plotjPCAPlanes = false;
end

if ~exist('plotMuscReconstructions', 'var')
  plotMuscReconstructions = false;
end


%% Internal parameters
minRange = 0;
muscOffset = 50;
muscSubtractMean = 0;

muscleToPlot = 1;
mazeSetToPlot = 1;


%% Pre-allocate

angles = nan(length(mazeSets), nMuscles, nPlanesToExamine);
normLens = nan(length(mazeSets), nMuscles, nPlanesToExamine);

R2s = nan(length(mazeSets), nMuscles);


%% Hack muscle timing in interpPSTH, since that's all that's used to make the A matrix

Ms = advanceMInterpPSTH(Ms, muscOffset);


%% Set up jPCA parameters, plotting parameters

params.numPCs = nDimPCA;
params.suppressBWrosettes = 1;
params.suppressHistograms = 1;
params.meanSubtract = 1;  % default anyway

% plotParams.crossCondMean = 1;

%% Loop through mazes, prep data structure
for maze = 1:length(mazeSets)
  %% Pre-allocation and setup
  
  % Pre-allocate for MVecs
  MVecs = nan(2, nMuscles, nPlanesToExamine);
  
  % Set up neural data
  NCombo = combineSingleArray(NSingle, NArray, mazeSets(maze), minRange);
  dataN = N2GenericJPCAformat(NCombo);
  
  data = dataN;
  
  nConds = length(data);
  nTimes = size(data(1).A, 1);

  timeWindowPts = ismember(data(1).times, timeWindow);

  colors = rand(nConds, 3);
  
  
  %% Set up muscle data
  M = oneMazeSetN(Ms, Ms, mazeSets(maze));
  dataM = N2GenericJPCAformat(M);
  
  muscleProj = zeros(nTimes, nConds, nMuscles);
  
  for c = 1:nConds
    muscleProj(:, c, :) = dataM(c).A;
  end

  
  %% Reduce D of muscle data if requested
  if nMuscles ~= nMuscleDims
    % Make the A matrix: ct x m
    reMuscleProj = squeeze(reshape(muscleProj, [nTimes * nConds, nMuscles]));
    % Normalize the columns (muscles) by their range)
    reMuscleProj = bsxfun(@rdivide, reMuscleProj, range(reMuscleProj));
    % Run PCA
    [coeff, reMuscleProj] = princomp(reMuscleProj);
    % Project nMuscleDims dimensions of scores back out to high-D
    reMuscleProj = reMuscleProj(:, 1:nMuscleDims) * coeff(:, 1:nMuscleDims)';
    
    % Reshape results to t x c x m
    muscleProj = reshape(reMuscleProj, [nTimes, nConds, nMuscles]);
  end
  
  
  %% Loop through each muscle
  for musc = 1:nMuscles
    %% Add one muscle to neural A matrix
    for c = 1:nConds
      data(c).A = [dataN(c).A muscleProj(:, c, musc)];
    end
    
    %% Do projection once with normalization, to get norm coeffs
    params.normalize = 1;
    [~, Summary] = jPCA(data, timeWindow, params);
    
    %% Now, normalize manually, over-representing muscle
    normFactors = Summary.preprocessing.normFactors;
    normFactors(end) = normFactors(end) / muscleOverRepFactor;
    
    for c = 1:nConds
      data(c).A = bsxfun(@rdivide, data(c).A, normFactors);
    end
    
    %% Run jPCA again without auto normalization, since we've just done it
    params.normalize = 0;
    [Projection, Summary] = jPCA(data, timeWindow, params);
    
    
    %% Grab the muscle projection vector
    MVecHigh = Summary.jPCs_highD(end, :);
    
    
    %% Re-project data without including muscle
    projMat = Summary.jPCs_highD;
    projMat(end, :) = 0;
    for c = 1:nConds
      A = bsxfun(@minus, data(c).A, Summary.preprocessing.meanFReachNeuron);
      Projection(c).projAllTimes = A * projMat;
    end
    

    %% Loop through planes, collect angles, etc., plot if requested
    for p = 1:nPlanesToExamine
      d = [2*p-1, 2*p];
      MVec = MVecHigh(d) / norm(MVecHigh);
      MVecs(:, musc, p) = MVec;
      
      angles(maze, musc, p) = acos(MVec * [1 0]' / norm(MVec));
      normLens(maze, musc, p) = norm(MVec);
      
      % If requested, plot jPCA planes
      if plotjPCAPlanes && maze == mazeSetToPlot
        plotParams.planes2plot = p;
        phaseSpace(Projection, Summary, plotParams);
        
        hold on;
        plot([0 MVec(1)], [0 MVec(2)], 'm-', 'LineWidth', 3);
        arrowMMC([0 0], MVec, MVec * 1.05, 12, [], 'm', 'm');
      end
    end
    
    
    
    %% Reconstruct muscle
    muscTrue = zeros(nTimes, nConds);
    muscRecon = zeros(nTimes, nConds, nPlanesToExamine);
    neuralProj = zeros(nTimes, nConds, nPlanesToExamine*2);
    
    for c = 1:nConds
      muscTrue(:, c) = dataM(c).A(:, musc);
      
      % Grab neural data projected into jPCA planes
      neuralProj(:, c, :) = Projection(c).projAllTimes(:, 1:nPlanesToExamine*2);
    end
    
    % Mean-subtract for true EMG
    if muscSubtractMean
      emgMean = mean(muscTrue, 2);
      muscTrue = bsxfun(@minus, muscTrue, emgMean);
    else
      fprintf('**************NOT SUBTRACTING MUSCLE MEAN*****************\n');
    end

    % Regress EMG onto neural
    reNeuralProj = squeeze(reshape(neuralProj, [nTimes * nConds, nPlanesToExamine*2]));
    b = regress(muscTrue(:), reNeuralProj);

    % Full reconstruction from all planes
    muscReconMultiPlane = reshape(reNeuralProj * b, nTimes, nConds);
    
    % Reconstruction plane by plane
    for p = 1:nPlanesToExamine
      d = p*2 + (-1:0);
      muscRecon(:, :, p) = reshape(reNeuralProj(:, d) * b(d), nTimes, nConds);
    end
    
    % Check regression only over regressed time window
    muscTrue = muscTrue(timeWindowPts, :);
    muscRecon = muscRecon(timeWindowPts, :, :);
    muscReconMultiPlane = muscReconMultiPlane(timeWindowPts, :);
    
    R2s(maze, musc) = corr2(muscReconMultiPlane(:), muscTrue(:));
    
    if plotMuscReconstructions && maze == mazeSetToPlot && musc == muscleToPlot
      plotMusclePSTH(muscTrue, colors);
      title('True EMG');
      for p = 1:nPlanesToExamine
        plotMusclePSTH(muscRecon(:, :, p), colors);
        title(sprintf('Reconstruction from plane %d', p));
      end
      plotMusclePSTH(muscReconMultiPlane, colors);
      title('Reconstruction from all planes');
    end

    
    
  end
  
  %% Plot neural-only jPCA planes with all muscle arrows on top
  params.normalize = 1;
  [Projection, Summary] = jPCA(dataN, timeWindow, params);
  for p = 1:nPlanesToExamine
    plotParams.planes2plot = p;
    phaseSpace(Projection, Summary, plotParams);
    hold on;
    for musc = 1:nMuscles
      MVec = MVecs(:, musc, p);
      plot([0 MVec(1)], [0 MVec(2)], 'm-', 'LineWidth', 3);
      arrowMMC([0 0], MVec', MVec' * 1.05, 12, [], 'm', 'm');
    end
  end
end



%% Summary stats


% fprintf('\nPlane\tMean vec len\tMean angle\n');
% for p = 1:nPlanesToExamine
%   fprintf('%d\t%0.3f\t\t%0.1f\n', p, mean(mean(normLens(:, :, p))), mean(mean(angles(:, :, p))));
% end

angleMed = rad2deg(circMedianHalfCirc(angles(:)));

fprintf('\nGrand mean vector length: %0.3f\n', mean(normLens(:)));
fprintf('Grand median angle: %0.1f\n', angleMed);

% angles = rad2deg(angles);


%% Plot summaries

for p = 1:nPlanesToExamine
  lengths = normLens(:, :, p);
  figure;
  hist(lengths(:), 10);
  xlabel('Normed vector length');
  title(sprintf('Plane %d', p));
  
  angs = angles(:, :, p);
  figure;
  hold on;
  hist(rad2deg(angs(:)), 9);
  plot(90, 0.1, 'rx', 'MarkerSize', 10, 'LineWidth', 2);
  medAngle = rad2deg(circMedianHalfCirc(angs(:)));
  plot(medAngle, 0.5, 'r.', 'MarkerSize', 10, 'LineWidth', 2);
  xlabel('Angle (degrees)');
  title(sprintf('Plane %d', p));
  set(gca, 'XLim', [0 180]);
end


%% Muscle reconstruction stats

fprintf('\nMean muscle reconstruction R^2: %0.3f\n', mean(R2s(:)).^2);




%% Helper functions

function Ms = advanceMInterpPSTH(Ms, muscOffset)

timeBase = diff(Ms(1).interpTimes.times(1:2));
offsetPts = floor(muscOffset / timeBase);

fprintf('Advancing muscles by %dms (%d pts)\n', muscOffset, offsetPts);

for m = 1:length(Ms)
  for c = 1:length(Ms(m).cond)
    Ms(m).cond(c).interpPSTH = [Ms(m).cond(c).interpPSTH(offsetPts+1:end); zeros(offsetPts, 1)];
  end
end


function plotMusclePSTH(musc, colors)

figure;
hold on;
for c = 1:size(musc, 2)
  plot(musc(:, c), '-', 'color', colors(c, :));
end
axis tight


function med = circMedianHalfCirc(angles)
angs = 2 .* angles;
angs = angs - 2 * pi * (angs > pi);
med = circ_median(angs);
med = med + 2 * pi * (med < 0);
med = med / 2;


