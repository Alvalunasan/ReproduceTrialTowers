function bucket_path = checkBucketVideoDir(obj, network_path, video_dir)

bucket_path = fullfile(network_path, video_dir);

if ~exist(bucket_path, 'dir')
    error('parent directory for videos not found, contact admin')
end

