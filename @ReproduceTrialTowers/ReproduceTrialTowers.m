classdef ReproduceTrialTowers
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        DataBasePrefix             = 'u19_'
        DataBaseHost               = 'datajoint00.pni.princeton.edu'
        virmenPath                 = 'C:\Users\BrainCogs_Projects\tankmousevr\'
        videoPath                 =  'C:\Users\BrainCogs_Projects\ReproduceTrialTowersData\Videos';
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
        DJConnection
        sessionKey
        
        vr
        exper
        experFile
        experCode
        protocolTitle
        protocolFun
        trainee
        regiment
        stimulusBank
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
            
            obj.DJConnection = getdjconnection(obj.DataBasePrefix, obj.DataBaseHost);
            obj.checkKey(key)
            obj.checkUniqueSession(key);
            obj.sessionKey = key;
            obj.processSession(obj.sessionKey);
            disp('jajaja');
            
            
        end
        
    end
end