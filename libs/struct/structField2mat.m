function [matOut] = structField2mat(structIn, fieldName)
% TODO
%
% emt, 12/25/2013


for ii = 1:length(structIn)
    cellTmp{ii} = structIn(ii).(fieldName);
end

matOut = cell2mat(cellTmp);

end