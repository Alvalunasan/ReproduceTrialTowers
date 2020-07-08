function trainee = getTrainee(obj, experFile, stimulusBank, protocolFun)

load(ReproduceTrialTowers.exampleTraineeFile);

if ~exist('trainee', 'var')
    error([ReproduceTrialTowers.exampleTraineeFile ' does not contain a trainee file']);
end

trainee.protocol = protocolFun;
trainee.experiment = fullfile(obj.experPath, experFile);
trainee.stimulusBank = stimulusBank;
trainee.mainMazeID = 1;

end