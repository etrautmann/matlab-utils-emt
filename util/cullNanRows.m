function [matOut] = cullNanRows(matIn)
%
%
% EMT 2017-02-08

rowHasNoNans = sum(isnan(matIn),2) == 0;
matOut = matIn(rowHasNoNans, :);


