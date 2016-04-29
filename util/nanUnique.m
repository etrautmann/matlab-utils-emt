function [uniqueOut] = nanUnique(dataIn)
% outputs unique values in array ignoring nan values
%
% EMT 2016-04-24

x = unique(dataIn);
uniqueOut = x(~isnan(x));