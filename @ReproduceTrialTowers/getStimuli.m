function stimuli = getStimuli(obj, ac_trial)


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

end