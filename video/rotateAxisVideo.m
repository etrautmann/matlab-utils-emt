function [] = rotateAxisVideo(figHandle, fpath, varargin)
% TODO: 
%     1) document, add additional options for adjusting view, support for
% patch and points.
% ex: writeVideo(figHandles(1), fpath,'FrameRate',2,'NumFrames',20,'Verbose',true)

p = inputParser;
p.addRequired('figHandle',@ishandle);
p.addRequired('fpath',@ischar);
p.addParamValue('FrameRate', 2, @(x)isnumeric(x) && x>= 0 && x<= 60);
p.addParamValue('NumFrames', 20, @(x)isnumeric(x) && x>= 0);
p.addParamValue('StartView', [-45 20], @(x)isnumeric(x));
p.addParamValue('Verbose', false, @(x)islogical(x));
p.parse(figHandle, fpath,  varargin{:});
inputs = p.Results;

verboseOutput = false;  % todo: add as argument

winStyle = get(figHandle,'windowstyle'); %save incoming window style
set(figHandle,'windowstyle','normal')     %undock for video writing

vidObj = VideoWriter(fpath);
vidObj.FrameRate = inputs.FrameRate;
open(vidObj);

figure(figHandle);
set(figHandle,'OuterPosition',[100 100 1100 1100])
axis off; 
% set(figHandle,'color',[0 0 0])
view(inputs.StartView);
h = findall(gca);

for ii = 1:inputs.NumFrames
    rotate(h,[0 0 1],(360/inputs.NumFrames));
    Frames(ii) = getframe(figHandle);
    writeVideo(vidObj,Frames(ii));
    if inputs.Verbose
        disp(['Frame number: ' num2str(ii) '/' num2str(inputs.NumFrames)])
    end
end

close(vidObj);
set(figHandle,'WindowStyle',winStyle);     %reset window style

end

