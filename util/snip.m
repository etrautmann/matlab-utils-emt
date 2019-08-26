%% Input Parser


p = inputParser;
p.addRequired('td');
p.addParameter('param1', false, @islogical);
p.addParameter('param2', false, @islogical);
p.addParameter('param3', false, @islogical);
p.addParameter('param4', false, @islogical);

p.parse(td, varargin{:});
param1 = p.Results.param1;
param2 = p.Results.param2;
param3 = p.Results.param3;
param4 = p.Results.param4;

% \input parsing ==========================================================


%% ========================================================================
% colormaps 
% =========================================================================

cmaps = cbrewer('seq',[],50,'cubic');
cmaps = {};
cmaps{end+1} = flipud(cbrewer('seq','YlGn',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','YlGnBu',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','PuBuGn',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','PuBu',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','Blues',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','BuPu',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','PuRd',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','Reds',50,'cubic'));
cmaps{end+1} = flipud(cbrewer('seq','GnBu',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','YlGn',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','YlGnBu',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','PuBuGn',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','PuBu',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','Blues',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','BuPu',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','PuRd',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','Reds',50,'cubic'));
cmaps{end+1} = (cbrewer('seq','GnBu',50,'cubic'));

cmapd = {};
cmapd{end+1} = flipud(cbrewer('div','PRGn',50,'cubic'));
cmapd{end+1} = flipud(cbrewer('div','RdBu',50,'cubic'));

cmapd{end+1} = flipud(cbrewer('div','RdYlGn',50,'cubic'));



%% ========================================================================
% 
% =========================================================================


figH = figure(1); clf;
plotSomething(D)
fname = sprintf('%s%s_someFigName.png', figPath, dateStr);
saveFigure(fname,figH)

print(fig, fname,'-dpng')
%% ========================================================================
% 
% =========================================================================





%% ========================================================================
% 
% =========================================================================



%% ========================================================================
% 
% =========================================================================

%% inputparser

function [] = funName(par1, par2, varargin)

p = inputParser();
p.addRequired('par1',@isstruct);
p.addRequired('par2',@isnumeric);colors = hsv(nCond);

p.addParameter('par3', @ischar);
p.addParameter('par4', @ischar);  
p.addOptional('par5',[]);
p.addOptional('par6',[]);


p.parse(par1, par2, varargin{:})
par1 = p.Results.par1;
par2 = p.Results.par2;
par3 = p.Results.par3;
par4 = p.Results.par4;
par5 = p.Results.par5;
par6 = p.Results.par6;

% end input parsing ============================================================



%% Auto axis


axis equal

au = AutoAxis();
au.xUnits = 'mm';
au.yUnits = 'mm';
au.addAutoScaleBarX;
au.addAutoScaleBarY;
au.keepAutoScaleBarsEqual = true;
au.update();


%%

% histogram face color
set(get(gca,'child'),'FaceColor',[41 90 209]./256,'EdgeColor','none');


% RedYelBlue
flipud(cbrewer('div','RdYlBu',50,'cubic'))


%% Soft norm

whichdims = {[1 3], 2};
X = TensorUtils.reshapeByConcatenatingDims(Xin,whichdims);

% apply normalization to full data array
MIN_FIRING_RATE = 10;
normFactors = (range(X,1) + MIN_FIRING_RATE).^-1;

% normFactors = (std(X,0,1) + MIN_FIRING_RATE).^-1;
Xout = bsxfun(@times, X, normFactors);  % normalize

%% Refactor across multiple files from the command line

find armDynamics/ -type f -exec sed -i 's/ArnDyn/ArmDyn/g' {} \;

%% Savetag list

saveTagList = strrep(num2str(makerow(td.getParamUnique('saveTag'))),'  ','_');



