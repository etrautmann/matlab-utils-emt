function [] = writeVideo(f1,fpath)
% TODO: 
%     1) document, add additional options for adjusting view, support for
% patch and points.
%     2) add paramter/value pairs
%     3) add return value

% todo: default parameter handling
% optargs = {nVidFrames};
% optargs = {100};
% optargs(1:numvarargs) = varargin;
% [nVidFrames] = optargs{:};

verboseOutput = false;  % todo: add as argument
nVidFrames = 10;        % todo: remove:

winStyle = get(f1,'windowstyle'); %save incoming window style
set(f1,'windowstyle','normal')     %undock for video writing

vidObj = VideoWriter(fpath);
open(vidObj);
vidObj

figure(f1);
axis off; set(f1,'color',[0 0 0])
% h = findobj(gca,'Type','line');
h = findall(gca);

for ii = 1:nVidFrames
    rotate(h,[0 0 1],(120/nVidFrames));
    Frames(ii) = getframe(f1);
    writeVideo(vidObj,Frames(ii));
    if verboseOutput
        disp(['Frame number: ' num2str(ii)])
    end
end

close(vidObj);
set(f1,'WindowStyle',winStyle);     %reset window style

end

