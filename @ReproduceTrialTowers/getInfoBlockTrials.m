function [info_table, session_label] = getInfoBlockTrials(obj, trialVideoTable)

% convert the "groups" variable into a categorical array. This looks the same on the outside, but internally, MATLAB has grouped identical elements together.
trialVideoTable.blockcat = categorical(trialVideoTable.block);
% use grpstats to sum the values by the groups

group_table = varfun(@max,trialVideoTable, ...
    'InputVariables', {'trial_idx', 'block'}, ...
    'GroupingVariable','blockcat');

mintable = varfun(@min,trialVideoTable, ...
    'InputVariables', 'trial_idx', ...
    'GroupingVariable','blockcat');

group_table.min_trial_idx = mintable.min_trial_idx;

%For newer versions of Matlab, same work with less lines
%group_table = groupsummary(trialVideoTable, 'block', {'max', 'min'}, {'trial_idx'});

fm = '%03.f';
fm2 = '%02.f';
info_table = rowfun(@(b,mint,maxt,grp) ...
    [' -- block ', num2str(b,fm2), ': #trials =  ' num2str(grp,fm) ' (from ', num2str(mint,fm), ' to ', num2str(maxt,fm) ') --'], ...
    group_table, 'InputVariables',{'max_block', 'min_trial_idx', 'max_trial_idx', 'GroupCount'}, ...
    'OutputVariableName','info');

subject = trialVideoTable{1, 'subject_fullname'}{:};
date = trialVideoTable{1, 'session_date'}{:};
sess_no = trialVideoTable{1, 'session_number'}(:);

session_label = [subject ' ' date ' S' num2str(sess_no)];

end