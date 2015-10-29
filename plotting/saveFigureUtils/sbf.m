function [] = sbf(figHandle)
%
% utility to save specified fiture as both .pdf and .png
%
% EMT, 5/12/2015

if nargin < 1
    figHandle = gcf;
end

sf(figHandle,'.pdf')
sf(figHandle,'.png')
