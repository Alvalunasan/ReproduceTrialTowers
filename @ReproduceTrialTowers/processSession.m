function processSession(obj, sessionKey)

blockTable = obj.getBlocksSession(sessionKey);
acqTable =   obj.getAcquisitonSession(sessionKey);

[experCode, experFile, protocolTitle, protocolFun, stimulus_file] = ...
    obj.getExperimentInfo(acqTable);

virmen_eng = MiniVirmenEngine(obj.virmenPath, experCode, experFile, protocolTitle, protocolFun, stimulus_file);

numBlocks = size(blockTable,1);
blockKey = sessionKey;

for j=1:numBlocks
    close all force
    
    virmen_eng.loadVirmen();
    vr = virmen_eng.vr;
    vradd = virmen_eng.vradd;
    
    session_number = blockTable{j, 'session_number'};
    blockKey.block = blockTable{j, 'block'};
    
    vr.mainMazeID = blockTable{j, 'level'};
    vr.mazeID = blockTable{j, 'level'};
    
    trialTable = obj.getTrialsBlock(blockKey);
    trialKey = blockKey;
    trialKey.session_number = session_number;
    
    localVideoPathblock = fullfile(obj.localVideoPath, ['B' num2str(blockKey.block)]);
    bucketVideoPathblock = fullfile(obj.bucketVideoPath, ['B' num2str(blockKey.block)]);
    
    if ispc
        bucketVideoPathblock = strrep(bucketVideoPathblock,'\','/');
    end
    
    if ~exist(localVideoPathblock, 'dir')
        mkdir(localVideoPathblock)
    end
    
    numTrials = size(trialTable,1);
    for k=1:numTrials
        %for k=3:3
        
        ac_trial = trialTable(k,:);
        trialKey.trial_idx = ac_trial.trial_idx;
        
        ex_key = obj.ex_vkeys(obj.ex_vkeys.session_number == trialKey.session_number & ...
            obj.ex_vkeys.block          == trialKey.block          & ...
            obj.ex_vkeys.trial_idx      == trialKey.trial_idx, 'trial_idx');
        
        if isempty(ex_key)
            
            vr.state =  BehavioralState.SetupTrial;
            vr.forcedIndex = Choice.(ac_trial{1,'trial_type'}{:});
            
            stimuli = obj.getStimuli(ac_trial, vr.poissonStimuli.panSession(vr.mazeID,1));
            vr.poissonStimuli.panSession(vr.mazeID,1:3) = repmat(stimuli,1,3);
            
            videoName = [obj.videoPrefix '-B' num2str(blockKey.block) '-T' num2str(k) '.mp4'];
            localVideoNameFull = fullfile(localVideoPathblock, videoName);
            bucketVideoNameFull = fullfile(bucketVideoPathblock, videoName);
            if ispc
                bucketVideoNameFull = strrep(bucketVideoNameFull,'\','/');
            end
            
            trialKey.video_path = bucketVideoNameFull;
            
            video = VideoWriter(localVideoNameFull, 'MPEG-4');
            open(video);
            num_frames = size(ac_trial{1,'position'}{:},1);
            for s=1:num_frames
                
                vr.position(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'position'}{:}(s,:);
                vr.collision = ac_trial{1,'collision'}{:}(s);
                vr.velocity(ExperimentLog.SPATIAL_COORDS) = ac_trial{1,'velocity'}{:}(s,:);
                vr.sensorData(ExperimentLog.SENSOR_COORDS) = ac_trial{1,'sensor_dots'}{:}(s,:);
                
                [err, vr, vradd] = virmen_eng.virmenEngineMinimum(vr, vradd);
                
                if isstruct(err)
                    error(err)
                end
                
                fr = virmenGetFrame(1);
                fr = obj.processFrame(fr);
                
                disp([j numBlocks k numTrials s num_frames])
                writeVideo(video,fr);
                
            end
            close(video);
            
            insert(behavior.TowersBlockTrialVideo, trialKey);
            
        end
    end
    
end

end


