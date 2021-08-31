classdef UserC < handle
    properties
        userVObj;
        userMObj;
    end
    
    methods
        function obj = UserC(userVObj,userMObj)
            obj.userMObj = userMObj;
            obj.userVObj = userVObj;
        end
        
        %%
        function callback_laserHighButton(obj,src,data)
            l = Context.getInstance().getData('mainMObj').laserObj;
            if  ~l.fDeploy || isequal(l.state,'OFF') || isequal(l.level,'High')
                return
            end
            l.setPowerLevelHigh();
        end
        
        function callback_laserLowButton(obj,src,data)
            l = Context.getInstance().getData('mainMObj').laserObj;
            if  ~l.fDeploy || isequal(l.state,'OFF') || isequal(l.level,'Low')
                return
            end
            l.setPowerLevelLow();
        end
        
        function callback_objDeltaEdit(obj,src,data)
            num = str2double(src.String);
            if num<0 || num>1 || isnan(num)
                warndlg('Invalid input objDeltaEdit.');
                return
            end
            o = Context.getInstance().getData('mainMObj').objectiveMObj;
            o.deltaFocusStageZMove = -num;
        end
        
        function callback_distanceFromCenterEdit(obj,src,data)
            [fValid,arr] = checkArray(src.String,4);
            if ~fValid
                warndlg('Invalid input distanceFromCenter.');
                return
            end
            p = Context.getInstance().getData('mainMObj').imPipeline;
            if ~isempty(p)
                p.distFromCenter = arr;
            end
        end
        
        function callback_edMethodUibuttongroup(obj,src,data)
            v = obj.userVObj;
            if isequal(lower(data.OldValue.String),'auto')
                v.distanceFromCenterEdit.Enable = 'on';
                v.detectBgThresholdEdit.Enable = 'off';
                obj.callback_distanceFromCenterEdit(v.distanceFromCenterEdit,[]);
            else
                v.distanceFromCenterEdit.Enable = 'off';
                v.detectBgThresholdEdit.Enable = 'on';
            end
            p = Context.getInstance().getData('mainMObj').imPipeline;
            if ~isempty(p)
                p.edMethod = lower(data.NewValue.String);
            end
        end
        
        function callback_pipelinePopup(obj,src,data)
            switch src.Value
                case 1
                    obj.userVObj.objectivePopup.Enable = 'on';
                    obj.userVObj.objDeltaEdit.Enable = 'off';
                case 2
                    obj.userVObj.objectivePopup.Enable = 'off';
                    obj.userVObj.objDeltaEdit.Enable = 'on';
            end
        end
        
        function callback_browseButton(obj,src,data)
            obj.userVObj.imSavePathEdit.String = uigetdir;
        end
        
        function callback_runButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            
            % check imaging parameters
            if ~obj.checkBeforeRunning()
                return
            end
            
            if isempty(m.imPipeline) || ...
                    isequal(class(m.imPipeline.state),'FinishImaging')
                % start from beginning
                
                % update m.imagingP, but only update when create m.imPipline objetct
                obj.updateImagingP(m);
                [m.rROIs,m.dROIs] = deal([]);
                
                u = obj.userVObj;
                s = u.pipelinePopup.String(u.pipelinePopup.Value,:);
                
                switch deblank(s)
                    case 'Smart'
                        if ~isequal(m.tcpW.tcpObj.Status,'open')
                            fopen(m.tcpW.tcpObj);
                        end
                        if ~isequal(m.tcpW.tcpObj2.Status,'open')
                            fopen(m.tcpW.tcpObj2);
                        end
                        m.piezoMObj.changeCtrl('I');
                        internalPiezoStart = m.piezoMObj.getPosition();
                        m.piezoMObj.changeCtrl('E');
                        m.cameraMObj.switch2HardwareTrigger();
                    case 'General'
                        m.piezoMObj.changeCtrl('I');
                        internalPiezoStart = [];
                        m.cameraMObj.switch2InternalTrigger();
                end
                
                m.imPipeline = eval(sprintf('%sImagingPipeline(m);',deblank(s)));
                try
                    m.imPipeline.internalPiezoStart = internalPiezoStart;
                catch
                end
                
            elseif ~m.imPipeline.fPauseByUser || isempty(m.imPipeline.state)
                % start form stop pressed
                if m.imPipeline.runningPrepare(m)
                    % user quit
                    return
                end
            elseif m.imPipeline.fPauseByUser
                % start form pause
                % 2018/10/1,CH
                m.imPipeline.move2AutoRecordStageAndPiezoPos(m);
            end
            
            % button response
            [obj.userVObj.pauseButton.Enable,...
                obj.userVObj.stopButton.Enable] = deal('on');
            [src.Enable,obj.userVObj.tryDetectButton.Enable,...
                obj.userVObj.recordPosButton.Enable,...
                obj.userVObj.move2RecPosButton.Enable] = deal('off');
            
            [m.imPipeline.fStop,...
                m.imPipeline.fStopByUser,...
                m.imPipeline.fPauseByUser] = deal(0);
            
            % pasue or stop all will quit loop
            m.laserObj.setPowerLevelHigh();
            m.csuObj.openShutter();
            pause(0.1);
            m.imPipeline.mainLoop(m);
            
            if m.imPipeline.fStop || m.imPipeline.fStopByUser
                src.String = 'Run';
                [src.Enable,...
                    obj.userVObj.tryDetectButton.Enable] = deal('on');
            elseif m.imPipeline.fPauseByUser
                src.Enable = 'on';
                src.String = 'Continue';
            end
            [obj.userVObj.pauseButton.Enable,...
                obj.userVObj.stopButton.Enable] = deal('off');
        end
        
        function callback_pauseButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            p = m.imPipeline;
            p.fPauseByUser = 1;
            p.autoRecordStageAndPiezoPos(m); % 2018/10/1,CH
            m.csuObj.closeShutter();
            src.Value = 0;
            src.Enable = 'off';
            [obj.userVObj.recordPosButton.Enable,...
                obj.userVObj.move2RecPosButton.Enable] = deal('on');
            %{
            p.fPauseByUser = src.Value;
            if src.Value
                src.String = 'Continue';
            else
                src.String = 'Pause';
            end
            %}
        end
        
        function callback_stopButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            p = m.imPipeline;
            
            m.csuObj.closeShutter();  
            m.stageMObj.waitForStageStatic();
            
            p.fStopByUser = 1;
            p.fPauseByUser = 0;
            try
            p.zBehavior.responseForManualStop(m);
            catch
            end
            [obj.userVObj.runButton.Enable,...
                obj.userVObj.tryDetectButton.Enable] = deal('on');
            obj.userVObj.pauseButton.Value = 0;
            obj.userVObj.pauseButton.String = 'Pause';
            [obj.userVObj.pauseButton.Enable,...
                src.Enable] = deal('off');
            [obj.userVObj.recordPosButton.Enable,...
                obj.userVObj.move2RecPosButton.Enable] = deal('on');
        end
        
        function callback_tryDetectButton(obj,src,data)
            % 2018/10/1
            msgbox('This function was removed.');
            return
            
            % check imaging parameters
            if ~obj.checkBeforeRunning()
                return
            end
            
            % button response
            [obj.userVObj.pauseButton.Enable,...
                obj.userVObj.stopButton.Enable] = deal('on');
            [src.Enable,obj.userVObj.runButton.Enable,...
                obj.userVObj.pauseButton.Enable] = deal('off');
            
            m = Context.getInstance().getData('mainMObj');
            
            m.imPipeline = TryImagingPipeline();
            p = m.imPipeline;
            p.prepareEdgeDetect(m);
            p.edObj.clearDetectionVars();
            p.edObj.notify('newDetection');
            m.csuObj.openShutter();
            pause(0.1);
            p.edObj.detectEdge(m,p);
            p.dROIs = ROIsDecide2Child1().decideROIs(m,p);
            
            [src.Enable,...
                obj.userVObj.runButton.Enable] = deal('on');
            obj.userVObj.pauseButton.Value = 0;
            obj.userVObj.pauseButton.String = 'Pause';
            [obj.userVObj.pauseButton.Enable,...
                obj.userVObj.stopButton.Enable] = deal('off');
            %}
        end
        
        function callback_recordPosButton(obj,src,data)
             m = Context.getInstance().getData('mainMObj');
             m.manualRecordStageAndPiezoPos();
        end
        
        function callback_move2RecPosButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            m.move2ManualRecordStageAndPiezoPos();
        end
        
        function callback_shutterButton(obj,src,data)
            % 2018/10/1
            m = Context.getInstance().getData('mainMObj');
            if src.Value
                m.csuObj.openShutter();
                src.String = 'Close SH';
            else
                m.csuObj.closeShutter();
                src.String = 'Open SH';
            end
        end
        
        function fPass = checkBeforeRunning(obj)
            fPass = 0;
            v = Context.getInstance().getData('mainVObj');
            m = Context.getInstance().getData('mainMObj');
            % check imaging parameters
            uic = findobj('Tag',v.imParameterTag);
            if any(cellfun(@isempty,{uic.String}))
                warndlg('Please set imaging parameters first.');
                return
            elseif ~exist(v.userVObj.imSavePathEdit.String,'file')
                warndlg('Please create/check folder first.');
                return
            elseif mod(str2double(v.userVObj.ROIsDetermineRateEdit.String),...
                    str2double(v.userVObj.zScanRateEdit.String))
                warndlg('ROIs Determine Freq. need be multiple of Z Scan Freq.');
                return
            elseif str2double(v.userVObj.sectionRateEdit.String)>= ...
                    str2double(v.userVObj.ROIsDetermineRateEdit.String) &&...
                    mod(str2double(v.userVObj.sectionRateEdit.String),...
                    str2double(v.userVObj.ROIsDetermineRateEdit.String))
                warndlg('Section Freq. need be multiple of ROIs Determine Freq.');
                return
            elseif str2double(v.userVObj.sectionRateEdit.String)< ...
                    str2double(v.userVObj.ROIsDetermineRateEdit.String) &&...
                    mod(str2double(v.userVObj.ROIsDetermineRateEdit.String),...
                    str2double(v.userVObj.sectionRateEdit.String))
                warndlg('ROIs Determine Freq. need be multiple of Section Freq.');
                return    
            elseif str2double(v.userVObj.sectionRateEdit.String) -  ...
                    str2double(v.userVObj.zSectionOverlapEdit.String) < 70
                warndlg({'(Section Freq. - Section Overlap) need ',...
                    'be bigger than 70 microns for best perfomance.'});
                return
            elseif isequal(v.userVObj.pipelinePopup.String(...
                    v.userVObj.pipelinePopup.Value),'General') && ...
                    ~isequal(v.userVObj.objectivePopup.String(...
                    v.userVObj.objectivePopup.Value),m.objectiveMObj.xState)
                warndlg({'Current objective is not equal to ',...
                    'selected imaging objective.'});
                return
            elseif ~m.cameraMObj.isRunning
                warndlg('Start acquiring first.');
                return
            end
            
            % check other necessary parameters
            if isequal(...
                    obj.userVObj.edMethodUibuttongroup.SelectedObject.String,...
                    'Rectangle')
            [fValid,~] = checkArray(...
                obj.userVObj.distanceFromCenterEdit.String,4);
            if ~fValid
                warndlg({'Please input distanceFromCenter when Rectangle selected.',...
                    'DFC -> xx xx xx xx'});
                return
            end
            end
            
            if ~m.objectiveMObj.fFinishAlignment
                warndlg({'Please align focus and blade planes first.',...
                    'Objetive -> Align BP and FP'});
                return
            end
            
            if isempty(m.stageMObj.manualSampleCenter)
                warndlg({'Please set sample center first.',...
                    'APT Configuration -> Set here as sample center'});
                return
            end
            
            if size(m.cameraMObj.tpi,3) < m.cameraMObj.minTpiNum
                warndlg({sprintf(...
                    'Please capture %d more tpis(background).',...
                    m.cameraMObj.minTpiNum - size(m.cameraMObj.tpi,3)),...
                    'Camera -> Operation -> capture tpi'});
                return
            end
            
            fPass = 1;
        end
        
        function updateImagingP(obj,m)
            %{
            % objective is auto detect
            m.imagingP.objective = deblank(obj.userVObj.objectivePopup.String(...
                obj.userVObj.objectivePopup.Value,:));
            %}
            m.imagingP.imSavePath = obj.userVObj.imSavePathEdit.String;
            str2double_ = @(obj,s)eval(...
                sprintf('str2double(obj.userVObj.%s.String);',s));
            m.imagingP.sectionRate = str2double_(obj,'sectionRateEdit');
            m.imagingP.zScanRate = str2double_(obj,'zScanRateEdit');
            m.imagingP.ROIsDetermineRate = str2double_(obj,'ROIsDetermineRateEdit');
            m.imagingP.zMaxLimt = str2double_(obj,'zMaxLimtEdit');
            m.imagingP.zSectionOverlap = str2double_(obj,'zSectionOverlapEdit');
            m.imagingP.detectBgThreshold = str2double_(obj,'detectBgThresholdEdit');
            m.imagingP.edMethod = ...
                lower(obj.userVObj.edMethodUibuttongroup.SelectedObject.String);
            [~,arr] = checkArray(obj.userVObj.distanceFromCenterEdit.String,4);
            m.imagingP.distFromCenter = arr;
        end
        
    end
end

function [fValid,arr] = checkArray(stdin,num)
arr = [];
fValid = 0;
try
    arr = eval(strcat('[',stdin,']'));
    if numel(arr)==num
        fValid = 1;
    end
catch
end
end