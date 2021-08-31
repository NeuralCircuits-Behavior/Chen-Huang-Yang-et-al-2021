classdef CameraC < handle
    properties
        cameraVObj;
        cameraMObj;        
    end
    
    properties(Transient)
        cen_ind; % one ROI center
    end
    
    methods
        %%
        function obj = CameraC(cameraVObj,cameraMObj)
            obj.cameraMObj = cameraMObj;
            obj.cameraVObj = cameraVObj;            
            obj.cameraMObj.addlistener('captureImageNow',@obj.imageCapture);
            obj.cameraMObj.addlistener('captureImageEM',@obj.imageCapture);
            obj.cameraMObj.addlistener('captureImageES',@obj.imageCapture);
            obj.cameraMObj.addlistener('getdata',@obj.getData);
            obj.cameraMObj.addlistener('hardwareTrigger',@obj.switch2HardwareTrigger);
            obj.cameraMObj.addlistener('internalTrigger',@obj.switch2AInternalTrigger);
            obj.cameraMObj.addlistener('expUpdated',@obj.changeExposureTime);
            obj.cameraMObj.addlistener('getRunningState',@obj.isCameraRunning);
            obj.cameraMObj.addlistener('getFramesAvailable',@obj.getFramesAvailable);
        end
        %%
        function getFramesAvailable(obj,src,event)
            src.nFramesAvailable = obj.cameraVObj.vidObj.FramesAvailable;
        end
        %%
        function isCameraRunning(obj,src,event)
            src.isRunning = isequal(obj.cameraVObj.vidObj.Running,'on');
        end
        %%
        function imageCapture(obj,src,event)
            % maybe need a factory class to deal with diff trigger
            %{
                    % slow
                    stoppreview(obj.cameraVObj.vidObj);
                    start(obj.cameraVObj.vidObj);
            %}
            pause(double(obj.cameraVObj.vsrcObj.Exposure)/1000*1);
            trigger(obj.cameraVObj.vidObj);
            pause(0.002); % nessary
            %ims = getdata(obj.cameraVObj.vidObj,2); % get 2 frames
            obj.cameraMObj.im_captured = getdata(obj.cameraVObj.vidObj);
            %obj.cameraMObj.im_captured = ims(:,:,1,end);
        end
        %%
        function captureImageEM(obj,src,event)
            % not use
        end
        
        %%
        function captureImageES(obj,src,event)
            % not use
        end
        %%
        function changeExposureTime(obj,srcs,event)
            vid = obj.cameraVObj.vidObj;
            src = obj.cameraVObj.vsrcObj;
            
            if isrunning(vid)
                stop(vid);
                running = 1;
            else
                running = 0;
            end
            
            src.Exposure = event.time;
            
            if running
                start(vid);
            end
        end
        %%
        function getData(obj,src,event)
            try
                obj.cameraMObj.im_captured = ...
                    getdata(obj.cameraVObj.vidObj,event.framesN);
            catch
                %keyboard;
                obj.cameraVObj.vidObj.Timeout = 1;
                start(obj.cameraVObj.vidObj);
                return
            end
        end
        %%
        function switch2HardwareTrigger(obj,srcs,event)
            vid = obj.cameraVObj.vidObj;
            src = obj.cameraVObj.vsrcObj;
            
            if isrunning(vid)
                stop(vid);
                running = 1;
            else
                running = 0;
            end
            
            vid.TriggerRepeat = inf;
            vid.FramesPerTrigger = 1;
            vid.Timeout = 20;
            src.CircularBufferEnabled = 'ON';
            src.ClearMode = 'Never';
            src.ExposeOutMode = 'First Row';
            src.TriggerMode = 'Edge Trigger';
            triggerconfig(vid, 'hardware', 'Falling edge', 'Extern');
            
            if running
                start(vid);
            end
        end
        %%
        function switch2AInternalTrigger(obj,srcs,event)
            vid = obj.cameraVObj.vidObj;
            src = obj.cameraVObj.vsrcObj;
            
            if isrunning(vid)
                stop(vid);
                running = 1;
            else
                running = 0;
            end
            
            vid.TriggerRepeat = inf;
            vid.FramesPerTrigger = 1;
            vid.Timeout = 20;
            src.CircularBufferEnabled = 'ON';
            src.ClearMode = 'Never';
            src.ExposeOutMode = 'First Row';
            src.TriggerMode = 'Internal Trigger';
            triggerconfig(vid, 'manual');
            
            if running
                start(vid);
            end
        end
        %%
        
        %%
        function callback_cameraConnectButton(obj,src,event)
            if obj.cameraVObj.cameraConnectText.Value
                return
            end
            
            obj.callback_stopPreButton();
            
            [obj.cameraVObj.startPreButton.Enable, ...
                obj.cameraVObj.stopPreButton.Enable] = deal('off');
            [obj.cameraVObj.captureTpiButton.Enable,...
                obj.cameraVObj.captureButton.Enable] = deal('on');
            [obj.cameraVObj.setButton.Enable, ...
                obj.cameraVObj.saveButton.Enable,...
                obj.cameraVObj.loadButton.Enable] = deal('off');
            
            obj.cameraVObj.cameraConnectText.Value = 1;
            obj.cameraVObj.cameraConnectText.String = 'Acquirng';
            obj.cameraVObj.cameraConnectText.BackgroundColor = [0.47,0.67,0.19];
            
            obj.cameraVObj.vsrcObj.AutoContrast = 'OFF';
            start(obj.cameraVObj.vidObj);
        end
        %%
        function callback_cameraDisconnectButton(obj,src,event)
            if ~obj.cameraVObj.cameraConnectText.Value
                return
            end
            
            [obj.cameraVObj.startPreButton.Enable, ...
                obj.cameraVObj.stopPreButton.Enable] = deal('on');
            [obj.cameraVObj.captureTpiButton.Enable,...
                obj.cameraVObj.captureButton.Enable] = deal('off');
            [obj.cameraVObj.setButton.Enable, ...
                obj.cameraVObj.saveButton.Enable,...
                obj.cameraVObj.loadButton.Enable] = deal('on');
            
            obj.cameraVObj.cameraConnectText.Value = 0;
            obj.cameraVObj.cameraConnectText.String = 'Acquirng stopped';
            obj.cameraVObj.cameraConnectText.BackgroundColor = [0.64,0.08,0.18];
            
            stop(obj.cameraVObj.vidObj);
            obj.cameraVObj.vsrcObj.AutoContrast = 'ON';
        end
        %%
        function callback_setButton(obj,src,event)            
            inspect(obj.cameraVObj.vsrcObj);
        end
        %%
        function callback_loadButton(obj,src,event)
        end
        %%
        function callback_saveButton(obj,src,event)
        end
        %%
        function callback_startPreButton(obj,src,event)            
            preview(obj.cameraVObj.vidObj,obj.cameraVObj.hImage);
            %preview(obj.cameraVObj.vidObj);
            obj.cameraVObj.vsrcObj.AutoContrast = 'ON';
        end        
        %%
        function callback_stopPreButton(obj,src,event)
            obj.cameraVObj.vsrcObj.AutoContrast = 'OFF';
            stoppreview(obj.cameraVObj.vidObj);
        end
        %%
        function callback_captureTpiButton(obj,src,event)
            if ~isempty(obj.cameraMObj.tpiExp) && ...
                    obj.cameraVObj.vsrcObj.Exposure ~= obj.cameraMObj.tpiExp
                answer = questdlg(...
                    {sprintf(...
                    'Tpi Exposure time were inconsitent.\nCurrent is %dms, but %dms previously.',...
                    obj.cameraVObj.vsrcObj.Exposure,obj.cameraMObj.tpiExp),...
                    'Do you want to remove previous tpis and capture new?'},...
                    'Confirm dialog','Yes','Cancel',...
                    'Cancel');
                switch answer
                    case 'Yes'
                        [obj.cameraMObj.tpiExp,obj.cameraMObj.tpi] = deal([]);
                    case 'Cancel'
                        return
                end
            end

            obj.cameraMObj.tpi = cat(3,obj.cameraMObj.tpi,...
                obj.cameraMObj.captureImage());
            obj.cameraMObj.tpiExp = obj.cameraVObj.vsrcObj.Exposure;
            
            figure;
            imshow(imadjust(obj.cameraMObj.tpi(:,:,end),...
                stretchlim(obj.cameraMObj.tpi(:,:,end),0)));
            suptitle(sprintf('NO.%d tpi, exposure %dms',...
                size(obj.cameraMObj.tpi,3),obj.cameraMObj.tpiExp));
        end        
        %%
        function callback_captureButton(obj,src,event)
            assignin('base','capturedImage',obj.cameraMObj.captureImage());            
        end
    end








end