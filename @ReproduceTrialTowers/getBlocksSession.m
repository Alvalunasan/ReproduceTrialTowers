function blockTable = getBlocksSession(~,sessionkey)

%Correct info for querying in table
columns = {'task', 'level', 'set_id', 'easy_block', 'n_trials', 'first_trial'};
blockStruct = fetch(behavior.TowersBlock & sessionkey, columns{:});

if ~isempty(blockStruct)
    blockTable = struct2table(blockStruct, 'AsArray', true);
else
    fields = fieldnames(blockStruct);
    blockTable = cell2table(cell(0, length(fields)), 'VariableNames', fields);
end

end

