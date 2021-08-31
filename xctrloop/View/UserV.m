classdef UserV < handle
    properties
        userMObj;
        userCObj;
                
        axDisplay; % state
        hLog; % log 
        saveLogButton;
        
        pipelinePopup;
        imSavePathEdit;
        browseButton;
        
        objectivePopup;
        zScanRateEdit;
        ROIsDetermineRateEdit;
        sectionRateEdit;
        zMaxLimtEdit;
        zSectionOverlapEdit;
        objDeltaEdit;
        
        edMethodUibuttongroup;
        detectBgThresholdEdit;
        distanceFromCenterEdit;
        
        runButton;
        pauseButton;
        stopButton;
        tryDetectButton;
        
        recordPosButton;
        move2RecPosButton;
        
        shutterButton;
        laserHighButton;
        laserLowButton;
    end
    
    methods
        %%
        function obj = UserV(userMObj)
           
            obj.userMObj = userMObj;
            
            LogClass.getInstance().addlistener('logChanged',@obj.updateLogGUI);
            %{
            % build in MainView
            conObj = Context.getInstance();
            mainVObj = conObj.getData('mainVObj');
            obj.buildUI(mainVObj);
            %}
            
            obj.userCObj = obj.makeController();
            %obj.attachToController(obj.userCObj); % % register in MainView
            
        end
        
        %%
        function updateLogGUI(obj,src,data)
            logObj = LogClass.getInstance();
            set(obj.hLog,'string',sprintf(logObj.logstr));
        end
        %%
        function userCObj = makeController(obj)
            userCObj = UserC(obj,obj.userMObj);
        end
        
        %%
        function getCurrentThreshold(obj,src,data)
            src.detectBgThreshold = str2double(obj.detectBgThresholdEdit.String);
        end
        %%
        function updateDistFromCenter(obj,src,data)
            obj.distanceFromCenterEdit.String = ...
                sprintf('%.3f, %.3f, %.3f, %.3f',...
                data.dist(1),data.dist(2),data.dist(3),data.dist(4));
        end
        %%
        function displayPositions(obj,src,data)
            plot(obj.axDisplay,...
                data.stxy_plot(:,1),data.stxy_plot(:,2),data.mark);
            stageMObj = Context.getInstance().getData('mainMObj').stageMObj;
            ori = round(stageMObj.manualSampleCenter,1);
            obj.axDisplay.XTick = ori(1)+(-8:2:8);
            obj.axDisplay.YTick = ori(2)+(-8:2:8);
            obj.axDisplay.XLim = ori(1)+[-9,12];
            obj.axDisplay.YLim = ori(2)+[-9,12];
            axis(obj.axDisplay,'equal');
            obj.axDisplay.YDir = 'reverse';
        end
        %%
        function clearDisplayPos(obj,src,data)
             cla(obj.axDisplay);
             obj.axDisplay.NextPlot = 'add';
             obj.axDisplay.XDir = 'normal' ;
             stageMObj = Context.getInstance().getData('mainMObj').stageMObj;
             ori = stageMObj.manualSampleCenter;
             plot(obj.axDisplay,...
                 ori(1)+[-8,8],[ori(2),ori(2)],':','color',[0.5,0.5,0.5]);
             plot(obj.axDisplay,...
                 [ori(1),ori(1)],ori(2)+[-8,8],':','color',[0.5,0.5,0.5]);
        end
        %% attach callback functions
        function attachToController(obj)
            % callback function use callback_ as heard and uictrl name follow.
            % add the func name in the cell array
            u = obj.userCObj;
            funcNames = {'pipelinePopup','browseButton','runButton',...
                'pauseButton','stopButton','tryDetectButton',...
                'recordPosButton','move2RecPosButton','shutterButton',...
                'laserHighButton','laserLowButton',...
                'objDeltaEdit','distanceFromCenterEdit'}; 
            doit(funcNames,'Callback',u)
            
            % 2019/9/3, for uibuttongroup
            funcNames = {'edMethodUibuttongroup'};
            doit(funcNames,'SelectionChangedFcn',u)
            
            function doit(funcNames,funcType,u)
                if isempty(funcNames)
                    return
                end
                for k =1:numel(funcNames)
                    str = strcat('obj.',funcNames{k},'.',funcType,...
                        ' = @u.',...
                        'callback_',funcNames{k},';');
                    eval(str);
                end
            end
        end
    end                         
    
end