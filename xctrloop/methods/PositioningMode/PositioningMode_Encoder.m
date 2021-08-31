classdef PositioningMode_Encoder < PositioningMode
    
    methods
        function obj = PositioningMode_Encoder(hstages)
            obj = obj@PositioningMode(hstages);
        end
        
        function moveRel(obj,h,d,f)
            h.fMoveComplete = 0; % need add this prop when initiation
            h.MoveRelativeEnc(0,d,0,0,0);
            obj.saveImageWhenMoving(f);
        end
        
        function moveAbs(obj,h,d,f)
            h.fMoveComplete = 0; % need add this prop when initiation
            h.MoveAbsoluteEnc(0,d,0,0,0);
            obj.saveImageWhenMoving(f);
        end
    end

end

