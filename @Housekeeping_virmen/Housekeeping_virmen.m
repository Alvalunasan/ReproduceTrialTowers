classdef Housekeeping_virmen
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here
    
     properties (Constant)
         
        classPath             = fileparts(mfilename('fullpath'));
        virmen_repo_name      = 'tankmousevr'
        rig_param_file        = 'RigParameters.m'
        rig_param_pathfile    = fullfile('extras', 'RigParameters.m');
        binary_search_path    = fullfile('experiments', 'utility', 'binarySearch.c');

    end
    
    properties
        virmenPath
        rigparamfile
        rigparamfile_virmen
        binarysearchfile
        this_mex_ext
        
    end
    
    methods
        function obj = Housekeeping_virmen(parent_path)
            
            obj.virmenPath                 = fullfile(parent_path, obj.virmen_repo_name);
            obj.rigparamfile               = fullfile(obj.classPath, obj.rig_param_file);
            obj.rigparamfile_virmen        = fullfile(obj.virmenPath, obj.rig_param_pathfile);
            obj.binarysearchfile           = fullfile(obj.virmenPath, obj.binary_search_path);
                
            obj.this_mex_ext               = get_mex_ext();
            
            obj.copy_rigparameter(obj.rigparamfile, obj.rigparamfile_virmen);
            obj.installGitHooks(obj.virmenPath);
            obj.check_compile_file(obj.binarysearchfile, obj.this_mex_ext);
            addpath(genpath(obj.virmenPath));
            rmpath(fullfile(obj.virmenPath, '.git'));
            
        end
        
    end
    
end

