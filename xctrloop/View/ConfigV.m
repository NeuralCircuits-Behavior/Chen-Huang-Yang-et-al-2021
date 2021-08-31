classdef ConfigV < handle
    properties
        configMObj;
        configCObj;
        
        hfig;
        
        % uicontrols
        objectiveText;
        objectivePopup;
        
        objectivexText;
        objectivexPopup;
        
        csuText;
        csuPopup;
        
        laserText;
        laserPopup;
        
        arduinoText;
        arduinoPopup;
        
        cameraText;
        cameraPopup;
        
        stagesText;
        stagesPopup;
        
        piezoText;
        piezoPopup;
        
        refreshButton;
        clearButton;
        nextButton;
        cancelButton;
        
        sInfo;
        portOptions;
    end
    
    properties(Constant)
        screensz = get(0,'screensize');
    end
    
    methods
        function obj = ConfigV(configMObj)
            if ~nargin;return;end
            obj.configMObj = configMObj;
            obj.buildUI();
            obj.makeContoller();
            obj.attachToController(); 
        end
        
        function sInfo = get.sInfo(obj)
            sInfo = instrhwinfo('serial');
        end
        
        function portOptions = get.portOptions(obj)
            portOptions = vertcat('Not use',obj.sInfo.AvailableSerialPorts(:));
        end
        
        function buildUI(obj)
            fpos = [0.3890,0.3130,0.2660,0.3370];
            obj.hfig = figure('Units','normalized',...
                'Position', fpos,...
                'Menu','None',...
                'Name','Startup Configuration Wizard',...
                'resize','off','NumberTitle','off');
            
            L0 = uiextras.VBox('Parent',obj.hfig,'Padding',8,'Spacing',10);
            
            L0_1 = uiextras.VBox('Parent',L0,'Spacing',10);
            L0_2 = uipanel('Parent',L0);
            
            L0_3 = uiextras.HBox('Parent',L0,'Spacing',10);
            
            % topper 
            uicontrol('Parent',L0_1,...
                'style','text','string',...
                'GuoLab Spinning Disk Confocal Microscopy System',...
                'horizontalalignment','left',...
                'fontweight','bold',...
                'FontSize',13);
            uicontrol('Parent',L0_1,...
                'style','text','string',...
                'Startup Configuration Wizard',...
                'horizontalalignment','left',...
                'fontweight','bold',...
                'FontSize',10);
            set(L0_1,'sizes',[-0.6,-0.4],'spacing',1,'padding',2);
            
            % med
            % med-left
            L0_2_1 = uiextras.HBox('Parent',L0_2,'Spacing',10);
            L0_2_1_1 = uiextras.Grid('Parent',L0_2_1);
            portText = @(L0_2_1_1,str)uicontrol('Parent',L0_2_1_1,...
                'style','text','String',str,...
                'horizontalalignment','right',...
                'fontweight','bold','FontSize',9);
            obj.objectiveText = portText(L0_2_1_1,'Objective Z Port: ');
            obj.objectivexText = portText(L0_2_1_1,'Objective X Port: ');
            obj.csuText = portText(L0_2_1_1,'CSU Ctrl Port: '); 
            obj.laserText = portText(L0_2_1_1,'Laser Ctrl Port: ');  
            obj.arduinoText = portText(L0_2_1_1,'Arduino Ctrl Port: '); 
            
            portPop = @(L0_2_1_1,obj)uicontrol('Parent',L0_2_1_1,...
                'style','popupmenu','string',obj.portOptions,...
                'horizontalalignment','left');
            obj.objectivePopup = portPop(L0_2_1_1,obj);
            obj.objectivexPopup = portPop(L0_2_1_1,obj);
            obj.csuPopup = portPop(L0_2_1_1,obj);
            obj.laserPopup = portPop(L0_2_1_1,obj);
            obj.arduinoPopup = portPop(L0_2_1_1,obj);
            set(L0_2_1_1,'rowsizes',[-1,-1,-1,-1],...
                'columnsizes',[-0.6,-0.4],...
                'spacing',5,'padding',5);
            
            % med-right
            L0_2_1_2 = uiextras.Grid('Parent',L0_2_1);
            obj.cameraText = portText(L0_2_1_2,'Camera: ');
            obj.stagesText = portText(L0_2_1_2,'Stages: ');
            obj.piezoText = portText(L0_2_1_2,'Piezo: ');
            uiextras.Empty('Parent',L0_2_1_2);
            uiextras.Empty('Parent',L0_2_1_2);
            
            portPop = @(L0_2_1_1)uicontrol('Parent',L0_2_1_1,...
                'style','popupmenu','string','Not use|Use',...
                'Value',2,...
                'horizontalalignment','left');
            obj.cameraPopup = portPop(L0_2_1_2);
            obj.stagesPopup = portPop(L0_2_1_2);
            obj.piezoPopup = portPop(L0_2_1_2);
            uiextras.Empty('Parent',L0_2_1_2);
            uiextras.Empty('Parent',L0_2_1_2);
            
            set(L0_2_1_2,'rowsizes',[-1,-1,-1,-1,-1],...
                'columnsizes',[-0.6,-0.4],...
                'spacing',5,'padding',5);
            
            set(L0_2_1,'sizes',[-1,-1],'spacing',10,'padding',10);
            
            % bottem
            buttonFunc = @(L0_3,str)uicontrol('Parent',L0_3,...
                'style','pushbutton','string',str,'fontweight','bold');
            obj.refreshButton = buttonFunc(L0_3,'Refresh Ports');
            obj.clearButton = buttonFunc(L0_3,'Clear all');
            uiextras.Empty('Parent',L0_3);
            obj.nextButton = buttonFunc(L0_3,'Next');
            obj.cancelButton = buttonFunc(L0_3,'Cancel');
            
            set(L0_3,'sizes',[-1,-1,-1,-1,-1],'spacing',5,'padding',5);
            
            set(L0,'sizes',[-0.15,-0.75,-0.10]);
        end
            
        function makeContoller(obj)
            obj.configCObj = ConfigC(obj,obj.configMObj);
        end
        
        function attachToController(obj)          
            configCObj = obj.configCObj;
            funcNames = {'refreshButton',...
                'nextButton',...
                'clearButton',...
                'cancelButton'};
            for k =1:numel(funcNames)
                str = strcat('obj.',funcNames{k},...
                    '.Callback = @configCObj.','callback_',funcNames{k},';');
                eval(str);
            end
        end
    end









end