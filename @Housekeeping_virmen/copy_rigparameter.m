function copy_rigparameter(obj, source, destination)
%COPY_RIGPARAMETER Summary of this function goes here
%   Detailed explanation goes here

status = copyfile(source, destination);

if ~status
    error('RigParameter file couldn''t be copied')
end

end

