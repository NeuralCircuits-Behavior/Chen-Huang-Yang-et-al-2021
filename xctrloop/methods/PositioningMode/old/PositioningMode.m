classdef PositioningMode < handle
    properties
        
    end
    
    
    methods(Abstract)
        moveRelX(obj);
        moveRelY(obj);
        moveRelZ(obj);
        
        moveAbsX(obj);
        moveAbsY(obj);
        moveAbsZ(obj);
    end
    

    
end