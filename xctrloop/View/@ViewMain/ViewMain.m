classdef ViewMain < handle
    properties
        stageVObj;
        piezoVObj;
        cameraVObj;
        userVObj;
        vtVObj;
        objectiveVObj;
        
        mainMObj;
        % mainCObj;

        hfigUser; % figure handle and other props for User and Camera
        hfigAPT; % % figure handle and other props for APT control
        screensz_array;
        
        imParameterTag = 'imP';
    end
    
    properties(Constant)
        screensz = get(0,'screensize');
    end
    
    methods
        %% constructor
        function obj = ViewMain(mainMObj)            
            obj.mainMObj = mainMObj;
            
            obj.register();
            obj.createFigure();
            obj.createSubViewer(mainMObj);
            
            % build user figure, APT figure built in StageV and PiezoV
            obj.buildUI();

            obj.attachToSubController();
            %}
            
            obj.groupFigure();
        end
        %%
        function createFigure(obj)
            obj.screensz_array = [obj.screensz(3:4),obj.screensz(3:4)];
            
            % create APT figure ---------------------------
            % fpos = [0 .046 .2 0.92];
            fpos = [0.0057,0.049,0.250,0.919];
            obj.hfigAPT = figure('Units','normalized',...
                'Position', fpos,...
                'Menu','None',...
                'Name','GuoLab',...
                'resize','off',...
                'CloseRequestFcn',@func_figClosereq,...
                'Visible','off',...
                'NumberTitle','off');
            
            % --------------------------------------------------
            
            % create user figure ---------------------------
            % fpos = [fpos(3)+0.01,fpos(2),1-fpos(3)-0.01,fpos(4)];
            fpos = [0.2650,0.0490,0.726,0.919];
            obj.hfigUser = figure('Units','normalized',...
                'Position', fpos,...
                'Menu','None',...
                'Name','GuoLab',...
                'resize','off',...
                'CloseRequestFcn',@func_figClosereq,...
                'Visible','off',...
                'NumberTitle','off');
            %-------------------------------------------------------------------
        end
        %%
        function createSubViewer(obj,mainMObj)
            obj.stageVObj = StageV(mainMObj.stageMObj);
            obj.piezoVObj = PiezoV(mainMObj.piezoMObj);
            obj.cameraVObj = CameraV(mainMObj.cameraMObj);
            
            % userV must be after StageV and PiezoV, because UserC need regist 
            % funcs in stageC and piezoC.
            obj.userVObj = UserV(mainMObj.userMObj); 
            obj.vtVObj = VTV(mainMObj.vtMObj);
            obj.objectiveVObj = ObjectiveV(mainMObj.objectiveMObj);
        end
        %%
        function groupFigure(obj)
            desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
            groupName = 'SDConfocalSystem';
            desktop.addGroup(groupName);
            desktop.setGroupDocked(groupName, 0);
            myDim = java.awt.Dimension(2,1);   % 4 columns, 2 rows
            % 1: Maximized, 2: Tiled, 3: Floating
            desktop.setDocumentArrangement(groupName, 2, myDim)
            
            warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
            
            set(obj.hfigAPT,'WindowStyle', 'docked');
            set(obj.hfigUser,'WindowStyle', 'docked');
            pause(0.02);
            set(get(handle(obj.hfigAPT), 'javaframe'),...
                'GroupName', groupName);
            set(get(handle(obj.hfigUser), 'javaframe'),...
                'GroupName', groupName);
            set(desktop.getFrameContainingGroup(groupName),...
                'Maximized',true);
            
            axis( obj.cameraVObj.axCamera,'square');
            set(obj.hfigAPT,'Visible','on');
            set(obj.hfigUser,'Visible','on');
        end
        %%
        buildUI(obj);
        %% regist mainVObj
        function register(obj)
            conObj = Context.getInstance();
            conObj.register('mainVObj',obj);
        end
        %%
        function attachToSubController(obj)
            obj.stageVObj.attachToController();
            obj.piezoVObj.attachToController();
            obj.userVObj.attachToController();
            obj.cameraVObj.attachToController();
            obj.vtVObj.attachToController(); 
            obj.objectiveVObj.attachToController(); 
        end
    end
end