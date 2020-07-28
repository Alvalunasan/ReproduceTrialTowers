function generateVideosSession(obj, key)

if nargin < 1
    error(['A key for the behavioral session is needed:' newline ...
        'e.g.' newline ...
        'key.subject_fullname = ''hnieh_E65''' newline ...
        'key.session_date     = ''2018-02-02''' newline ...
        'ReproduceTrialTowers(key)']);
end

obj.checkfieldsKey(key)
obj.sessionKey = obj.checkUniqueSession(key);
[status, obj.ex_vkeys] = obj.checkAlreadyRun(key);

if status
    
    obj.bucketVideoPath = obj.getBucketPath(get_OS(), obj.bucketSave);
    obj.bucketVideoPath = obj.checkBucketVideoDir(obj.bucketVideoPath, obj.bucketDirectoryName);
    [obj.videoPath,  obj.videoPrefix] = obj.getVideoDirectory(obj.sessionKey);
    
    
    gitUpdate = GitUpdateProject(obj.virmenPath, key.session_date);
    gitUpdate.cherrypick_commit(obj.virmenPath);
    Housekeeping_virmen(obj.projectPath);
    
    obj.processSession(obj.sessionKey);
end

end

