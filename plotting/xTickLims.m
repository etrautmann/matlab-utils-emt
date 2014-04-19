function [] = xTickLims(axisHandle)
% sets the x Tick limits to include just the endpoints and zero
% 
% emt
% 4/15/2014



xTick = get(gca,'XTick');

if sign(min(xTick)) ~= sign(max(xTick))
    xTick = [xTick(1) 0 xTick(end)];
else
    xTick = [xTick(1) xTick(end)];
end

set(gca,'XTick',xTick);


end