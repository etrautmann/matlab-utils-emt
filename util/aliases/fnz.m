function [y] = fnz(x)
% 
% fraction of nonzero elements
%
% EMT 2017-10-28

y = nnz(x)/length(x);