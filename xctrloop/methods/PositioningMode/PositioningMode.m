classdef PositioningMode < handle
    properties
        hstages;
    end
    
    methods
        function obj = PositioningMode(hstages)
            obj.hstages = hstages;
        end

        function moveRelX(obj,src,data)
            obj.moveRel(obj.hstages(1),data.distance,data.fSaveImageWhenMoving);
        end
        
        function moveRelY(obj,src,data)
            obj.moveRel(obj.hstages(2),data.distance,data.fSaveImageWhenMoving);
        end
        
        function moveRelZ(obj,src,data)
            obj.moveRel(obj.hstages(3),data.distance,data.fSaveImageWhenMoving);
        end
        
        function moveAbsX(obj,src,data)
            obj.moveAbs(obj.hstages(1),data.distance,data.fSaveImageWhenMoving);
        end
        
        function moveAbsY(obj,src,data)
            obj.moveAbs(obj.hstages(2),data.distance,data.fSaveImageWhenMoving);
        end
        
        function moveAbsZ(obj,src,data)
            obj.moveAbs(obj.hstages(3),data.distance,data.fSaveImageWhenMoving);
        end
        
        function saveImageWhenMoving(obj,f)
            if f
                Context.getInstance().getData('mainMObj').imPipeline.saveImage();
            end
        end
    end

    methods(Abstract)
        moveRel(obj);
        moveAbs(obj);
    end
    
end