classdef MoveMode < event.EventData
    properties
        mode;
    end
    
    methods
        function obj = MoveMode(mode)
            obj.mode = mode;
        end
    end
    
end