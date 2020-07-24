function checkfieldsKey(obj, key)

for i=1:length(ReproduceTrialTowers.minKeyFields)
    ackey = ReproduceTrialTowers.minKeyFields{i};
    
    
    if ~isfield(key, ackey)
        error(['Missing field in key to search session: ' ackey]);
    end
    
end

end