classdef ObjectiveC < handle
    properties
        objectiveMObj;
        objectiveVObj;
    end
    
    methods
        function obj = ObjectiveC(v,m)
            obj.objectiveVObj = v;
            obj.objectiveMObj = m;
            st = Context.getInstance().getData('mainMObj').stageMObj;
            st.addlistener('iniAgain',@obj.callback_raiseButton);
        end   
        
        function callback_to16XButton(obj,src,data)
            if isequal(obj.objectiveMObj.xState,'16X')
                return
            end
            obj.objectiveMObj.shiftObjective_16x();
        end
        
        function callback_to40XButton(obj,src,data)
            if isequal(obj.objectiveMObj.xState,'40X')
                return
            end
            obj.objectiveMObj.shiftObjective_40x();
        end
        
        function callback_raiseButton(obj,src,data)
            if isequal(obj.objectiveMObj.zState,'Defocus')
                return
            end
            obj.objectiveMObj.raiseObjectives();
        end
        
        function callback_pulldownButton(obj,src,data)
            if isequal(obj.objectiveMObj.zState,'Focus')
                return
            end
            obj.objectiveMObj.pulldownObjectives();
        end
        
        function callback_setFocusPlaneButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            if ~m.stageMObj.fFinishIni 
                msgbox('Please initiate stages first.');
                return
            elseif ~m.piezoMObj.fFinishIni
                msgbox('Please initiate piezo first.');
                return
            end
            obj.objectiveMObj.focusPlane = m.stageMObj.getZCurrentPosition();
            LogClass.getInstance().writeLog(...
                sprintf('Set Focus plane at %.4f mm.',...
                obj.objectiveMObj.focusPlane));
        end
        
        function callback_alignButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            obm = m.objectiveMObj;
            vtm = m.vtMObj;
            if isempty(vtm.bladePlane)
                msgbox('Please section first.');
                return
            elseif isempty(obm.focusPlane)
                msgbox('Please set focus plane first.');
                return
            end
            
            delta  = round(abs(obm.focusPlane-vtm.bladePlane)...
                *1000/obm.stepResolution);
            if obm.focusPlane > vtm.bladePlane
                obm.lowerPosition = obm.lowerPosition - delta;
            elseif obm.focusPlane < vtm.bladePlane
                obm.lowerPosition = obm.lowerPosition + delta;
            elseif obm.focusPlane == vtm.bladePlane
                msgbox('Focus and blade plane have been already aligned.');
                obm.fFinishAlignment = 1;
                return
            end
            m.stageMObj.moveAbsolute('Z',vtm.bladePlane);
            m.stageMObj.waitForStageStatic();
            obm.pulldownObjectives();
            
            obm.fFinishAlignment = 1;
            msgbox('Finish alignment between focus and blade plane.');
            LogClass.getInstance().writeLog('Align focus and blade plane.');
        end
    end
    
end