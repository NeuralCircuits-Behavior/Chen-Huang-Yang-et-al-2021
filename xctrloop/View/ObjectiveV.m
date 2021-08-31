classdef ObjectiveV < handle
    % 2018/5/3, CH
    
    properties
        objectiveMObj;
        objectiveCObj;
        
        xStateText;
        to16XButton;
        to40XButton;
        
        zStateText;
        raiseButton;
        pulldownButton;
        
        setFocusPlaneButton;
        alignButton;
    end
    
    properties(Constant)
        xPair = {'16X','40X'};
        zPair = {'Defocus','Focus'};
        xColor = [0.47,0.67,0.19;0,0.45,0.74];
        zColor = [0.64,0.08,0.18;0.47,0.67,0.19];
    end
    
    methods
        function obj = ObjectiveV(m)
            obj.objectiveMObj = m;
            obj.makeContoller();
            
            m.addlistener('updateXState',@obj.updateXState);
            m.addlistener('updateZState',@obj.updateZState);
        end
        
        function updateXState(obj,src,data)
            set_ = @(v,c)set(obj.xStateText,'Value',v,'String',src.xState,...
                'BackgroundColor',c);
            switch src.xState
                case '16X'
                    set_(0,obj.xColor(ismember(obj.xPair,'16X'),:));
                    LogClass.getInstance().writeLog('Shift objective to 16X.');  
                case '40X'
                    set_(0,obj.xColor(ismember(obj.xPair,'40X'),:));
                    LogClass.getInstance().writeLog('Shift objective to 40X.');
            end
        end
        
        function updateZState(obj,src,data)
            set_ = @(v,c)set(obj.zStateText,'Value',v,'String',src.zState,...
                'BackgroundColor',c);
            switch src.zState
                case 'Defocus'
                    set_(0,obj.zColor(ismember(obj.zPair,'Defocus'),:));
                    LogClass.getInstance().writeLog('Raise objectives.');
                case 'Focus'
                    set_(0,obj.zColor(ismember(obj.zPair,'Focus'),:));
                    LogClass.getInstance().writeLog('Pulldown objectives.');
            end
        end
        
        function makeContoller(obj)
            obj.objectiveCObj = ObjectiveC(obj,obj.objectiveMObj);
        end
        
        function attachToController(obj)          
            c = obj.objectiveCObj;
            funcNames = {'to16XButton','to40XButton','raiseButton',...
                'pulldownButton','setFocusPlaneButton','alignButton'};
            if ~obj.objectiveMObj.fDeploy || isempty(funcNames)
                return
            end
            for k =1:numel(funcNames)
                str = strcat('obj.',funcNames{k},...
                    '.Callback = @c.','callback_',funcNames{k},';');
                eval(str);
            end
        end
    end
    
    
    
    
    
    
    
    
end