classdef PiezoC < handle
    properties
        piezoMObj;
        piezoVObj;
    end
    
    methods
        %% constructor
        function obj =PiezoC(piezoVObj,piezoMObj)
            obj.piezoMObj = piezoMObj;
            obj.piezoVObj = piezoVObj;
            obj.piezoMObj.addlistener('movePiezoNow',@obj.movePiezo);
            obj.piezoMObj.addlistener('checkStatic',@obj.checkStatic);
            obj.piezoMObj.addlistener('initiatePiezoNow',@obj.initiatePiezo);
            obj.piezoMObj.addlistener('getPositionNow',@obj.getPosition);
            obj.piezoMObj.addlistener('switch2ExternalCtrl',@obj.switch2ExternalCtrl);
            obj.piezoMObj.addlistener('switch2InternalCtrl',@obj.switch2InternalCtrl);
        end
        %%
        function movePiezo(obj,src,data)
            if isequal(src.ctrlMode,'I')
                obj.piezoVObj.hpiezo.SetPosOutput(0,data.value);
            elseif isequal(src.ctrlMode,'E')
                m = Context.getInstance().getData('mainMObj');
                if isempty(m.imPipeline.dStartPiezoPosition)
                    warndlg({'Can not reach set position at external ctrl mode,'...
                        'when dStartPiezoPosition is empty.',...
                        'Use internal mode instead.'});
                    return
                else
                    ini = m.imPipeline.dStartPiezoPosition(1);
                end
                
                if data.value - ini<0
                    warndlg('Can not reach set position at external ctrl mode.')
                    return
                end
                
                pos = data.value - ini;
                m.tcpW.fwrite2labVIEW(...
                    func_structPiezoPars(pos,pos,25,ini));
            end
        
        end
        %%
        function switch2ExternalCtrl(obj,src,data)
            obj.piezoVObj.hpiezo.SetPPCIOSettings(0,1,3,1,2);
            src.ctrlMode = 'E';
        end
        
        function switch2InternalCtrl(obj,src,data)
            obj.piezoVObj.hpiezo.SetPPCIOSettings(0,0,3,1,2);
            src.ctrlMode = 'I';
        end
        
        function checkStatic(obj,src,data)
           
            %pause(0.002);
            return
            %{
            while 1
                [~,a] = obj.piezoVObj.hpiezo.GetPosOutput(0,0);
                if abs( a - data.value) < 0.5
                    break
                end
                pause(0.001);
            end
            %}
        end 
        %%
        function getPosition(obj,src,data)
            [~,src.curPosition] = obj.piezoVObj.hpiezo.GetPosOutput(0,0);
        end
        %%
        function initiatePiezo(obj,src,data)
            set(obj.piezoVObj.hpiezo,'HWSerialNum', obj.piezoMObj.SN);
            obj.piezoVObj.hpiezo.StartCtrl;
            
            obj.piezoVObj.hpiezo.SetControlMode(0,2); % 1, open loop; 2, closed loop
            pause(0.5);
            obj.piezoVObj.hpiezo.SetVoltPosDispMode(0,2); % 1,volt; 2, position      
            pause(0.5);
            obj.switch2InternalCtrl();
            src.movePiezo(src.iniPosition); % move to iniPosition um            
            obj.piezoVObj.hpiezo.SetJogStepSize(0, 1); % jog 1um
            
            src.fFinishIni = 1;
            LogClass.getInstance().writeLog('Initiated piezo.');
                        
        end
        %%
        function callback_initiateButton(obj,src,data)
            iniPositions = str2double(obj.piezoVObj.piezoStartEdit.String);
            obj.piezoMObj.initializePiezo(iniPositions);
        end
    end
    
end