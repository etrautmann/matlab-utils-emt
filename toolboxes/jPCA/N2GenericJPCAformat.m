% For converting an N structure into the generic data format that can be fed to jPCA.
% Here we are calling zero the time that firing rates begin to change rapidly.
%
function Data = N2GenericJPCAformat(N)

numConds = length(N(1).cond);
numNeurons = length(N);
numTimes = length(N(1).interpTimes.times);

riseThresh = 0.5;
lat = moveActivityLatency(N, riseThresh);

for c = 1:numConds
    Data(c).A = zeros(numTimes,numNeurons);
    Data(c).times = N(1).interpTimes.times' - N(1).interpTimes.moveStarts - lat;  % zero is now set to be when rates begin to change rapidly
    Data(c).timesWRTmove = N(1).interpTimes.times' - N(1).interpTimes.moveStarts;  % not used by jPCA, but keep for posterity
    
    for n = 1:numNeurons
        Data(c).A(:,n) = N(n).cond(c).interpPSTH;
    end
    
end