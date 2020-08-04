function video = retrieveVideosTrial(obj, key)

if nargin < 1
    error(['A key for the behavioral session is needed:' newline ...
        'e.g.' newline ...
        'key.subject_fullname = ''hnieh_E65'''  newline ...
        'key.session_date     = ''2018-02-02''' newline ...
        'key.block            =           1'    newline ...
        'key.trial            =           5'    newline ...
        'rtt = ReproduceTrialTowers()'          newline ...
        'rtt.retrieveVideosTrial(key)']);
end

obj.checkfieldsKey(key)
obj.checkUniqueSession(key);
triaVideoTable = obj.getTrialVideoTable(key);

if size(triaVideoTable,1) == 1
    bucket_video_path = triaVideoTable{1, 'video_path'}{:};
    [~, localVideoPath] = rtt_utils.get_path_from_official_dir(bucket_video_path);
    rtt_utils.assert_mounted_location(localVideoPath, 'file');
    video = VideoReader(localVideoPath);
    
    
elseif size(triaVideoTable,1) > 1
    
    obj.getInfoBlockTrials(triaVideoTable)
    
    error('Many trials in this key')
else
    error('Key for trial video not found in database')
end





