classdef DistFromCenterData < event.EventData
    properties
        dist;
        % 2019/9/3, for 'rectangle',[a,b,c,d]
        %         a
        %   c - center - d
        %         b
        
    end
    
    methods
        function obj = DistFromCenterData(dist)
            obj.dist = dist;
        end
    end
    
end