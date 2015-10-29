function [cellOut] = structField2cell(structIn, fieldName)
% TODO
%
% emt, 12/25/2013


for ii = 1:length(structIn)
    cellOut{ii} = structIn(ii).(fieldName);
    
end


end