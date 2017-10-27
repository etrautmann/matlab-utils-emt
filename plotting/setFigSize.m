function [] = setFigSize(figH, figSize)
%
%
% EMT - 2016-04-03

screensize = get( groot, 'Screensize' );

if nargin < 2
    figSize = [800 800];
end


set(figH, 'WindowStyle', 'normal')

% figX = screensize(3) - figSize(1);
% figY = screensize(4) - figSize(2);

figX = 500;
figY = 500;

pause(.1)

set(figH,'Position',[figX figY figSize])


