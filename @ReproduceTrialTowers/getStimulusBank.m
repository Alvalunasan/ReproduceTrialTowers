function stimulusBank = getStimulusBank(~, acqTable, protocolPath)

if ~isempty(acqTable{1,'stimulus_bank'}{:})
    [~, stimFile, ext] = acqTable{1,'stimulus_bank'}{:};
    stimulusBank = fullfile(protocolPath, [stimFile, ext]);
else
    stimulusBank = fullfile(ReproduceTrialTowers.exampleStimulusTraineeFile);
end