classdef StageSpeed < event.EventData
    properties
        axis;
        newSpeed;
    end

    methods
        function obj = StageSpeed(axis,newSpeed)
            obj.axis = axis;
            obj.newSpeed = newSpeed;
        end
    end
end