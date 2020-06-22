function acqTable = getAcquisitonSession(~,subj, date, session_num)

    asArray = false;
    %Correct info for querying in table
    fq_subj = FormatQuery('subject_fullname', 'CHAR', subj);
    fq_date = FormatQuery('session_date', 'DATE', date);
    fq_sess = FormatQuery('session_number', 'INT', session_num);

    query = fq_subj & fq_date & fq_sess;
    query = query.query_string;
    
    columns = {'stimulus_bank', 'session_protocol'};
    acqStruct = fetch(acquisition.Session & query, columns{:});
    if length(acqStruct) == 1
        asArray = true;
    end
    
    acqTable = struct2table(acqStruct,'AsArray',asArray);

end

