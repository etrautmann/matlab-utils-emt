

function [comboN, Nsingle, Narray] = combineSingleArray(Nsingle, Narray, mazeSet, minRange)

% make sure the datasets being combined use the same time base.
if ~isequal(Nsingle(1).interpTimes.times, Narray(1).interpTimes.times) && Nsingle(1).interpTimes.moveStarts == Narray(1).interpTimes.moveStarts
    disp('Error, times not aligned the same way for single electrode and array data');
    return;
end


%% down-select to the conditions corresponding to the asked-for maze set
if exist('mazeSet', 'var') && ~isempty(mazeSet)
    
    % restrict the single electrode data to the right maze set
    Nsingle = Nsingle([Nsingle.mazeSet]==mazeSet);
    
    % slightly more complicated for the array data: must find the conds that match the single
    % electrode data and use them.
    protoTrials = [Nsingle(1).cond.protoTrial];
    goodConds = [protoTrials.mazeID];
    
    protoTrialsArray = [Narray(1).cond.protoTrial];
    arrayConds = [protoTrialsArray.mazeID];
    
    for n = 1:length(Narray)
        Narray(n).cond = Narray(n).cond(ismember(arrayConds, goodConds));
        Narray(n).mazeSet = mazeSet;
    end
    
    for n = 1:length(Nsingle)
        Nsingle(n).oneForPMdtwoforM1 = 1 + (Nsingle(n).anterior<=0);
    end
    
end


%% remove any fields that aren't shared (otherwise we can't combine)
fieldsSingle = fieldnames(Nsingle);
fieldsArray = fieldnames(Narray);

% remove, from Nsingle, those fields not in Narray
goodFields = ismember(fieldsSingle, fieldsArray);
Nsingle = rmfield(Nsingle, fieldsSingle(~goodFields));

% remove, from Narray, those fields not in Nsingle
goodFields = ismember(fieldsArray, fieldsSingle);
Narray = rmfield(Narray, fieldsArray(~goodFields));

comboN = [Nsingle, Narray];
comboN = comboN([comboN.totalDynamicRange] > minRange);
