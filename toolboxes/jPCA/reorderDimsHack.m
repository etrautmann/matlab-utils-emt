% Currently phaseSpace (and phaseMovie) are set up to plot planes.
% Under certain circumstances you might wish to plot the first jPC versus the 3rd (or the same but
% with the PCs)
% This hack is provided to allow you do do that.  For example, to make a movie of the first versus the third jPC:
% movieParams.plane2plot = 1;
% phaseMovie(reorderDimsHack(Projection, [1 3 1 1 1 1 1 1]), Summary, movieParams);
%
function Proj = reorderDimsHack(Proj, newOrder)

for i = 1:length(Proj)
    Proj(i).proj = Proj(i).proj(:,newOrder);
    Proj(i).projAllTimes = Proj(i).projAllTimes(:,newOrder);
    Proj(i).tradPCAproj = Proj(i).tradPCAproj(:,newOrder);
    Proj(i).tradPCAprojAllTimes = Proj(i).tradPCAprojAllTimes(:,newOrder);
end

