function [] = setFigPosition(figH, figContext)
%
%
% EMT - 2016-02-07

screensize = get( groot, 'Screensize' );

switch figContext
    case 'analysis'
    
    
    case 'presentation'
        set(figH, 'WindowStyle', 'normal')
        figSize = [800 800];
        
        figX = screensize(3) - figSize(1);
        figY = screensize(4) - figSize(2);
        pause(.1)
        set(figH,'Position',[figX figY figSize])
        
    case 'presentation-hires'
        SCALE = 2;
        set(figH, 'WindowStyle', 'normal')
        figSize = SCALE*[800 500];
        
        figX = screensize(3) - figSize(1);
        figY = screensize(4) - figSize(2);
        pause(.1)
        set(figH,'Position',[figX figY figSize])
        
        
    case 'publication'
        set(figH, 'WindowStyle', 'normal')
        figSize = [1000 1000];
        
        figX = screensize(3) - figSize(1);
        figY = screensize(4) - figSize(2);
        
        set(figH,'Position',[figX figY figSize])
        

end

