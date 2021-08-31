classdef EdgeDetect < handle
    properties
        dirObj;
    end
    
    methods(Abstract)
        detectEdge(obj);
        clearDetectionVars(obj);
        setfFinished(obj,val);
        clearGUIDisplay(obj);
        updateGUIDisplay(obj);
    end
end