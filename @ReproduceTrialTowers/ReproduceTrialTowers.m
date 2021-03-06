classdef ReproduceTrialTowers
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        dataBasePrefix             = 'u19_'
        dataBaseHost               = 'datajoint00.pni.princeton.edu'
        
        classPath                  = fileparts(mfilename('fullpath'));
        projectPath                = fileparts(ReproduceTrialTowers.classPath);
        virmenPath                 = fullfile(ReproduceTrialTowers.projectPath, 'tankmousevr');
        
        bucketMainPath             = 'mnt/bucket/u19_dj/';
        bucketSecPath              = 'external_files/u19_behavior/TowersBlockTrialVideo';
        bucketPath                 = [ReproduceTrialTowers.bucketMainPath ReproduceTrialTowers.bucketSecPath];
        
        minKeyFields               = {'subject_fullname', 'session_date'};
    end
    
    properties
        djConnection
        sessionKey
        ex_vkeys
        
        bucketVideoPath
        localVideoPath
        videoPrefix
        
    end
    
    methods
        function obj = ReproduceTrialTowers()

            setenv('DB_PREFIX', 'u19_')
            dj.conn(obj.dataBaseHost)
            
            

        end
        
    end
end