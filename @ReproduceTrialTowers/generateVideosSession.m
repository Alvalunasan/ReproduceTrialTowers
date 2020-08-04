function generateVideosSession(obj, key)

if nargin < 1
    error(['A key for the behavioral session is needed:' newline ...
        'e.g.' newline ...
        'key.subject_fullname = ''hnieh_E65'''  newline ...
        'key.session_date     = ''2018-02-02''' newline ...
        'rtt = ReproduceTrialTowers()'          newline ...
        'rtt.generateVideosSession(key)']);
end

obj.checkfieldsKey(key)
obj.sessionKey = obj.checkUniqueSession(key);
[status, obj.ex_vkeys] = obj.checkAlreadyRun(key);

if status
        
    gitUpdate = GitUpdateProject(obj.virmenPath, key.session_date);
    gitUpdate.cherrypick_commit(obj.virmenPath);
    Housekeeping_virmen(obj.projectPath);
    
    [obj.bucketVideoPath, obj.localVideoPath] = rtt_utils.get_path_from_official_dir(obj.bucketPath);
    rtt_utils.assert_mounted_location(obj.localVideoPath);
    [obj.localVideoPath, obj.bucketVideoPath,  obj.videoPrefix] = obj.getVideoDirectory(obj.sessionKey);
    
    obj.processSession(obj.sessionKey);
    
end

end

