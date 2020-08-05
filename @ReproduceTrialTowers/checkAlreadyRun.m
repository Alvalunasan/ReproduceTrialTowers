function [status, existing_videokeys] = checkAlreadyRun(obj, key)

status = true;
video_table = obj.getTrialVideoTable(key);
trials_table = obj.getTrialsBlock(key, false);

all_run = size(video_table,1) == size(trials_table,1);
partial_run = ~isempty(video_table) && ~all_run;

if (all_run)
    s = input('This selection has already been processed into videos. Overwrite ? (y/n) ', 's');
    if s == 'y' || s=='Y'
        del(behavior.TowersBlockTrialVideo & key);
        status = true;
    elseif s == 'n' || s=='N'
        status = false;
    else
        error('Not a valid answer');
    end
end

if (partial_run)
    
    video_info_table = obj.getInfoBlockTrials(video_table);
    trials_info_table =  obj.getInfoBlockTrials(trials_table);
    
    disp('There are missing trials to process.')
    disp('Next trials are already processed for selected session')
    disp(video_info_table{:,'info'})
    disp('Next trials conform the entire selection')
    disp(trials_info_table{:,'info'})
    
    s = input(['What do you want to do?' newline ... 
              'Complete process  (c)' newline ...
              'Overwrite session (o)' newline ...
              'Nothing           (n) '], 's');
    if s == 'o' || s=='O'
        del(behavior.TowersBlockTrialVideo & key);
        status = true;
    elseif s == 'c' || s=='C'
        status = true;
    elseif s == 'n' || s=='N'
        status = false;
    else
        error('Not a valid answer');
    end
end

existing_videokeys = fetch(behavior.TowersBlockTrialVideo & key);
if ~isempty(existing_videokeys)
    existing_videokeys = struct2table(existing_videokeys, 'AsArray', true);
else
    fields = fieldnames(existing_videokeys);
    existing_videokeys = cell2table(cell(0, length(fields)), 'VariableNames', fields);
end


