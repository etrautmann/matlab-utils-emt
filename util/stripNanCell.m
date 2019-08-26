function [dataOut, inds] = stripNanCell(dataIn)
%
% removes all elements of a tensor along any dimension in which at least
% one element is nan.

% EMT 2017-12-21
% EMT 2019-01-08: this function didn't work, reverted to old functioning
% code

if isnumeric(dataIn)
    dataIn = {dataIn};
end
    
dataOut = dataIn;
for iCell = 1:numel(dataIn)    
    inds = ~isnan(dataIn{iCell});
    dataOut{iCell} = dataIn{iCell}(inds);
end


