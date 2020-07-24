function get_last_version_project(obj, parent_project_path, project_path, project_url)


if ~exist(project_path, 'dir')
    cd(parent_project_path);
    git_command = ['git clone ' project_url];
    status = system(git_command);
else
    cd(project_path)
    git_command = 'git fetch --all';
    status = system(git_command);
    if status == 0
        git_command = 'git checkout master';
        status = system(git_command);
    end
    if status == 0
        git_command = 'git pull';
        status = system(git_command);
    end
end

if status ~= 0
    error(['It was not possible to get last version of the project: ', project_url]);
end


end

