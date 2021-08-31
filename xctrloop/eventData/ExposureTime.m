classdef ExposureTime < event.EventData
    properties
        time;
    end
    
    methods
        function obj = ExposureTime(time)
            obj.time = time;
        end
    end
    
end