function MV = rotationMovie(Projection, Summary, times, steps2fullRotation, numSteps2show, pixelsToGet)


reusePlot = false;

for step = 1:numSteps2show
    
    
    rotate2jPCA(Projection, Summary, times, steps2fullRotation, step, reusePlot)
    reusePlot = true;
    
    drawnow;
    
    if nargout > 0
        MV(step) = getframe(gca, pixelsToGet);
    end
    
end

