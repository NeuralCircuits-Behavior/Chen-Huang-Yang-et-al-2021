classdef DetectedDir < handle
    properties
        dir_detected;
    end

    methods(Abstract)
        getDetectedDir(obj);
    end

end