function loadVirmen(obj)

    obj.vr = [];
    
    obj.vr.regiment   = obj.regiment;
    obj.vr.trainee    = obj.trainee;
    
    obj.exper.userdata = obj.vr;
    obj.vr.position = zeros(1,4);
    
    mazes = obj.protocolFun(obj.vr);
    [err, obj.vr, obj.vradd] = obj.virmenEngineStartup(obj.exper);
    
    obj.vr.sensorData = zeros(1,5);
    obj.vr.updateReward = 0;
    obj.vr.velocity = zeros(1,4);
    obj.vr.forcedTypes = Choice.all;
    obj.vr.exper.transformationFunction = str2func('transformPerspectiveMex');
        
    if isstruct(err)
        error(err)
    end
    
end

