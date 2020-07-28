function remove_project_path(obj, project_path)

warning_id = 'MATLAB:rmpath:DirNotFound';
warning('off', warning_id);
rmpath(genpath(project_path));
warning('on', warning_id);

end