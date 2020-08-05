function trialTable = getTrialsBlock(~, blockKey, all_fields)

if nargin < 3
    all_fields = true;
end

if all_fields
    trialStruct = fetch(behavior.TowersBlockTrial & blockKey, '*');
else
    trialStruct = fetch(behavior.TowersBlockTrial & blockKey);
end

%Converts one row tables to cell when there are vectors
if size(trialStruct,1) == 1
    fields = fieldnames(trialStruct);
    for i=1:length(fields)
        fi = fields{i};
        if ~ischar(trialStruct.(fi)) && length(trialStruct.(fi)) > 1
            disp('aqui si paso')
            trialStruct.(fi) = {trialStruct.(fi)};
        end
    end
    
end

if ~isempty(trialStruct)
    trialTable = struct2table(trialStruct, 'AsArray', true);
else
    fields = fieldnames(trialStruct);
    trialTable = cell2table(cell(0, length(fields)), 'VariableNames', fields);
end

end

