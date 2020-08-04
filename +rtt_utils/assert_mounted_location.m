function assert_mounted_location(directory, type)

if nargin == 1
    type = 'dir';
end

if ~exist(directory, type)
    error ([directory ' is not mounted in your system'])
end
