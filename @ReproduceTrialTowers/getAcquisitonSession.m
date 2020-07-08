function acqTable = getAcquisitonSession(~,sessionKey)

    %Correct info for querying in table    
    columns = {'stimulus_bank', 'session_protocol'};
    acqStruct = fetch(acquisition.Session & sessionKey, columns{:});
    acqTable = struct2table(acqStruct,'AsArray',true);

end

