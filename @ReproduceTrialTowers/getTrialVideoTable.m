function trialVideoTable = getTrialVideoTable(obj, key)

trialVideoStruct = fetch(behavior.TowersBlockTrialVideo & key, '*');

if ~isempty(trialVideoStruct)
    trialVideoTable = struct2table(trialVideoStruct, 'AsArray', true);
else
    fields = fieldnames(trialVideoStruct);
    trialVideoTable = cell2table(cell(0, length(fields)), 'VariableNames', fields);
end


end
