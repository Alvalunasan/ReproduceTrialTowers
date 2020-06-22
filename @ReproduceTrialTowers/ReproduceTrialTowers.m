classdef ReproduceTrialTowers
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here

    properties (Constant)
        DataBasePrefix             = 'u19_'
        DataBaseHost               = 'datajoint00.pni.princeton.edu'
        virmenPath                 = 'C:\Users\BrainCogs_Projects\tankmousevr\'
        experPath                  = fullfile(ReproduceTrialTowers.virmenPath, 'experiments');
        protocolPath               = fullfile(ReproduceTrialTowers.experPath, 'protocols');
        classPath                  = fileparts(mfilename('fullpath'));
        exampleTraineeFile         = fullfile(ReproduceTrialTowers.classPath,...
                                            'example_trainee.mat');
        exampleStimulusTraineeFile = fullfile(ReproduceTrialTowers.classPath,...
                                            'example_stimulus_train.mat');
    end
    
    properties
        DJConnection
        sessionTable
        vr
        experFile
        experCode
        protocolFile
        trainee
    end
    
    methods
        function obj = ReproduceTrialTowers()
            %REPRODUCETRIALTOWERS Construct an instance of this class
            %   Detailed explanation goes here
            
            load(ReproduceTrialTowers.exampleTraineeFile);
            obj.trainee = trainee;
            obj.DJConnection = getdjconnection(obj.DataBasePrefix, obj.DataBaseHost);
            obj.sessionTable = obj.getSessions();
            obj.processSessions(obj.sessionTable);
            disp('jajaja');
            
        end
        
    end
end

