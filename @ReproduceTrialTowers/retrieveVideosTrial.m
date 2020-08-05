function video = retrieveVideosTrial(obj, key)

if nargin < 1
    error(['A key for the behavioral session is needed:' newline ...
        'e.g.' newline ...
        'key.subject_fullname = ''hnieh_E65'''  newline ...
        'key.session_date     = ''2018-02-02''' newline ...
        'key.block            =           1'    newline ...
        'key.trial_idx        =           5'    newline ...
        'rtt = ReproduceTrialTowers()'          newline ...
        'rtt.retrieveVideosTrial(key)']);
end

obj.checkfieldsKey(key)
[~, sesskey] = obj.checkUniqueSession(key);
triaVideoTable = obj.getTrialVideoTable(key);

if size(triaVideoTable,1) == 1
    bucket_video_path = triaVideoTable{1, 'video_path'}{:};
    [~, localVideoPath] = rtt_utils.get_path_from_official_dir(bucket_video_path);
    rtt_utils.assert_mounted_location(localVideoPath, 'file');
    video = VideoReader(localVideoPath);
    
    
elseif size(triaVideoTable,1) > 1
    key
    warning('Multiple trials for key found in database')
    [session_label, info_table] = obj.getInfoBlockTrials(triaVideoTable);
    obj.displayInfoTrial(session_label, info_table, false)
    
else
    key
    warning('Key for trial video not found in database')
    SessionVideoTable = obj.getTrialVideoTable(sesskey);
    [session_label, info_table] = obj.getInfoBlockTrials(SessionVideoTable);
    obj.displayInfoTrial(session_label, info_table, true)
    

    
    
end





