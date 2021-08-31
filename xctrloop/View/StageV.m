classdef StageV < handle
    properties
        hstages; % obj array, 3 elements, handles of stage x,y,z
        stageMObj;
        stageCObj;
        
        % setting uicontrol, created in ViewMain ----------------
        stageXStartEdit;
        stageYStartEdit;
        stageZStartEdit;
        positioningModePopupX;
        positioningModePopupY;
        positioningModePopupZ;
        snXEdit;
        snYEdit;
        snZEdit;
        initiateButton;
        centerButton;
        
        move2bladePlaneButton;
        moveObjDeltaButton;
        % -----------------------------------------------------

    end
    
    properties(Dependent)
        stageStartArray;
        stageSNArray;
    end
    
    methods
        %% constructor
        function obj = StageV(stageMObj)
            obj.stageMObj = stageMObj;
            obj.initiateActiveX();
            obj.stageCObj = obj.makeContoller();
            
            % reg updateMoveMode
            obj.stageMObj.addlistener('updateMoveMode',@obj.updateMoveMode);
        end
        
        %%
        function updateMoveMode(obj,src,data)
            obj.changePositioningModePopupValue(obj.positioningModePopupX,...
                src.positioningMode{1});
            obj.changePositioningModePopupValue(obj.positioningModePopupY,...
                src.positioningMode{2});
            obj.changePositioningModePopupValue(obj.positioningModePopupZ,...
                src.positioningMode{3});
        end
        %% 
        function changePositioningModePopupValue(obj,uic,inputMode)
            % note use string here, version spec
            uic.Value = find(strcmp(inputMode,...
                cellfun(@deblank,string(uic.String),'unif',0)));
        end
        %%
        function stageStartArray = get.stageStartArray(obj)
            stageStartArray = [str2double(obj.stageXStartEdit.String),...
                str2double(obj.stageYStartEdit.String),...
                str2double(obj.stageZStartEdit.String)];
        end
        
        %%
        function stageSNArray = get.stageSNArray(obj)
            stageSNArray = [str2double(obj.snXEdit.String),...
                str2double(obj.snYEdit.String),...
                str2double(obj.snZEdit.String)];
        end
        %%
        function initiateActiveX(obj)
            mainVObj = Context.getInstance().getData('mainVObj');
            hfigAPT = mainVObj.hfigAPT;
  
            fsz = [0.22,0.215]; % [width,heigh] in norm
            str = {{'Stage','X'},{'Stage','Y'},{'Stage','Z'}};
            
            for i_stage = 1:3
                st_sz = [[.027, 0.88-0.2-0.225*(i_stage-1)],fsz] .* ...
                    mainVObj.screensz_array;
                label_sz = [[0, 0.88-0.2-0.225*(i_stage-1)+fsz(2)/2],...
                    [0.025,0.05]].* mainVObj.screensz_array;
                uicontrol('parent',hfigAPT,...
                    'style','text','string',str{i_stage},...
                    'position',label_sz,...
                    'FontWeight','bold','fontsize',10);
                hstage = actxcontrol('MGMOTOR.MGMotorCtrl.1',st_sz, hfigAPT);
                
                % add one property for check move complete
                if ~isprop(hstage,'fMoveComplete')
                    hstage.addproperty('fMoveComplete');
                    hstage.fMoveComplete = 1;
                end
                                
                obj.hstages= cat(2,obj.hstages,hstage);
            end
        end
        
        %%
        function stageCObj = makeContoller(obj)
            stageCObj = StageC(obj,obj.stageMObj);
        end
        
        %% attach callback functions
        function attachToController(obj)
            % callback function use callback_ as heard and uictrl name follow.
            % add the func name in the cell array
            funcNames = {'initiateButton','centerButton',...
                'move2bladePlaneButton','moveObjDeltaButton'};
            if ~obj.stageMObj.fDeploy || isempty(funcNames)
                return
            end
            
            c = obj.stageCObj;
            for k =1:numel(funcNames)
                str = strcat('obj.',funcNames{k},...
                    '.Callback = @c.','callback_',funcNames{k},';');
                eval(str);
            end
            
        end
    end
    
    
    
    
    
end