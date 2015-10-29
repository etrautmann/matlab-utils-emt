function cmap = rdbu(varargin)

if nargin < 1
    nColor = 50;
end

cmap = flipud(cbrewer('div','RdYlBu',varargin{1},'cubic'));

end
 
 
 