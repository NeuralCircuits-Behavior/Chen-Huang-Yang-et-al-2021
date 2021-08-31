classdef PositioningMode_Microstep2 < PositioningMode
    % 2017/7/26, CH ---------------------------------------------------
    % this mode based on microstep,
    % first move to absolute pos and then move a small rel distance
    % this will shorten move time, but more accurate than use microstep 
    % ------------------------------------------------------------------
    properties
        hstages;
        relMovePauseTime;% s
        absMovePauseTime;% s
    end
    
    
    methods
        function obj = PositioningMode_Microstep2(hstages,...
                relMovePauseTime,absMovePauseTime)
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
h.fMoveComplete = 0; % need add this prop when initiation
h.SetRelMoveDist(0,d);
h.MoveRelative(0,0);
pause(t);
end

function moveAbs(h,d,t)
h.fMoveComplete = 0; % need add this prop when initiation
h.SetAbsMovePos(0,d);
h.MoveAbsolute(0,0);
pause(t);
while ~h.fMoveComplete;pause(0.001);end

h.SetEncPosControlParams(0,2,2,0); % set encoder mode
pos_rel = d - h.GetPosition_Position(0);
h.SetEncPosControlParams(0,1,1,0); % set back to microstep mode

h.fMoveComplete = 0;
h.SetRelMoveDist(0,pos_rel);
h.MoveRelative(0,0);
pause(t);
end