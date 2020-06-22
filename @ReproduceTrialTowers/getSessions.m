function sessionTable = getSessions(~)


    columns = {'maze_id', 'num_towers_r', 'num_towers_l'};

    %Correct info for querying in table
    fq_subj = FormatQuery('subject_fullname', 'CHAR', 'hnieh_E88');
    query = fq_subj;
    query = query.query_string;
    
    %sessionStruct = fetch(behavior.TowersSession & query);
    sessionStruct = fetch(behavior.TowersSession & query , columns{:});
    sessionTable = struct2table(sessionStruct);

end

