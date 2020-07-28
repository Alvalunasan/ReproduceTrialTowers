function exper = getExper(obj, experFile, experCode)

load(fullfile(obj.experPath, experFile));

if ~exist('exper', 'var')
    error([fullfile(obj.experPath, experFile) ' does not contain a exper file']);
end

exper.experimentCode = experCode;