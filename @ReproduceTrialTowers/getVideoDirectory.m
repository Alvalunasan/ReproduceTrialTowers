function [local_video_path,  bucket_video_path, video_prefix] = getVideoDirectory(obj, key)

user_id     = rtt_utils.getUserIdFromSubject(key);
date_str    = key.session_date(isstrprop(key.session_date,'digit'));

date_str = [date_str '_S' num2str(key.session_number)];

local_video_path   = fullfile(obj.localVideoPath,user_id, key.subject_fullname, date_str);
video_prefix = [key.subject_fullname '_' date_str];

bucket_video_path = fullfile(obj.bucketVideoPath,user_id, key.subject_fullname, date_str);
if ispc
    bucket_video_path = strrep(bucket_video_path,'\','/');
end
    

end

