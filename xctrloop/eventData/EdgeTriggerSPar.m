classdef EdgeTriggerSPar < event.EventData
    properties
        t; % tcp communication obj
    end

    methods
        function obj = EdgeTriggerSPar(t)
            obj.t = t;
        end
    end
end