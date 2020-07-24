function commit = get_commit_version(obj, project_path, session_date)

cd(project_path);

git_command = ['git log -1 --before="' session_date  '" --pretty=format:"%H"'];
[status,commit] = system(git_command);

if status ~= 0
    error('It was not possible to get commit id from project');
end


end

