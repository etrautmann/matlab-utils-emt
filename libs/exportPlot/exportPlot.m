function [] = exportPlot(figHandle, filePath, varargin)
% Export figures with 
%   a) better aesthetic defaults for axes, labels, title, etc.
%   b) size/color/format defaults.
%   c) if exporting eps, calls fixPSLinestyle to widen lines. Standard line
%   weight is too small, making grids and axes hard to view.
% 
% example usage:
%   exportPlot(gcf, 'figure_name')
%   exportPlot(gcf, 'figure_name', 'format', 'eps')
%   exportPlot(gcf, 'figure_name', 'size', [ 0 0 8.5 11])
% 
% emt 11/5/12
%
% todo: add padding if no x or y axis labels

% set defaults
defaultFormat = 'eps';
defaultSize = [0 0 6 5];
defaultColor = 'w';
defaultAxesShade = 0;

% input defaults
p = inputParser;
p.addRequired('figHandle');
p.addRequired('filePath',@ischar);
p.addParamValue('format',defaultFormat);
p.addParamValue('size',defaultSize);
p.addParamValue('bgColor',defaultColor);
p.addParamValue('axesShade',defaultAxesShade);


p.parse(figHandle,filePath,varargin{:});
figHandle = p.Results.figHandle;
filePath = p.Results.filePath;
ext = p.Results.format;
size = p.Results.size;
bgColor = p.Results.bgColor;
axesShade = p.Results.axesShade;
% ===== end parsing ===== 


%look for specified folder and create if it doens't exist.
[pathstr, fileName, ~] = fileparts(filePath);

if isempty(pathstr)
    pathstr = getenv('FIGROOT');
elseif exist(pathstr, 'dir') ~= 7
    mkdir(pathstr);
end

if strcmp(ext, '')
    ext = '.eps';
end



% fix defaults on all axes in figure
axesList = findall(figure(figHandle),'type','axes');

% for kk = 1:length(axesList)
%     axes(axesList(kk))
    set(axesList, ...
        'Box'         , 'off'     , ...
        'TickDir'     , 'out'     , ...
        'TickLength'  , [.015 .015] , ...
        'XMinorTick'  , 'off'      , ...
        'YMinorTick'  , 'off'      , ...
        'XColor'      , axesShade*[1 1 1], ...
        'YColor'      , axesShade*[1 1 1], ...
        'LineWidth'   , 1         );
    
    set(figHandle, 'InvertHardCopy', 'off');
    set(gca, 'TickDir','out')
    %set(get(gca,'XLabel'),'FontName', 'Arial',  'FontSize', 14);
    %set(get(gca,'YLabel'),'FontName', 'Arial',  'FontSize', 14);
    %set(get(gca,'ZLabel'),'FontName', 'Arial',  'FontSize', 14);
    %set(get(gca,'title') ,'FontName', 'Arial',  'FontSize', 16,  'FontWeight', 'bold');
    
% end

% set background color
if bgColor == 'w'
    set(figHandle,'Color','w')
else
    set(figHandle,'Color','k')
end

% orient portrait

if numel(size) == 2
    size = [0 0 size];
end

set(figHandle, 'PaperPosition', size);
set(figHandle, 'PaperPositionMode', 'auto');

% winStyle = get(figHandle, 'WindowStyle');
% if strcmp(winStyle, 'docked')
%     set(figHandle,'WindowStyle','Normal');
% end


% suppress position warnings for docked figures:
warning('off','MATLAB:Figure:SetPosition');
warning('off','MATLAB:print:CustomResizeFcnInPrint');

% add leading period if required for back compatibility
if ~strcmp('.',ext(1))
    ext = ['.' ext];
end

% export in desired format
switch ext
    case '.eps'      % default case
%         set(figHandle, 'Renderer', 'opengl')
%         print(figHandle,'-depsc2',[filePath]);
%         fixPSlinestyle([filePath '_temp.eps'],[filePath '.eps']) % call external function to make line weights heavier
%         eval(['!rm ' filePath '_temp.eps']);
        fileOut = fullfile(pathstr, fileName);
        epswrite(figHandle, fileOut)

    case '.png'
%         set(figHandle, 'PaperPosition', .5*size); %not sure why png requires rescaling
        print(figHandle,'-dpng', '-r300',[filePath '.png']);
        
    case '.svg'
        print(figHandle,'-dsvg','-r300', [filePath '.svg']);
        
    case '.pdf'
        print(figHandle,'-dpdf','-r300', [filePath '.pdf']);
        
%     case 'epspng'
%         print(figHandle,'-depsc2',[filePath '_temp.eps']);
%         fixPSlinestyle([filePath '_temp.eps'],[filePath '.eps']) % call external function to make line weights heavier
%         eval(['!rm ' filePath '_temp.eps']);
%         
%         [pathstr, name, ext] = fileparts(filePath);
%         mkdir([pathstr '/png/']);
%         print(figHandle,'-dpng', '-r300',[pathstr '/png/' name]);
end

% if strcmp(winStyle, 'docked')
%     set(figHandle,'WindowStyle','Docked');
% end



end


