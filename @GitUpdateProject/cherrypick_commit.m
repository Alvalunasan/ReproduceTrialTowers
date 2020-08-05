function cherrypick_commit(obj, project_path)


cd(project_path)
status = 0;

%git_command = ['git cherry-pick ' obj.cherry_picks{1} '^..' obj.cherry_picks{end}];
%status = system(git_command);

for i=1:length(obj.cherry_picks)
    
    if status == 0
        git_command = ['git cherry-pick ' obj.cherry_picks{i}];
        status = system(git_command);
    end
end

if status ~= 0
    error('It was not possible to cherry-pick some commits');
end


end



