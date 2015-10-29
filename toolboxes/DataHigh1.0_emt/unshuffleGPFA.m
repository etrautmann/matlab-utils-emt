function [seqOut] = unshuffleGPFA(seqOrig, seqGPFA)
% helper function to unshuffle the trials produced by GPFA

nTr = length(seqOrig);

idsOrig = [seqOrig.trialId];
idsGPFA = [seqGPFA.trialId];


for iTr = 1:nTr 
	
    ind = find(idsGPFA == idsOrig(iTr));
    seqOut(iTr) = seqGPFA(ind);

    
end






end