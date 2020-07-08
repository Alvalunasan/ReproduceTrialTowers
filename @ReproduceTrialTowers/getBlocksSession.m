function blockTable = getBlocksSession(~,sessionkey)

    %Correct info for querying in table    
    columns = {'task', 'level', 'set_id', 'easy_block', 'n_trials', 'first_trial'};
    blockStruct = fetch(behavior.TowersBlock & sessionkey, columns{:});
    blockTable = struct2table(blockStruct);

end

