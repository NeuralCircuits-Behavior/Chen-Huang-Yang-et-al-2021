classdef tissueDetectorFactory<handle
    properties
        edObj
        
        fFinished
    end

    methods
        function obj = tissueDetectorFactory(type,edObj)
            switch lower(type)
                case 'auto'
                    obj.edObj = edObj;
                case {'rectangle','rec','rect'}
                    obj.edObj = EdgeDetectDummy();
            end
        end
        
        function detectEdge(obj,m,p)
            obj.edObj.detectEdge(m,p);
        end
    
        function clearDetectionVars(obj)
            obj.edObj.clearDetectionVars();
        end
        
        function setfFinished(obj,val)
            obj.edObj.setfFinished(val);
        end
        
        function fFinished = get.fFinished(obj)
            fFinished = obj.edObj.fFinished;
        end
        
        function clearGUIDisplay(obj)
            obj.edObj.clearGUIDisplay();
        end
    end
end