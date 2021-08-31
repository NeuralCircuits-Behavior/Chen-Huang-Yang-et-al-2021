classdef PositioningMode_Microstep2 < PositioningMode
    % 2017/7/26, CH ---------------------------------------------------
    % this mode based on microstep,
    % first move to absolute pos and then move a small rel distance
    % this will shorten move time, but more accurate than use microstep 
    % ------------------------------------------------------------------
    
    methods
        function obj = PositioningMode_Microstep2(hstages)
            obj = obj@PositioningMode(hstages);
        end
        
        function moveRel(obj,h,d,f)
            h.fMoveComplete = 0; % need add this prop when initiation
            h.SetRelMoveDist(0,d);
            h.MoveRelative(0,0);
            obj.saveImageWhenMoving(f);
        end
        
        function moveAbs(obj,h,d,f)
            h.fMoveComplete = 0; % need add this prop when initiation
            h.SetAbsMovePos(0,d);
            h.MoveAbsolute(0,0);
            obj.saveImageWhenMoving(f);
            while ~h.fMoveComplete;pause(0.0015);end
            
            h.SetEncPosControlParams(0,2,2,0); % set encoder mode
            pos_rel = d - h.GetPosition_Position(0);
            h.SetEncPosControlParams(0,1,1,0); % set back to microstep mode
            
            h.fMoveComplete = 0;
            h.SetRelMoveDist(0,pos_rel);
            h.MoveRelative(0,0);
            %}
        end
    end
end

