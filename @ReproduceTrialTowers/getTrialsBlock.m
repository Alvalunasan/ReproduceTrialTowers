function trialTable = getTrialsBlock(~,subj, date, session_num, block_num)

    %Correct info for querying in table
    fq_subj = FormatQuery('subject_fullname', 'CHAR', subj);
    fq_date = FormatQuery('session_date', 'DATE', date);
    fq_sess = FormatQuery('session_number', 'INT', session_num);
    fq_block = FormatQuery('block', 'INT', block_num);

    query = fq_subj & fq_date & fq_sess & fq_block;
    query = query.query_string;
    
    trialStruct = fetch(behavior.TowersBlockTrial & query, '*');
    trialTable = struct2table(trialStruct);

end

