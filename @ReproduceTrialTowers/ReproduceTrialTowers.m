classdef ReproduceTrialTowers
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        dataBasePrefix             = 'u19_'
        dataBaseHost               = 'datajoint00.pni.princeton.edu'
        projectPath                = fileparts(fileparts(mfilename('fullpath')))
        virmenPath                 = fullfile(ReproduceTrialTowers.projectPath, 'tankmousevr');
        videoPath                  = fullfile(ReproduceTrialTowers.projectPath, 'ReproduceTrialTowersData', 'Videos');
        bucketPathWin              = 'Z:\TowersTaskPlayBackVideos';
        bucketPathLin              = '/mnt/bucket/braininit/TowersTaskPlayBackVideos';
        experPath                  = fullfile(ReproduceTrialTowers.virmenPath, 'experiments');
        protocolPath               = fullfile(ReproduceTrialTowers.experPath, 'protocols');
        classPath                  = fileparts(mfilename('fullpath'));
        exampleTraineeFile         = fullfile(ReproduceTrialTowers.classPath,...
            'example_trainee.mat');
        exampleStimulusTraineeFile = fullfile(ReproduceTrialTowers.classPath,...
            'example_stimulus_train.mat');
        
        minKeyFields               = {'subject_fullname', 'session_date'};
        
        reg_file = 'test_regiment.mat';
    end
    
    properties
        djConnection
        sessionKey
        user_id
        
        vr
        exper
        experFile
        experCode
        protocolTitle
        protocolFun
        trainee
        regiment
        stimulusBank
        ex_vkeys
    end
    
    methods
        function obj = ReproduceTrialTowers(key)
            
            
            if nargin < 1
               error(['A key for the behavioral session is needed:' newline ...
               'e.g.' newline ...    
               'key.subject_fullname = ''hnieh_E65''' newline ...
               'key.session_date     = ''2018-02-02''' newline ...
               'ReproduceTrialTowers(key)']); 
            end
            
            
            obj.djConnection = getdjconnection(obj.dataBasePrefix, obj.dataBaseHost);
                        
            obj.checkfieldsKey(key)
            obj.sessionKey = obj.checkUniqueSession(key);
            obj.user_id = obj.get_userid(key);
            [status, obj.ex_vkeys] = obj.check_already_run(key);
            if status
                
                git_u = GitUpdateProject(obj.virmenPath, key.session_date);
                git_u.cherrypick_commit(obj.virmenPath);
                obj.processSession(obj.sessionKey);
                disp('jajaja');
            end
            
        end
        
    end
end