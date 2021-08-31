classdef PositioningMode_Microstep < PositioningMode
    
    methods
        function obj = PositioningMode_Microstep(hstages)
            obj = obj@PositioningMode(hstages);
        end
        
        function moveRel(obj,h,d,f)
            h.fMoveComplete=0; % need add this prop when initiation
            h.SetRelMoveDist(0,d);
            h.MoveRelative(0,0);
            obj.saveImageWhenMoving(f);
        end
        
        function moveAbs(obj,h,d,f)
            h.fMoveComplete=0; % need add this prop when initiation
            h.SetAbsMovePos(0,d);
            h.MoveAbsolute(0,0);
            obj.saveImageWhenMoving(f);
        end
        
    end
end

