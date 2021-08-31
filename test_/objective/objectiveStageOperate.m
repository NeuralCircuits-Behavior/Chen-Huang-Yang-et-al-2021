function objectiveStageOperate(port,input)
% 2018/3/13, CH
% simple control objective stepper(Henggong) using 
% procedure-oriented programming
% port, serial port, like 'COM1'
% input, array [X,Z] targetPosition, nan means not move or
%        char, cmd, like 'HZ','HX','?X','?Z', could be cell array, opreate 
%           one by one

s = operate(connectStepper(createSerial(port,input)));
clearSerial(s);

    function s = createSerial(port,input)
        try
            s = serial(port);
            s.Terminator = {'LF','CR'};
            s.Timeout = 25;
            s.UserData = input;
        catch ME
            error(ME.message);
        end
    end

    function s = connectStepper(s)
        if strcmpi(s.Status,'closed')
            try
                fopen(s);
            catch ME
                clearSerial(s);
                error(ME.message);
            end
        end
        backInfo = sendCmd(s,'?R');
        if checkBackInfo(backInfo,'?R')
            return
        else
            clearSerial(s);
            error('Objective stepper failed to connect.')
        end
    end

    function s = operate(s)
        switch class(s.UserData)
            case 'double'
                % targetPosition, numtric
                axisMove(s,'Z');
                axisMove(s,'X');
            case 'char'
                directSendCmd(s,s.UserData);
            case 'cell'
                if all(cellfun(@(i)isequal(class(i),'char'),s.UserData))
                    for k = 1:numel(s.UserData)
                        directSendCmd(s,s.UserData{k});
                    end
                else
                    clearSerial(s);
                    error('Only allow char in the cell input.');
                end
        end
        
        function directSendCmd(s,c)
            b = sendCmd(s,c);
            if ismember('?',c)
                fprintf('\n');
                disp(b);
            end
        end
        
        function axisMove(s,axis)
            backInfo = sendCmd(s,strcat('?',axis));
            delta = s.UserData(strfind('XZ',axis)) - ...
                str2double(regexp(backInfo,'\d+','match'));
            if isnan(delta)
                fprintf('Objective axis %c did not move.\n',axis);
                return
            elseif ~delta
                fprintf('Objective already at %c target postion.\n',axis);
                return
            end
            cmd = strcat(axis,num2str(delta,'%+d'));
            backInfo = sendCmd(s,cmd);
            if checkBackInfo(backInfo,cmd)
                fprintf('Objective moved to %c target postion.\n',axis);
            else
                clearSerial(s);
                error(backInfo);
            end
        end
    end

%% gernal function
    function clearBuffer(s)
        while s.BytesAvailable
            fgetl(s);
        end
    end

    function clearSerial(s)
        fclose(s);
        delete(s);
    end

    function backInfo = sendCmd(s,cmd)
        clearBuffer(s);
        fprintf(s,cmd);
        backInfo = fgetl(s);
    end

    function tfSucess = checkBackInfo(backInfo,cmd)
        tfSucess = ...
            isequal(backInfo,sprintf(strcat(cmd,'\rOK')));
    end
end