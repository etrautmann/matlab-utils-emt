function [] = yTickLims(axisHandle)
% sets the y Tick limits to include just the endpoints and zero
% 
% emt
% 4/15/2014


yTick = get(gca,'YTick');

if sign(min(yTick)) ~= sign(max(yTick))
    yTick = [yTick(1) 0 yTick(end)];
else
    yTick = [yTick(1) yTick(end)];
end

yTick = unique(yTick);

set(gca,'YTick',yTick);


end