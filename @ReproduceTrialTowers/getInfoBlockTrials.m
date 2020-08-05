function [info_table, session_label] = getInfoBlockTrials(obj, trialVideoTable)


% convert the "groups" variable into a categorical array. This looks the same on the outside, but internally, MATLAB has grouped identical elements together.
trialVideoTable.blockcat = categorical(trialVideoTable.block);
% use grpstats to sum the values by the groups
maxarray = grpstats(trialVideoTable.trial_idx, trialVideoTable.blockcat, {@max});
minarray = grpstats(trialVideoTable.trial_idx, trialVideoTable.blockcat, {@min});

maxtable = varfun(@max,trialVideoTable, ...
    'InputVariables', {'trial_idx', 'block'}, ...
    'GroupingVariable','blockcat');

mintable = varfun(@min,trialVideoTable, ...
    'InputVariables', 'trial_idx', ...
    'GroupingVariable','blockcat');

maxtable.min_trial_idx = mintable.min_trial_idx;


%group_table = groupsummary(trialVideoTable, 'block', {'max', 'min'}, {'trial_idx'});

subject = trialVideoTable{1, 'subject_fullname'}{:};
date = trialVideoTable{1, 'session_date'}{:};
sess_no = trialVideoTable{1, 'session_number'}(:);

session_label = [subject ' ' date ' S' num2str(sess_no)];

fm = '%03.f';
fm2 = '%02.f';
info_table = rowfun(@(b,mint,maxt,grp) ...
    [' -- block ', num2str(b,fm2), ': #trials =  ' num2str(grp,fm) ' (from ', num2str(mint,fm), ' to ', num2str(maxt,fm) ') --'], ...
    maxtable, 'InputVariables',{'max_block', 'min_trial_idx', 'max_trial_idx', 'GroupCount'}, ...
    'OutputVariableName','info');


end