function [dataOut] = stripNan(dataIn)
%
% removes all elements of a tensor along any dimension in which at least
% one element is nan.

% EMT 2017-12-21

inds = isnan(dataIn);

warning('this function doesnt ...function')


% old version which does very little
% inds = ~isnan(dataIn);
% dataOut = dataIn(inds);




