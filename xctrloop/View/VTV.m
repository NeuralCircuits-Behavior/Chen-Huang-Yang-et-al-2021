classdef VTV < handle
    % 2018/4/23,CH
    % 
    
    properties
        vtMObj;
        vtCObj;
        
        pinEdit;
        sampleSpeedEdit;
        stopCutPositionEdit
        startCutPositionEdit;
        stepSizeEdit;
        
        
        bladeOffsetEdit;
        
        stateText; %togglebutton
        sectionButton;
        switchButton;
    end

    methods
        function obj = VTV(vtMObj)
            obj.vtMObj = vtMObj;
            obj.makeContoller();
            
            obj.vtMObj.addlistener('updateGUI',@obj.updateState);
            obj.vtMObj.addlistener('getParameters',@obj.getParameters);
        end
        
        function updateState(obj,src,data)
            set_ = @(v,s,c)set(obj.stateText,'Value',v,'String',s,...
                'BackgroundColor',c);
            if src.state
                set_(0,'ON',[0.47,0.67,0.19]);
                LogClass.getInstance().writeLog('Vibration ON');
            else
                set_(0,'OFF',[0.64,0.08,0.18]);
                LogClass.getInstance().writeLog('Vibration OFF');
            end
        end
        
        function getParameters(obj,src,data)
            src.pin = obj.pinEdit.String; 
            src.sampleSpeed = str2double(obj.sampleSpeedEdit.String); 
            src.stopCutPosition = str2double(obj.stopCutPositionEdit.String);
            src.startCutPosition = str2double(obj.startCutPositionEdit.String);
            src.stepSize = str2double(obj.stepSizeEdit.String)/1000;
            src.bladeOffset = 0;
        end
        
        function makeContoller(obj)
            obj.vtCObj = VTC(obj,obj.vtMObj);
        end
        
        function attachToController(obj)          
            c = obj.vtCObj;
            funcNames = {'switchButton','sectionButton'};
            if ~obj.vtMObj.fDeploy || isempty(funcNames)
                return
            end
            for k =1:numel(funcNames)
                str = strcat('obj.',funcNames{k},...
                    '.Callback = @c.','callback_',funcNames{k},';');
                eval(str);
            end
        end
    end







end