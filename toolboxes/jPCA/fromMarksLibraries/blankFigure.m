% produces a blank figure with everything turned off
%
% Copyright Stanford University 2011

function hf = blankFigure(varargin)

hf = figure; hold on; 
set(gca,'visible', 'off');
set(hf, 'color', [1 1 1]);
if ~isempty(varargin)
  axis(varargin{1});
end
axis square;
