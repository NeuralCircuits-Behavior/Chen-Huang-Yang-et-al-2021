classdef VTC < handle
    properties
        vtMObj;
        vtVObj;
    end
    
    methods
        function obj = VTC(vtVObj,vtMObj)
            obj.vtVObj = vtVObj;
            obj.vtMObj = vtMObj;
            obj.vtMObj.addlistener('switching',@obj.callback_switchButton);            
        end
        
        function callback_switchButton(obj,src,data)
            a = Context.getInstance().getData('mainMObj').ardS;
            a.writeDigitalPin(obj.vtMObj.pin,1);
            pause(0.005);
            a.writeDigitalPin(obj.vtMObj.pin,0);
            obj.vtMObj.switchState();
            
        end 
        
        function callback_sectionButton(obj,src,data)
            m = Context.getInstance().getData('mainMObj');
            stm = m.stageMObj;
            vtm = obj.vtMObj;
            
            if ~stm.fFinishIni 
                msgbox('Please initiate stages first.');
                return
            elseif ~m.piezoMObj.fFinishIni
                %msgbox('Please initiate piezo first.');
                %return
            elseif vtm.state
                msgbox('Please push Switch button to stop vibration first.');
                return
            end
            
            currentP = stm.getXYCurrentPosition();
            targetP = stm.getZCurrentPosition() - vtm.stepSize;
            stm.moveAbsolute('YZ',[vtm.startCutPosition,targetP]);
            stm.waitForStageStatic();
            
            % start cutting
            vtm.vibrationStart();
            oriSpeed = stm.changeSpeed('Y',vtm.sampleSpeed);
            stm.moveAbsolute('Y',vtm.stopCutPosition);
            stm.waitForStageStatic();
            vtm.vibrationStop();
            
            % move back
            stm.changeSpeed('Y',oriSpeed);
            stm.moveAbsolute('Y',currentP(2));
            stm.waitForStageStatic();
            vtm.bladePlane = stm.getZCurrentPosition();
            LogClass.getInstance().writeLog(...
                sprintf('Section %.4f mm sample at %.2f mm/s speed.',...
                vtm.stepSize,vtm.sampleSpeed));
            LogClass.getInstance().writeLog(...
                sprintf('Blade plane at %.4f mm.',vtm.bladePlane));
        end
        
    end

    
    




end
