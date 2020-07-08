function processSession(obj, sessionKey)

blockTable = obj.getBlocksSession(sessionKey);
acqTable =   obj.getAcquisitonSession(sessionKey);

[obj.experCode, obj.experFile, obj.protocolTitle, obj.protocolFun] = ...
    obj.getExperimentInfo(acqTable);

obj.regiment = obj.getRegiment(obj.protocolTitle);

obj.stimulusBank = obj.getStimulusBank(acqTable, obj.protocolPath);

obj.trainee = obj.getTrainee(obj.experFile, obj.stimulusBank, obj.protocolFun);

obj.exper = obj.getExper(obj.experFile, obj.experCode);


numBlocks = size(blockTable,1);
blockKey = sessionKey;

for j=1:numBlocks
    close all force
    
    vr = [];
    
    vr.regiment   = obj.regiment;
    vr.trainee    = obj.trainee;
    
    exper = obj.exper;
    exper.userdata = vr;
    
    [mazes, criteria, globalSettings, vr] = obj.protocolFun(vr);
    [err, vr, vradd] = virmenEngineStartup(exper);
    
    vr.forcedTypes = Choice.all;
    vr.position = zeros(1,4);
    vr.velocity = zeros(1,4);
    vr.sensorData = zeros(1,5);
    vr.exper.transformationFunction = str2func('transformPerspectiveMex');
    
    %Each time a block is changed, compute new world...
    %computeWorld(vr)
    
    blockKey.block = blockTable{j, 'block'};
    
    vr.mainMazeID = blockTable{j, 'level'};
    vr.mazeID = blockTable{j, 'level'};
    vr.updateReward = 0;
    
    trialTable = obj.getTrialsBlock(blockKey);
    
    numTrials = size(trialTable,1);
    
    %for k=1:numTrials
    for k=3:3
        
        vr.state =  BehavioralState.SetupTrial;
        ac_trial = trialTable(k,:);
        
        num_frames = size(ac_trial{1,'position'}{:},1);
        stimuli = obj.getStimuli(ac_trial);
        
        vr.forcedIndex = Choice.(ac_trial{1,'trial_type'}{:});
        vr.poissonStimuli.panSession(vr.mazeID,1) = stimuli;
        vr.poissonStimuli.panSession(vr.mazeID,2) = stimuli;
        vr.poissonStimuli.panSession(vr.mazeID,3) = stimuli;
                
        videoname = [blockKey.subject_fullname '-' blockKey.session_date '-B' ...
            num2str(blockKey.block) '-T' num2str(k) '.mp4'];
        video = VideoWriter(fullfile(ReproduceTrialTowers.videoPath, videoname), 'MPEG-4');
        open(video);
        for s=1:num_frames
            %for l=1:10
            
            vr.position(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'position'}{:}(s,:);
            vr.collision = ac_trial{1,'collision'}{:}(s);
            vr.velocity(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'velocity'}{:}(s,:);
            vr.sensorData(ExperimentLog.SENSOR_COORDS) = ac_trial{1,'sensor_dots'}{:}(s,:);
            
            [err, vr, vradd] = virmenEngineMinimum(vr, vradd);
            
            fr = virmenGetFrame(1);
            [j numBlocks k numTrials s num_frames]
            writeVideo(video,fr);
            
        end
        close(video);
    end
    
end
close all force


end


