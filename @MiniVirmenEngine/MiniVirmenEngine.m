classdef MiniVirmenEngine < handle
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        
        classPath                  = fileparts(mfilename('fullpath'));
        exampleTraineeFile         = fullfile(MiniVirmenEngine.classPath,...
            'example_trainee.mat');
        exampleStimulusTraineeFile = fullfile(MiniVirmenEngine.classPath,...
            'example_stimulus_train.mat');
        
        reg_file = 'test_regiment.mat';
    end
    
    properties
        vr
        vradd
        
        virmenPath
        experPath
        protocolPath
        
        exper
        experFile
        experCode
        
        protocolTitle
        protocolFun
        
        trainee
        regiment
        stimFile
        stimulusBank
        
    end
    
    methods
        function obj = MiniVirmenEngine(virmenPath, experCode, experFile, protocolTitle, protocolFun, stimFile)
            
            obj.virmenPath    = virmenPath;
            obj.experPath     = fullfile(obj.virmenPath, 'experiments');
            obj.protocolPath  = fullfile(obj.experPath, 'protocols');
            
            obj.experCode     = experCode;
            obj.experFile     = experFile;
            obj.protocolTitle = protocolTitle;
            obj.protocolFun   = protocolFun;
            obj.stimFile      = stimFile;
            
            obj.regiment = obj.getRegiment(obj.protocolTitle);
            
            obj.stimulusBank = obj.getStimulusBank(obj.stimFile, obj.protocolPath);
            
            obj.trainee = obj.getTrainee(obj.experFile, obj.stimulusBank, obj.protocolFun);
            
            obj.exper = obj.getExper(obj.experFile, obj.experCode);
        end
        
    end
    
end
