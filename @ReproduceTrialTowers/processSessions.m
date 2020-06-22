function processSessions(obj,sessionTable)

numSessions = size(sessionTable,1);
%for i = 1:numSessions
for i = 100:100
    
    ac_subject_fullname = sessionTable{i, 'subject_fullname'};
    ac_session_date = sessionTable{i, 'session_date'};
    ac_session_number = sessionTable{i, 'session_number'};
    blockTable = obj.getBlocksSession(ac_subject_fullname,  ac_session_date, ac_session_number);
    acqTable =   obj.getAcquisitonSession(ac_subject_fullname,  ac_session_date, ac_session_number);
    
    numBlocks = size(blockTable,1);
    session_protocol = split(acqTable{1,'session_protocol'}," ");
    obj.experCode = session_protocol{1};
    obj.experCode = str2func(strrep(obj.experCode,'.m',''));
    obj.experFile = session_protocol{2};
    obj.protocolFile = session_protocol{3};
    protocolTitle = strrep(obj.protocolFile,'.m','');
    protocolFun = str2func(protocolTitle);
    
    
    load(fullfile(obj.experPath, obj.experFile));
    exper.experimentCode = obj.experCode;
    
   
    reg_file = 'test_regiment.mat';
    vr.regiment   = TrainingRegiment( protocolTitle, reg_file , '');
    
    obj.trainee.protocol = protocolFun;
    obj.trainee.experiment = fullfile(obj.experPath, obj.experFile);
    if ~isempty(acqTable{1,'stimulus_bank'}{:})
        [~, stimFile, ext] = acqTable{1,'stimulus_bank'}{:};
        obj.trainee.stimulusBank = fullfile(obj.protocolPath, [stimFile, ext]);
    else
        obj.trainee.stimulusBank = fullfile(ReproduceTrialTowers.exampleStimulusTraineeFile);
    end
    
    obj.trainee.mainMazeID = 1;
    vr.trainee = obj.trainee;
    
    exper.userdata = vr;
    
    [mazes, criteria, globalSettings, vr] = protocolFun(vr);
    [err, vr, vradd] = virmenEngineStartup(exper);
    
    vr.forcedTypes = Choice.all;
    vr.position = zeros(1,4);
    vr.velocity = zeros(1,4);
    vr.sensorData = zeros(1,5);
    vr.exper.transformationFunction = str2func('transformPerspectiveMex');
    
    %for j=1:numBlocks
    for j=3:3
        
        
        %Get maze id and stuff like decideMazeAdvancement function
        %vr.mainMazeID 
        %vr.warmupIndex      = 0;
        %vr.mazeID      
        %vr.easyBlockFlag = 0;
        %vr.updateReward  = 0;
        
        
        %Each time a block is changed, compute new world...
        %computeWorld(vr)
        
        ac_num_block = blockTable{j, 'block'};
        
        vr.mainMazeID = blockTable{j, 'level'};
        vr.mazeID = blockTable{j, 'level'};
        vr.updateReward = 0;
        
        trialTable = obj.getTrialsBlock(ac_subject_fullname,  ac_session_date, ac_session_number, ac_num_block);
        
        numTrials = size(trialTable,1);
        
               
        
        %for k=1:numTrials
        for k=6:6
            ac_trial = trialTable(k,:);
            
            
            num_frames = size(ac_trial{1,'position'}{:},1);
            left_pos = ac_trial{1,'cue_pos_left'}{:};
            right_pos = ac_trial{1,'cue_pos_right'}{:};
            
            
            leftCombo = ac_trial{1,'cue_presence_left'}{:};
            rightCombo = ac_trial{1,'cue_presence_right'}{:};
            nleft = sum(leftCombo);
            nright = sum(rightCombo);
            stimuli.cueCombo = [leftCombo; rightCombo];
            
            if nleft >= nright
                stimuli.nSalient = nleft;
                stimuli.nDistract = nright;
            else
                stimuli.nSalient = nright;
                stimuli.nDistract = nleft;
            end
            
            if nleft == 0
                left_pos = repmat(-1,size(left_pos));
            end
            if nright == 0
                right_pos = repmat(-1,size(right_pos));
            end
            
            stimuli.cuePos = {left_pos, right_pos};
            stimuli.index = -1;
            vr.forcedIndex = Choice.(ac_trial{1,'trial_type'}{:});
            %vr.forcedTrials = 
            
            %cfgIndex = vr.poissonStimuli.cfgIndex;
            %vr.poissonStimuli.panSession(cfgIndex,1) = stimuli;
            %vr.poissonStimuli.panSession(cfgIndex,2) = stimuli;
            %vr.poissonStimuli.panSession(cfgIndex,3) = stimuli;
            vr.poissonStimuli.panSession(vr.mazeID,1) = stimuli;
            vr.poissonStimuli.panSession(vr.mazeID,2) = stimuli;
            vr.poissonStimuli.panSession(vr.mazeID,3) = stimuli;

            
            %             'cue_presence_left';
            %             'cue_presence_right';
            %             'cue_onset_left';
            %             'cue_onset_right';
            %             'cue_offset_left';
            %             'cue_offset_right';
            %             'cue_pos_left';
            %             'cue_pos_right';
            
            % With cue pos, presence, offset and pos make
            
            %initializeTrialWorld(vr)
            % function like drawCueSequence(vr)
            % configureCues(vr)
            
            
            video = VideoWriter(fullfile(ReproduceTrialTowers.classPath, 'TowerTrial5.avi'));
            open(video);
            for s=1:num_frames
            %for l=1:10
                
                vr.position(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'position'}{:}(s,:);
                vr.collision = ac_trial{1,'collision'}{:}(s);
                vr.velocity(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'velocity'}{:}(s,:);
                vr.sensorData(ExperimentLog.SENSOR_COORDS) = ac_trial{1,'sensor_dots'}{:}(s,:);

                [err, vr, vradd] = virmenEngineMinimum(vr, vradd);
                
                fr = virmenGetFrame(1);
                s
                err
                writeVideo(video,fr);
                
                %dbInfo.velocity = ac_trial{1,'velocity'}(l);
                
            end
            close(video);
        end
        
    end
    
    
end



end
