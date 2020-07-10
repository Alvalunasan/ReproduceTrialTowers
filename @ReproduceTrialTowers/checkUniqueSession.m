function key = checkUniqueSession(~, key)

    if ~isfield(key,'session_number')
        key.session_number = 0;
    end

    sessionStruct = fetch(behavior.TowersSession & key);
    if isempty(sessionStruct)
        error('No session found with provided key');
    elseif length(sessionStruct) > 1
        error('More than one session found with key, (maybe session_number missing)');
    end
     
end

