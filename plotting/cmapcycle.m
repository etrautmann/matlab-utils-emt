function [] = cmapcycle(cmaps)

for mm = 1:size(cmaps,2)
    colormap(cmaps{mm})
    pause(2);
end