function trialTable = getTrialsBlock(~, blockKey)

    trialStruct = fetch(behavior.TowersBlockTrial & blockKey, '*');
    trialTable = struct2table(trialStruct);

end

