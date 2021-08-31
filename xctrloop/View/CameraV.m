classdef CameraV < handle
    properties
        cameraMObj;
        cameraCObj;
        
        %
        vidObj;
        vsrcObj;
        
        % 
        cameraConnectText;
        cameraConnectButton;
        cameraDisconnectButton;
        axCamera;
        hImage;
        setButton;
        saveButton;
        loadButton;
        startPreButton;
        stopPreButton;
        captureTpiButton;
        captureButton;
        
    end
   
    
    methods
        %% constructor
        function obj = CameraV(cameraMObj)
            obj.cameraMObj = cameraMObj;
            obj.cameraCObj = obj.makeContoller();
        end
        %%
        function cameraCObj = makeContoller(obj)
            cameraCObj = CameraC(obj,obj.cameraMObj);
        end
        %%
        function attachToController(obj)
            funcNames = {'cameraConnectButton',...
                'cameraDisconnectButton',...
                'setButton','saveButton',...
                'loadButton',...
                'startPreButton',...
                'stopPreButton',...
                'captureTpiButton',...
                'captureButton'};
            
            if ~obj.cameraMObj.fDeploy || isempty(funcNames)
                return
            end
            
            obj.createCameraObjs();
            
            c = obj.cameraCObj;      
            for k =1:numel(funcNames)
                str = strcat('obj.',funcNames{k},...
                    '.Callback = @c.','callback_',funcNames{k},';');
                eval(str);
            end
        end
        %%
        function createCameraObjs(obj)
            obj.vidObj = ...
                Context.getInstance().getData('mainMObj').configMObj.vid;
            obj.vsrcObj = getselectedsource(obj.vidObj);
            obj.setTriggerManual();
            obj.setGeneralSettingV1_0_31();
            obj.vsrcObj.Exposure = obj.cameraMObj.exposure0; %s
            
            pause(1);
            
            vidRes = get(obj.vidObj, 'VideoResolution'); 
            obj.hImage = image(obj.axCamera,ones(vidRes(2), vidRes(1), 3));
            obj.hImage.Parent.Visible = 'off';
        end
        %%
        function setTriggerManual(obj)
            obj.vidObj.TriggerRepeat = Inf;
            obj.vidObj.FramesPerTrigger = 1;
            triggerconfig(obj.vidObj, 'manual');
        end
        
        function setGeneralSettingV1_0_09(obj)
            obj.vsrcObj.GainIndex = 'Gain 1-HDR';
            obj.vsrcObj.ReadoutRate = 'P0S1: 100MHz, 16b, CMOS';
            obj.vsrcObj.ExposeOutMode = 'First Row';
            obj.vsrcObj.ClearMode = 'Post-Sequence';
            obj.vidObj.Timeout = 1;
        end
        
        function setGeneralSettingV1_0_31(obj)
            obj.vsrcObj.PortSpeedGain = 'Port0-Speed1-100MHz-16bit-Gain1-HDR';
            obj.vsrcObj.ExposeOutMode = 'First Row';
            obj.vsrcObj.ClearMode = 'Post-Sequence';
        end
    end

end