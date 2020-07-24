function [status, existing_videokeys] = check_already_run(obj, key)

status = true;
existing_videokeys = fetch(behavior.TowersBlockTrialVideo2 & key);
existing_trialkeys = fetch(behavior.TowersBlockTrial & key);

all_run = length(existing_videokeys) == length(existing_trialkeys);
partial_run = ~isempty(existing_videokeys) && ~all_run;

if (all_run)
    s = input('This session has already been processed into videos. Overwrite ? (y/n) ', 's');
    if s == 'y' || s=='Y'
        del(behavior.TowersBlockTrialVideo2 & key);
        status = true;
    elseif s == 'n' || s=='N'
        status = false;
    else
        error('Not a valid answer');
    end
end

if (partial_run)
    s = input(['There are missing trials to process.' newline ...
              'What do you want to do?' newline ... 
              'Complete process  (c)' newline ...
              'Overwrite session (o)' newline ...
              'Nothing           (n) '], 's');
    if s == 'o' || s=='O'
        del(behavior.TowersBlockTrialVideo2 & key);
        status = true;
    elseif s == 'c' || s=='C'
        status = true;
    elseif s == 'n' || s=='N'
        status = false;
    else
        error('Not a valid answer');
    end
end

existing_videokeys = fetch(behavior.TowersBlockTrialVideo2 & key);
if ~isempty(existing_videokeys)
    existing_videokeys = struct2table(existing_videokeys, 'AsArray', true);
else
    fields = fieldnames(existing_videokeys);
    existing_videokeys = cell2table(cell(0, length(fields)), 'VariableNames', fields);
end


