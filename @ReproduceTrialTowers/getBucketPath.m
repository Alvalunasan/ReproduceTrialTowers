function bucket_path = getBucketPath(obj, os, bucket_save)

key.system = os;
key.global_path = bucket_save;

bucket_path = fetch1(lab.Path & key, 'net_location');

if ~exist(bucket_path, 'dir')
    if ~isempty(bucket_path)
        error(['net location: ' bucket_path 'not mounted in system. Mount the network drive and try again'])
    else
        error(['network location not found in lab.Path table'])
    end
end

