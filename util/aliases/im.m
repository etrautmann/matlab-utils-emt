function [] = im(U)

figure(gcf); clf;
imagesc(U);
colorbar
colormap(flipud(cbrewer('div','RdYlBu',50,'cubic')));
% axis image

end
