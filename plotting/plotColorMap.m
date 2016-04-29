function [] = plotColorMap(cmap, figHandle)
%
%
% EMT 2016-04-16

if nargin < 2
    figHandle = figure(1); 
end

figure(figHandle); clf;

N = size(cmap,1);

for ii = 1:N
    plot(rand(100,1)+ii,'color',cmap(ii,:),'linewidth',3)
    hold on
end
