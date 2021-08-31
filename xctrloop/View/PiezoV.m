classdef PiezoV < handle
    properties
        hpiezo;
        piezoMObj;
        piezoCObj;
        
        % piezo start setting UI, created in ViewMain -----------------
        piezoStartEdit;
        snEdit;
        initiateButton;
        % ----------------------------------------
    end
        
    methods
        %% constructor
        function obj = PiezoV(piezoMObj)
            obj.piezoMObj = piezoMObj;
            obj.initiateActiveX();
            obj.piezoCObj = obj.makeContoller();
        end
        %%
        function initiateActiveX(obj)
            mainVObj = Context.getInstance().getData('mainVObj');
            hfigAPT = mainVObj.hfigAPT;

            fsz = [0.22,0.215]; % [width,heigh] in norm
            
            sz = [[.027, 0.88-0.2-0.225*(4-1)],fsz].* ...
                mainVObj.screensz_array;
            label_sz = [[0, 0.88-0.2-0.225*(4-1)+fsz(2)/2],...
                [0.025,0.05]].* mainVObj.screensz_array;
            uicontrol('parent',hfigAPT,'style','text','string','Piezo',...
                'position',label_sz,'FontWeight','bold','fontsize',10);
            obj.hpiezo = actxcontrol('MGPIEZO.MGPiezoCtrl.1',sz, hfigAPT);
        end
        
        %%
        function piezoCObj = makeContoller(obj)
            piezoCObj = PiezoC(obj,obj.piezoMObj);
        end
        %%
        function attachToController(obj)
            % callback function use callback_ as heard and uictrl name follow.
            % add the func name in the cell array
            funcNames = {'initiateButton'};
            if ~obj.piezoMObj.fDeploy || isempty(funcNames)
                return
            end
            
            c = obj.piezoCObj;
            for k =1:numel(funcNames)
                str = strcat('obj.',funcNames{k},...
                    '.Callback = @c.','callback_',funcNames{k},';');
                eval(str);
            end
        end
    end
    
    
    
end