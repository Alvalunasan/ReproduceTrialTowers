function [video_path,  video_prefix] = getVideoDirectory(obj, key)

user_id     = obj.getUserId(key);
date_str    = key.session_date(isstrprop(key.session_date,'digit'));

video_path   = fullfile(obj.bucketVideoPath,user_id, key.subject_fullname, date_str);
video_prefix = [key.subject_fullname '-' date_str '-S' num2str(key.session_number)];

if ~exist(video_path, 'dir')
     mkdir(video_path);
end

end

