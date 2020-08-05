function displayInfoTrial(obj, session_label, info_table, justinfo)

if nargin == 3
    justinfo = false;
end


disp('_____________________________________________________')
if ~justinfo
    disp(['Trials in key for session: ' session_label]);
else
    disp(['Trials for session: ' session_label]);
end

disp(info_table{:,'info'})


if ~ justinfo
    disp('_____________________________________________________')
    disp('Select only one block and one trial to retrieve video')
    disp(['e.g.'                                    newline ...
        'key.subject_fullname = ''hnieh_E65'''  newline ...
        'key.session_date     = ''2018-02-02''' newline ...
        'key.block            =           1'    newline ...
        'key.trial_idx        =           5'    newline]);
end



end



