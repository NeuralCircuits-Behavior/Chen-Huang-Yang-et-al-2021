classdef DisplayPositionFeature < event.EventData
    properties
        mark;
        stxy_plot;

    end
    
    methods
        function obj = DisplayPositionFeature(stxy_plot,mark)
            obj.mark = mark;
            obj.stxy_plot = stxy_plot;
        end
    end
    
end