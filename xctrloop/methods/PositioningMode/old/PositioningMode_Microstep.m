classdef PositioningMode_Microstep < PositioningMode
    properties
        hstages;
        relMovePauseTime;% s
        absMovePauseTime;% s
    end
    
    
    methods
        function obj = PositioningMode_Microstep(hstages,relMovePauseTime,absMovePauseTime)
            obj.hstages = hstages;
            obj.relMovePauseTime = relMovePauseTime;
            obj.absMovePauseTime = absMovePauseTime;
        end
        
        function moveRelX(obj,src,data)
            moveRel(obj.hstages(1),data.distance,obj.relMovePauseTime);
        end
        
        function moveRelY(obj,src,data)
             moveRel(obj.hstages(2),data.distance,obj.relMovePauseTime);
        end
        
        function moveRelZ(obj,src,data)
            moveRel(obj.hstages(3),data.distance,obj.relMovePauseTime);
        end
        
        function moveAbsX(obj,src,data)
            moveAbs(obj.hstages(1),data.distance,obj.absMovePauseTime);
        end

        function moveAbsY(obj,src,data)
            moveAbs(obj.hstages(2),data.distance,obj.absMovePauseTime);
        end
        
        function moveAbsZ(obj,src,data)
            moveAbs(obj.hstages(3),data.distance,obj.absMovePauseTime);
        end
    end
end

function moveRel(h,d,t)
h.fMoveComplete=0; % need add this prop when initiation
h.SetRelMoveDist(0,d);
h.MoveRelative(0,0);
pause(t);
end

function moveAbs(h,d,t)
h.fMoveComplete=0; % need add this prop when initiation
h.SetAbsMovePos(0,d);
h.MoveAbsolute(0,0);
pause(t);
end