classdef ReproduceTrialTowers
    %REPRODUCETRIALTOWERS Summary of this class goes here
    %   Detailed explanation goes here

    properties (Constant)
        DataBasePrefix = 'u19_'
        DataBaseHost = 'datajoint00.pni.princeton.edu'
    end
    
    properties
        DJConnection
        sessionTable
    end
    
    methods
        function obj = ReproduceTrialTowers()
            %REPRODUCETRIALTOWERS Construct an instance of this class
            %   Detailed explanation goes here
            obj.DJConnection = getdjconnection(obj.DataBasePrefix, obj.DataBaseHost);
            obj.sessionTable = obj.getSessions();
            obj.processSessions(obj.sessionTable);
            disp('jajaja');
        end
        
    end
end

