classdef ConfigC < handle
    properties
        configMObj;
        configVObj;
        
        fNeedRetry;
        
    end
    
    methods
        function obj = ConfigC(configVObj,configMObj)
            obj.configMObj = configMObj;
            obj.configVObj = configVObj;
        end
        
        function callback_refreshButton(obj,src,data)
            v = obj.configVObj;
            [v.objectivePopup.String,...
             v.csuPopup.String,...
             v.laserPopup.String,...
             v.arduinoPopup.String,...
             v.objectivexPopup.String] = ...
             deal(v.portOptions);
        end
        
        function callback_nextButton(obj,src,data)
            v = obj.configVObj;
            m = obj.configMObj;
            
            % repeated port check
            values = [v.objectivePopup.Value,...
                v.csuPopup.Value,...
                v.laserPopup.Value,...
                v.arduinoPopup.Value,...
                v.objectivexPopup.Value];
            if nnz(values>1) ~= numel(unique(values(values>1)))
                errordlg('Same ports were chosen.','Port Error');
                return
            end
            
            obj.fNeedRetry = 0;
           
            % deal with hardwares
            tags = [m.portTags,m.arduinoTag,m.cameraTag,m.generalTags];
            for k = 1:numel(tags)
                if obj.fNeedRetry
                    obj.callback_clearButton();
                    return
                end
                
                tag = tags{k};
                c = eval(strcat('v.',lower(tag),'Popup;'));
                if c.Value > 1
                    m.writefDeploy(tag,1);
                    switch tag
                        case m.portTags
                            obj.fNeedRetry = ...
                                portMethod_(c,m,tag,obj.fNeedRetry);
                        case m.arduinoTag
                            obj.fNeedRetry = ...
                                arduinoMethod_(c,m,tag,obj.fNeedRetry);
                        case m.cameraTag
                            obj.fNeedRetry = ...
                                cameraMethod_(m,tag,obj.fNeedRetry);
                        case m.generalTags
                            continue
                    end
                else
                    m.writefDeploy(tag,0);
                end
            end
            
            if confirmUser(m)
                obj.callback_clearButton();
                return
            else
                % initiate whole program
                v.hfig.Visible = 'off';
                m.initiateProgram();
            end
            
            function fNeedRetry = portMethod_(c,m,tag,fNeedRetry)
                s = tryConnectPort(c,m,tag);
                if isempty(s)
                    fNeedRetry = fNeedRetry || 1;
                else
                    m.setSerialObj(tag,s);
                end
                
                function s = tryConnectPort(c,m,tag)
                    % not detailed setting here, terminator and timeout
                    % need set again
                    
                    P = eval(strcat('m.',lower(tag),'P;'));
                    s = serial(c.String{c.Value},'Tag',m.serialTag,...
                        'Terminator',P{1},'BaudRate',P{2},...
                        'InputBufferSize',10240);
                    try
                        fopen(s);
                        fprintf(s,P{3});
                        pause(0.1);
                        if ~s.BytesAvailable
                            errordlg({'Can not connect hardware.',...
                                'Please connect first.'},...
                                sprintf('%s Port Error',tag));
                            delete(s);
                            s = [];
                        else
                            char(fread(s,s.BytesAvailable));
                        end
                    catch ME
                        errordlg({ME.message,'Please Retry.'},...
                            sprintf('%s Port Error',m.serialTag));
                        delete(s);
                        s = [];
                    end
                end
            end
            
            function fNeedRetry = arduinoMethod_(c,m,tag,fNeedRetry)
                try
                    m.arduinoS = arduino(c.String{c.Value});
                catch ME
                    fNeedRetry = fNeedRetry || 1;
                    errordlg({ME.message,'Please Retry.'},...
                        sprintf('%s Error',tag));
                end
            end
            
            function fNeedRetry = cameraMethod_(m,tag,fNeedRetry)
                try
                    m.setVid(videoinput('pmimaq', 1, 'PM-Cam 1200x1200'));
                catch ME
                    fNeedRetry = fNeedRetry || 1;
                    if contains(ME.identifier,'noDevices')
                        msg = {'No camera detcted.','Please Retry'};
                    else
                        msg = {'Unknow camera error.','Please Retry'};
                    end
                    errordlg(msg,sprintf('%s Error',tag));
                end
            end
            
            function fCancel = confirmUser(m)
                fCancel = 0;
                if any(m.configArray(6:7))
                    answer = questdlg(...
                        {'Stages and Piezo were not checked their accessibility,',...
                        'please make sure the hardwares have been already connected.'},...
                        'Confirm dialog','OK, continue','Check once more',...
                        'Check once more');
                    switch answer
                        case 'Check once more'
                            fCancel = 1;
                    end
                end
            end
        end
        
        function callback_clearButton(obj,src,data)
            delete(instrfind('type','serial','tag',obj.configMObj.serialTag));
            delete(imaqfind);
            obj.configMObj.arduinoS = [];
        end
        
        function callback_cancelButton(obj,src,data)
            obj.callback_clearButton();
            delete(obj.configVObj.hfig);
        end
    
    end
end