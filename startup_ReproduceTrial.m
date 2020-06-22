
matlabDir = fullfile(getenv('HOME'), 'Documents', 'MATLAB');
datajointDir = fullfile(matlabDir, 'BrainCogsProjects', 'Datajoint_proj', 'datajoint-matlab');
pipelineMatlabDir = fullfile(matlabDir, 'BrainCogsProjects', 'Datajoint_proj', 'U19-pipeline-matlab');
reproduceTrialsDir = fullfile(matlabDir, 'BrainCogsProjects', 'ReproduceTrialTowers');
 
addpath (genpath(fullfile(datajointDir)));
addpath (genpath(fullfile(reproduceTrialsDir))); 
addpath (genpath(fullfile(pipelineMatlabDir))); 
