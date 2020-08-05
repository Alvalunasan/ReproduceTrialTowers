function [key, only_session_key] = checkUniqueSession(~, key)

    if ~isfield(key,'session_number')
        key.session_number = 0;
    end

    sessionStruct = fetch(behavior.TowersSession & key);
    if isempty(sessionStruct)
        error('No session found with provided key');
    elseif length(sessionStruct) > 1
        error('More than one session found with key, (maybe session_number missing)');
    end
    
    %If it's a subselection of a session:
    %Check if it's not empty
    if isfield(key, 'block') || isfield(key, 'trial_idx')
        existing_trialkeys = fetch(behavior.TowersBlockTrial & key);

        if isempty(existing_trialkeys)
            disp(key)
            error('There are no trials for current selection')
        end
    end
    
    only_session_key.subject_fullname = key.subject_fullname;
    only_session_key.session_date     = key.session_date;
    only_session_key.session_number   = key.session_number;
     
end

