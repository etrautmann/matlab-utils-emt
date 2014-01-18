function [] = simpleAxes()

hold on

% create x,y,z axis (red,green,blue)
p1 = plot3([min(xlim) max(xlim)],[0 0],[0 0],'-', 'linewidth',2);   %x axis plot
p2 = plot3([0 0],[min(ylim) max(ylim)],[0 0],'-', 'linewidth',2);   %y axis plot
p3 = plot3([0 0],[0 0],[min(zlim) max(zlim)],'-', 'linewidth',2);   %z axis plot

axiscolor = .4*[1 1 1];
set(p1,'color',axiscolor);
set(p2,'color',axiscolor);
set(p3,'color',axiscolor);
axis off
% set(gcf,'color',[0 0 0])

end