classdef LogClass < handle
    properties
        fID;
        logstr;
        savePath;
        tempPath;
    end
    
    events
        logChanged;
    end
    
    
    methods(Static)
        %%
        function obj = getInstance()
            persistent localobj;
            if isempty(localobj) || ~isvalid(localobj)
                localobj = LogClass();
            end
            obj = localobj;
        end
    end
    
    methods(Access = private)
        %%
        function obj = LogClass()
            %             obj.fID = fopen('logfile.txt','a');
            %         conObj = Context.getInstance();
            %         mainMObj = conObj.getData('mainMObj');
            %         obj.savePath = mainMObj.savePath;
            obj.tempPath = fileparts(which('LogClass.m'));
            tempName = strcat(obj.tempPath,'\log_temp.txt');
            
            if exist(tempName,'file')
                delete(tempName);
            end
        end
    end
    
    methods(Access = public)
        %%
        function print(obj,str)
            if ~strcmpi(str(end-1:end),'\r\n')
                str = [str,'\r\n'];
            end
            str = obj.timestamp(str);
            fprintf(obj.fID,str);
        end
        
        
        %%
        function str = timestamp(obj,str)
            c = round(clock);
            str = [sprintf('%d.%.2d %d:%.2d:%.2d ',c(2),c(3),c(4),c(5),c(6)),str];
        end
        %% write something into log file in any script
        function writeLog(obj,inputStr)
            obj.fID = fopen(strcat(obj.tempPath,'\log_temp.txt'),'a');
            obj.logstr = inputStr;
            obj.print(inputStr);
            fclose(obj.fID);
            obj.notify('logChanged');
        end
    end
    
    methods
        %%
        function set.logstr(obj,str)
            if ~strcmpi(str(end-1:end),'\n')
                str = [str,'\n'];
            end
            
            str = obj.timestamp(str);
            obj.logstr = ['>> ',str,obj.logstr];
            lineInd = strfind(obj.logstr,'\n');
            maxline = 1000; % trim when more than 1000 lines
            if numel(lineInd) > maxline
                obj.logstr = obj.logstr(1:lineInd(maxline)+2);
            end
        end
    end
end










