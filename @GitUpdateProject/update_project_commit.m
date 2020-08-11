function update_project_commit(obj, project_path, commit_id)

cd(project_path);

git_command = ['git checkout ' commit_id];
[status,info] = system(git_command);
if status ~= 0
    error('It was not possible to get checkout project from commit id');
end


end

