classdef EdgeDetectDummy < EdgeDetect
    % ------------------
    % 2019/9/3
    % use for rectangle impelement
    % 
    % 
    % ------------------
        
    properties(Transient, SetAccess = public)
        fFinished = 0;
    end
    
    events
        newDetection;
    end

    methods
        %%
        function obj = EdgeDetectDummy()
            u = Context.getInstance().getData('mainVObj').userVObj;
            obj.addlistener('newDetection',@u.clearDisplayPos);
        end
        %%
        function detectEdge(obj,m,p) 
            obj.writeResult(m,p);
            obj.fFinished = 1;
        end
       %%
        function clearDetectionVars(obj)
            obj.fFinished = 0;
        end
        %%
        function setfFinished(obj,val)
            obj.fFinished = val;
        end
        %%
        function clearGUIDisplay(obj)
            obj.notify('newDetection');
        end
        %%
        function updateGUIDisplay(obj)
        end
    end
    
    methods(Access = private)
        %%
        function writeResult(obj,m,p)
            p.edPositions{p.nROIsDetermination}=[];
            p.edRelTo1stPos{p.nROIsDetermination}=[];
            p.edDirIdx{p.nROIsDetermination}=[];
        end
    end
    
end
