

%% inputparser

function [] = funName(par1, par2, varargin)

p = inputParser();
p.addRequired('par1',@isstruct);
p.addRequired('par2',@isnumeric);
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