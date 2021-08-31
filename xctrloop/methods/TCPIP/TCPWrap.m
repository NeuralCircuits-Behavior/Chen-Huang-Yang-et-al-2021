classdef TCPWrap < handle
    properties
        port = 5001;
        address = '127.0.0.1';
        outType = 'uint16';
        outTypeBytes = 2;
        outSize = [512,512];
        tcpObj;
        
        % 2 used to connect to labview to generate pulses
        port2 = 5002;
        address2 = 'localhost';
        tcpObj2;
    end
    
    methods
        function obj = TCPWrap(address,port,outType,outTypeBytes,outSize)            
            if nargin>0
                obj.port = port;
                obj.address = address;
                obj.outType = outType;
                obj.outTypeBytes = outTypeBytes;
                obj.outSize = outSize;
            end
            
            obj.tcpObj = obj.createTCPClientObj();
            obj.tcpObj2 = obj.createTCPClientObj2();
            %}
        end
        
        function tcpObj = createTCPClientObj(obj)
            obj.tcpObj = tcpip(obj.address,obj.port,...
                'NetworkRole','client',...
                'OutputBufferSize',(prod([1200,1200])+1)*obj.outTypeBytes,...
                'InputBufferSize',10000,'Timeout',30);
            tcpObj = obj.tcpObj;
        end
        
        function tcpObj = createTCPClientObj2(obj)
            obj.tcpObj2 = tcpip(obj.address2,...
                obj.port2, 'NetworkRole', 'client','Timeout',24*40*60);
            tcpObj = obj.tcpObj2;
        end

        function res = fread_(obj,needBytes)
            % return res double(could be array)

            res = arrayfun(@str2double,obj.fread_0(needBytes)); % col vec
        end
        
        function res = fread_0(obj,needBytes)
            % return res str
            
            if nargin == 1
                needBytes = 1;
            end
            
            while obj.tcpObj.BytesAvailable < needBytes
                pause(0.001);
            end
            res = char(fread(obj.tcpObj,needBytes)); 
        end
        
        function fwrite_(obj,data,type)
            if nargin<3
                type = obj.outType;
            end
            fwrite(obj.tcpObj,data,type);
        end
        
        function clearBuffer(obj)
            if ~obj.tcpObj.BytesAvailable
                return
            end
            obj.fread_(obj.tcpObj.BytesAvailable);
        end
        
        function fwrite2labVIEW(obj,data)
            [sendLength,str] = getString(data);
            fwrite(obj.tcpObj2,sendLength);
            fwrite(obj.tcpObj2,str);
        end
    end
   
end

function [sendLength,str] = getString(input)
switch class(input)
    case 'struct'
        str = sprintf('A%dB%dC%.1fD%.4f',...
            input.sPos,input.ePos,input.speed,input.iniPos);
    case 'char'
        str = input;
end

sendLength = num2str(length(str),'%07d');
end