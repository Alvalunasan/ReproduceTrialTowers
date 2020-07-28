function stimulusBank = getStimulusBank(obj, stimFile, protocolPath)

if ~isempty(stimFile)
    stimulusBank = fullfile(protocolPath, [stimFile, ext]);
else
    stimulusBank = fullfile(obj.exampleStimulusTraineeFile);
end