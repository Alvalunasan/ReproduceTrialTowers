function processSessions(obj,sessionTable)

numSessions = size(sessionTable,1);
%for i = 1:numSessions
for i = 1:10
    
    ac_subject_fullname = sessionTable{i, 'subject_fullname'};
    ac_session_date = sessionTable{i, 'session_date'};
    ac_session_number = sessionTable{i, 'session_number'};
    blockTable = obj.getBlocksSession(ac_subject_fullname,  ac_session_date, ac_session_number);
    
    numBlocks = size(blockTable,1);
    for j=1:numBlocks
        
        ac_num_block = blockTable{i, 'block'};
        
        trialTable = obj.getTrialsBlock(ac_subject_fullname,  ac_session_date, ac_session_number, ac_num_block);
        
        
    end
    
    
end



end
