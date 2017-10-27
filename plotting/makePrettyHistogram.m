function [] = makePrettyHistogram(histHandle, color)

if nargin < 2
    color = [0 0 1];
end

histHandle.FaceColor = color;
histHandle.FaceAlpha = .55;
histHandle.EdgeColor = 'none';