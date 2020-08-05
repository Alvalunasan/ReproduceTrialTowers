function [status, ex_video_table] = checkAlreadyRun(obj, key)

status = true;
ex_video_table = obj.getTrialVideoTable(key);
ex_trials_table = obj.getTrialsBlock(key, false);

all_run = size(ex_video_table,1) == size(ex_trials_table,1);
partial_run = ~isempty(ex_video_table) && ~all_run;

reload_table = false;

if (all_run)
    s = input('This selection has already been processed into videos. Overwrite ? (y/n) ', 's');
    if s == 'y' || s=='Y'
        del(behavior.TowersBlockTrialVideo & key);
        status = true;
        reload_table = true;
    elseif s == 'n' || s=='N'
        status = false;
    else
        error('Not a valid answer');
    end
end

if (partial_run)
    
    video_info_table = obj.getInfoBlockTrials(ex_video_table);
    trials_info_table =  obj.getInfoBlockTrials(ex_trials_table);
    
    disp(newline)
    disp('There are missing trials to process.')
    disp('______________________________________________________')
    disp('Next trials are already processed for selected session')
    disp(video_info_table{:,'info'})
    disp('______________________________________________________')
    disp('Next trials conform the entire selection')
    disp(trials_info_table{:,'info'})
    
    s = input([newline 'What do you want to do?' newline ... 
              'Complete process  (c)' newline ...
              'Overwrite session (o)' newline ...
              'Nothing           (n) '], 's');
    if s == 'o' || s=='O'
        del(behavior.TowersBlockTrialVideo & key);
        status = true;
        reload_table = true;
    elseif s == 'c' || s=='C'
        status = true;
    elseif s == 'n' || s=='N'
        status = false;
    else
        error('Not a valid answer');
    end
end

if reload_table
    ex_video_table = obj.getTrialVideoTable(key);
end


