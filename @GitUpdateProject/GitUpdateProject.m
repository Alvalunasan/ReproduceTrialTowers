classdef GitUpdateProject
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
    
        veto_dirs           =  {'.git'}
        cherry_picks        = {'1df1e3004dc19ba6366a6487f103a71f1b619b1e'}
        project_url         = 'https://bitbucket.org/sakoay/tankmousevr.git'
    end
    
    properties
        parent_path
        project_path
        commit_date
        
    end
    
    methods
        function obj = GitUpdateProject(project_path, commit_date)
            
            obj.parent_path = fileparts(project_path);
            obj.project_path = project_path;
            obj.commit_date = commit_date;
            
            obj.get_last_version_project(obj.parent_path, obj.project_path, obj.project_url);
            
            commit_id = obj.get_commit_version(project_path, commit_date);
            obj.update_project_commit(project_path, commit_id);
            
        end
        
        
    end
    
end

