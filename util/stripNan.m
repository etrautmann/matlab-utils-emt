function [dataOut] = stripNan(dataIn)
%
%
% EMT 2016-04-24

inds = ~isnan(dataIn);
dataOut = dataIn(inds);

