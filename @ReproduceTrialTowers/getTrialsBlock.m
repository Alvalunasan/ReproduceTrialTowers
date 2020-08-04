function trialTable = getTrialsBlock(~, blockKey)

trialStruct = fetch(behavior.TowersBlockTrial & blockKey, '*');

if ~isempty(trialStruct)
    trialTable = struct2table(trialStruct, 'AsArray', true);
else
    fields = fieldnames(trialStruct);
    trialTable = cell2table(cell(0, length(fields)), 'VariableNames', fields);
end


end

