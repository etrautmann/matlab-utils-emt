

cmaps = {};
cmaps{end+1} = flipud(cbrewer('seq','YlGn',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','YlGnBu',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','PuBuGn',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','PuBu',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','Blues',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','BuPu',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','PuRd',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','Reds',8,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','GnBu',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','YlGn',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','YlGnBu',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','PuBuGn',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','PuBu',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','Blues',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','BuPu',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','PuRd',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','Reds',8,'cubic'));
% cmaps{end+1} = (cbrewer('seq','GnBu',8,'cubic'));

cmapd = {};
cmapd{end+1} = flipud(cbrewer('div','PRGn',8,'cubic'));
cmapd{end+1} = flipud(cbrewer('div','RdBu',8,'cubic'));
cmapd{end+1} = flipud(cbrewer('div','RdYlBu',8,'cubic'));
cmapd{end+1} = flipud(cbrewer('div','RdYlGn',8,'cubic'));
cmapd{end+1} = flipud(cbrewer('div','RdGy',8,'cubic'));
% 
% colororder = hsv(8);
colororder = varycolor(8)
% colororder = jet(6);

% colororder = cmaps{5};
% colororder = cmapd{2};

colororder = winter(6);
set(0,'DefaultAxesColorOrder',colororder,...
    'DefaultLineLineWidth',1);

close all
figure(1); clf;

plot(rand(20,8), 'linewidth',2)
exportPlot(gcf,'test')