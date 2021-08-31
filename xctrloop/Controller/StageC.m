classdef StageC < handle
    properties
        stageVObj;
        stageMObj;
        
        pmObj; % PositionMode object
        pmListeners;
    end
        
    methods
        %% constructor
        function obj = StageC(stageVObj,stageMObj)
            obj.stageVObj = stageVObj;
            obj.stageMObj = stageMObj;

            obj.registGeneralListener();
        end
        
        %% regist gernal listeners which do not need setting
        function registGeneralListener(obj)
            obj.stageMObj.addlistener('checkStatic',@obj.checkStatic);
            obj.stageMObj.addlistener('getCurrentXY',@obj.getCurrentXY);
            obj.stageMObj.addlistener('getCurrentZ',@obj.getCurrentZ);
            obj.stageMObj.addlistener('moveIniXYZ',@obj.moveIniXYZ);
            obj.stageMObj.addlistener('changeSpeedNow',@obj.changeSpeed);
            obj.stageMObj.addlistener('updateMoveMode',@obj.updateMoveMode);
        end
        %% wait for setting and than, regist setting listeners
        function registSettingListener(obj)
            % very important step
            delete(obj.pmListeners);
            
            pm = obj.decideMoveMode();
            obj.pmObj = pm;
            pm_ = pm{1};
            obj.pmListeners = obj.stageMObj.addlistener('moveRelX',@pm_.moveRelX);
            obj.pmListeners(2) = obj.stageMObj.addlistener('moveAbsX',@pm_.moveAbsX);
            pm_ = pm{2};
            obj.pmListeners(3) = obj.stageMObj.addlistener('moveRelY',@pm_.moveRelY);
            obj.pmListeners(4) = obj.stageMObj.addlistener('moveAbsY',@pm_.moveAbsY);
            pm_ = pm{3};
            obj.pmListeners(5) = obj.stageMObj.addlistener('moveRelZ',@pm_.moveRelZ);
            obj.pmListeners(6) = obj.stageMObj.addlistener('moveAbsZ',@pm_.moveAbsZ);
        end
        %%
        function pmObj = decideMoveMode(obj)
            pmObj = cell(1,3);
            for s = 1:3
                className = strcat('PositioningMode_',...
                    obj.stageMObj.positioningMode{s});
                c = str2func(className);
                pmObj{s} = c(obj.stageVObj.hstages);
            end
        end
        %%
        function callback_move2bladePlaneButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            vt = m.vtMObj;
            if ~obj.stageMObj.fFinishIni || isempty(vt.bladePlane)
                return
            end
            obj.stageMObj.move2bladePlane(m);
        end
        
        function callback_moveObjDeltaButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            vt = m.vtMObj;
            if ~obj.stageMObj.fFinishIni || isempty(vt.bladePlane)
                return
            end
            obj.stageMObj.move2bladePlane40(m);
        end
        
        function callback_initiateButton(obj,src,data)
            iniPositions = obj.stageVObj.stageStartArray;
            v = obj.stageVObj;
            pm = @(p)deblank(p.String(p.Value,:));
            positioningMode = {pm(v.positioningModePopupX);...
                pm(v.positioningModePopupY);...
                pm(v.positioningModePopupZ)};
            obj.stageMObj.initializeStages(iniPositions,positioningMode);
        end
        
        function callback_centerButton(obj,src,data)
            obj.stageMObj.manualSampleCenter = ...
                obj.stageMObj.getXYCurrentPosition();
            LogClass.getInstance().writeLog(sprintf('Set (%.4f,%.4f) as sample center.',...
                obj.stageMObj.manualSampleCenter(1),...
                obj.stageMObj.manualSampleCenter(2)));
        end
        %% listener functions ==========================================================================================
        % event listener: checkStatic
        function checkStatic(obj,src,data)
            
            %{
            % use GetStatusBits_Bits method need to wait a short
            % monment to trans command to stage driver
            
            r = [1,1,1];
            while all(r)
              for i_stage = 1:3
                  s = obj.stageVObj.hstages(i_stage).GetStatusBits_Bits(0);
                  r(i_stage) = bitget(abs(s),5)||bitget(abs(s),6);
              end
            end
            %}
            
            % fMoveComplete is a prop added by user,
            % need not wait for commnication
            while ~all([obj.stageVObj.hstages(1).fMoveComplete,...
                    obj.stageVObj.hstages(2).fMoveComplete,...
                    obj.stageVObj.hstages(3).fMoveComplete])
                pause(0.0015);
            end
        end
        
        % event listener: getCurrentXY
        function getCurrentXY(obj,src,data)
            % -------------------
            % use encoder to read stage position, always
            % 2017/7/25
            % -------------------
            
            stxy_current = zeros(1,2);
            for k = 1:2
                h = obj.stageVObj.hstages(k);
                [a,b,c,d] = h.GetEncPosControlParams(0,0,0,0); % get current mode
                h.SetEncPosControlParams(0,2,2,0); % set encoder mode
                stxy_current(k) = h.GetPosition_Position(0);
                h.SetEncPosControlParams(a,b,c,d); % back to mode
            end
            
            % src is source of event, here is  obj.stageMObj
            src.stxy_curr_back = stxy_current;
        end
        
        %event listener: getCurrentZ
        function getCurrentZ(obj,src,data)
            % -------------------
            % use encoder to read stage position, always
            % 2018/4/11
            % -------------------
            
            h = obj.stageVObj.hstages(3);
            [a,b,c,d] = h.GetEncPosControlParams(0,0,0,0); % get current mode
            h.SetEncPosControlParams(0,2,2,0); % set encoder mode
            stz_current = h.GetPosition_Position(0);
            h.SetEncPosControlParams(a,b,c,d); % back to mode
            
            % src is source of event, here is  obj.stageMObj
            src.stz_curr_back = stz_current;
        end
        
        % event listener: moveIniXYZ
        function moveIniXYZ(obj,src,data)
            nStages = numel(obj.stageVObj.hstages);
            if nStages < 1
                error('No stages connected.');
            elseif nStages < 3
                error('Need connect all three stages.')
            end
            
            if src.fFinishIni
                answer = questdlg(...
                    {'Stages have already initiated,',...
                    'please make sure you want to initiated again.'},...
                    'Confirm dialog','Yes','Cancel',...
                    'Cancel');
                switch answer
                    case 'Cancel'
                        return
                end
            end
            
            % again or not again all need raise objectives
            src.notify('iniAgain');
            
            % obj.registSettingListener(); % bug line,create move mode object
            src.notify('updateMoveMode');
            
            % setting and homing
            for i_stage = 1:3
                set__(obj,i_stage,src);
                pause(0.5);
                home__(obj,i_stage);
            end
            
            src.waitForStageStatic();
            src.moveAbsolute('XYZ',src.iniPosition_xyz);
            src.waitForStageStatic();
            src.fFinishIni = 1;
            LogClass.getInstance().writeLog('Initiated stages.');
            %------------------------------------------------------
            % local functions
            function set__(obj,i_stage,src)
                h = obj.stageVObj.hstages(i_stage);
                % src here is obj.stageMObj
                set(h,'HWSerialNum', src.SN(i_stage));
                h.StartCtrl;
                
                %h.LoadParamSet('default'); % note SN is correspond to parameters
                
                % set max limit positions
                h.SetStageAxisInfo(0,0,src.maxLimtPosition(i_stage),1,1,0);
                
                if isequal(src.positioningMode,'Encoder')
                    h.SetEncPosControlParams(0,2,2,1);  % use encoder model
                else
                    h.SetEncPosControlParams(0,1,1,0);
                end
                
                % register user callback when stage move comoleted,
                % used for checking stactic
                h.registerevent({'MoveComplete' 'callback_stageMoveComplete'});
                h.registerevent({'HomeComplete' 'callback_stageHomeComplete'});
                
            end
            
            function home__(obj,i_stage)
                h = obj.stageVObj.hstages(i_stage);
                h.fMoveComplete = 0 ; % not self attribute of stage objects
                h.MoveHome(0,0); % necessary
            end
        end
        
        function changeSpeed(obj,src,data)
            oriSpeed = zeros(size(data.newSpeed));
            [~,idx] = ismember(data.axis,'XYZ');
            hs = obj.stageVObj.hstages(idx);
            for k = 1:numel(hs)
                oriSpeed(k) = 20;
                hs.SetVelParams(0,0,20,data.newSpeed(k));
            end
            src.oriSpeed = oriSpeed;
        end
        
        function updateMoveMode(obj,src,data)
            % delete(obj.pmListeners); % move to registSettingListener()
            obj.registSettingListener();
        end
    end
    % =======================================================================================================================================
    
    
end
