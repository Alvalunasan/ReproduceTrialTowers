function blockTable = getBlocksSession(~,subj, date, session_num)

    %Correct info for querying in table
    fq_subj = FormatQuery('subject_fullname', 'CHAR', subj);
    fq_date = FormatQuery('session_date', 'DATE', date);
    fq_sess = FormatQuery('session_number', 'INT', session_num);

    query = fq_subj & fq_date & fq_sess;
    query = query.query_string;
    
    columns = {'task', 'level', 'set_id', 'easy_block'};
    blockStruct = fetch(behavior.TowersBlock & query, columns{:});
    blockTable = struct2table(blockStruct);

end

