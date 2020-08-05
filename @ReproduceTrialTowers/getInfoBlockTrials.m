function [session_label, info_table] = getInfoBlockTrials(obj, trialVideoTable)

group_table = groupsummary(trialVideoTable, 'block', {'max', 'min'}, {'trial_idx'});

subject = trialVideoTable{1, 'subject_fullname'}{:};
date = trialVideoTable{1, 'session_date'}{:};
sess_no = trialVideoTable{1, 'session_number'}(:);

session_label = [subject ' ' date ' S' num2str(sess_no)];

info_table = rowfun(@(b,mint,maxt) ...
    [' -- block ', num2str(b), ': trials (', num2str(mint), ' - ', num2str(maxt) ') --'], ...
    group_table, 'InputVariables',{'block', 'min_trial_idx', 'max_trial_idx'}, ...
    'OutputVariableName','info');


end