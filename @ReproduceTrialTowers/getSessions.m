function sessionTable = getSessions(~)


    %columns = {'maze_id', 'num_towers_r', 'num_towers_l'};
    %sessionStruct = fetch(behavior.TowersSession, columns{:});
    sessionStruct = fetch(behavior.TowersSession);
    sessionTable = struct2table(sessionStruct);

end

