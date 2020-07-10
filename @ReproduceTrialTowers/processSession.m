function processSession(obj, sessionKey)

blockTable = obj.getBlocksSession(sessionKey);
acqTable =   obj.getAcquisitonSession(sessionKey);

[obj.experCode, obj.experFile, obj.protocolTitle, obj.protocolFun] = ...
    obj.getExperimentInfo(acqTable);

obj.regiment = obj.getRegiment(obj.protocolTitle);

obj.stimulusBank = obj.getStimulusBank(acqTable, obj.protocolPath);

obj.trainee = obj.getTrainee(obj.experFile, obj.stimulusBank, obj.protocolFun);

obj.exper = obj.getExper(obj.experFile, obj.experCode);


sessionname = [sessionKey.subject_fullname '-' sessionKey.session_date '-S' ...
         num2str(sessionKey.session_number)];

lPath = fullfile(ReproduceTrialTowers.videoPath, sessionname)
rPath = [obj.bucketPath  '/' sessionname]

if ~exist(lPath, 'dir')
    mkdir(lPath);
end
mkdir_ssh(rPath);

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
    
    if isstruct(err)   
        error(err)
    end
    
    vr.forcedTypes = Choice.all;
    vr.position = zeros(1,4);
    vr.velocity = zeros(1,4);
    vr.sensorData = zeros(1,5);
    vr.exper.transformationFunction = str2func('transformPerspectiveMex');
    
    %Each time a block is changed, compute new world...
    %computeWorld(vr)
    
    session_number = blockTable{j, 'session_number'};
    blockKey.block = blockTable{j, 'block'};
    
    vr.mainMazeID = blockTable{j, 'level'};
    vr.mazeID = blockTable{j, 'level'};
    vr.updateReward = 0;
    
    trialTable = obj.getTrialsBlock(blockKey);
    trialKey = blockKey;
    trialKey.session_number = session_number;
    
    numTrials = size(trialTable,1);
    
    for k=1:numTrials
    %for k=3:3
                
        vr.state =  BehavioralState.SetupTrial;
        ac_trial = trialTable(k,:);
        trialKey.trial_idx = ac_trial.trial_idx;
        
        num_frames = size(ac_trial{1,'position'}{:},1);
        stimuli = obj.getStimuli(ac_trial, vr.poissonStimuli.panSession(vr.mazeID,1));
        
        vr.forcedIndex = Choice.(ac_trial{1,'trial_type'}{:});
        
        %Bug in Matlab 2015 to pass entire struct
        %fields = fieldnames(stimuli);
        %for idxfield = 1:length(fields)
        %    acfield = fields(idxfield);
            vr.poissonStimuli.panSession(vr.mazeID,1) = stimuli;
            vr.poissonStimuli.panSession(vr.mazeID,2) = stimuli;
            vr.poissonStimuli.panSession(vr.mazeID,3) = stimuli;
        %end
                
        videoname = [sessionname '-B' num2str(blockKey.block) '-T' num2str(k) '.mp4'];
        video = VideoWriter(fullfile(lPath, videoname), 'MPEG-4');
        open(video);
        %videof = uint8(1088, 1792, 3, num_frames);
        for s=1:num_frames
            %for l=1:10
            
            vr.position(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'position'}{:}(s,:);
            vr.collision = ac_trial{1,'collision'}{:}(s);
            vr.velocity(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'velocity'}{:}(s,:);
            vr.sensorData(ExperimentLog.SENSOR_COORDS) = ac_trial{1,'sensor_dots'}{:}(s,:);
            
            [err, vr, vradd] = virmenEngineMinimum(vr, vradd);
            
            if isstruct(err)  
                error(err)
            end
            
            fr = virmenGetFrame(1);
            if size(fr,1) > 1088
                fr = fr(1:1088,:,:);
            end
            
            fr(:,:,1) = fr(:,:,2);
            fr = rgb2gray(fr);
            fr = flip(fr ,1); 
            
%             if s == 1
%                 videof = uint8(fr(:,:,3)*255);
%             else
%                 videof(:,:,end+1) = uint8(fr(:,:,3)*255);
%             end
            
            [j numBlocks k numTrials s num_frames]
            writeVideo(video,fr);
            
        end
        remotefilepath = [rPath '/' videoname];
        close(video);
        sftp_video(lPath,videoname,rPath);
        
        trialKey.filepath = remotefilepath;
        
        insert(behavior.TowersBlockTrialVideo, trialKey);
        
    end
    
end
close all force


end


