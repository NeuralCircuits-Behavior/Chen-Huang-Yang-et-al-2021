classdef MoveDistanceData < event.EventData
    properties
        distance;
        fSaveImageWhenMoving;
    end

    methods
        function obj = MoveDistanceData(distance,fSaveImageWhenMoving)
            obj.distance = distance;
            obj.fSaveImageWhenMoving = fSaveImageWhenMoving;
        end
    end
end