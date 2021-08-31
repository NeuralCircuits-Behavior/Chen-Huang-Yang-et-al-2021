classdef (Abstract) Protocol < handle
%   PROTOCOL Base class for Protocols. Defines common functionality.
%   This is an abstract class and cannot be instantiated directly. Either
%   use Zaber.Protocol.detect(port) to attempt to automatically
%   instantiate the correct type, or if you know which type is correct
%   instantiate a Zaber.BinaryProtocol or Zaber.AsciiProtocol directly.
%
%   See also detect, Zaber.AsciiProtocol, Zaber.BinaryProtocol

%   Author: Zaber Technologies Software Team <contact@zaber.com>
    

%% Public instance properties
    properties (SetAccess=private)
        % PORT The port that this protocol instance is bound to.
        %
        % See also SerialPort
        Port
    end
    
    
 %% Public instance methods
    methods (Abstract)
        % FINDDEVICES Search for Zaber devices using this protocol.
        % deviceArray = protocol.FINDDEVICES()
        % 
        % This method will attempt to enumerate all Zaber devices using the
        % given protocol and the port it is bound to. May take several
        % seconds depending on the protocol, baud rate and number of
        % devices.
        %
        % See also Zaber.Device
        deviceArray = finddevices(obj)
    end
    
    
    methods
        function flushReceiveBuffer(obj)
            % FLUSHRECEIVEBUFFER Clears any pending input from the port.
            flushinput(obj.Port);
        end
    end
    
    
 %% Public static methods
    methods (Static)
        function protocol = detect(aPort)
        % DETECT Attempts to detect which Zaber protocol to use.
        % protocol = Zaber.Protocol.DETECT(port)
        %
        % port     - A configured and opened port to use.
        % protocol - An AsciiProtocol or BinaryProtocol instance,
        %            depending on which protocol was detected, or the
        %            empty array if detection failed.
        %
        % Given an open port, this function will try to determine
        % whether there are Zaber devices on that port using either the
        % Zaber Binary or Zaber ASCII protocols. If successful, it will
        % return a Zaber.Protocol object wrapping the given port. On
        % failure, it will return an empty array.
        %
        % If you are writing code that attempts to auto-detect Zaber
        % devices, this should be your first call. Once you have
        % detected the protocol, you can then use its finddevices()
        % method to initialize the actual devices.
        %
        % Note that this function does not alter the baud rate of the
        % serial port. If you are unsure what baud rate your devices are
        % set to, you will have to attempt detection at each likely
        % rate in higher-level code.
        %
        % If there are no responses from the serial port, this method
        % will block until the port times out. To change the timeout
        % period and suppress the timeout warning message, use:
        %   set(port, 'Timeout', 0.5)
        %   warning off MATLAB:serial:fread:unsuccessfulRead
        %
        % Note that if there are multiple daisy-chained devices that
        % have different protocol settings, the first one to respond
        % will determine the detection result here.
        %
        % See also Zaber.AsciiProtocol, Zaber.BinaryProtocol


            % Send magic ping that both ASCII and binary devices will respond to.
            magicPing = [ 0, 55, 47, 13, 10, 0 ];
            fwrite(aPort, magicPing);

            response = fread(aPort, 6)';
            
            % Wait until other response data stops coming in, and flush it.
            pause(0.1);
            while (aPort.BytesAvailable > 0)
                flushinput(aPort);
                pause(0.1);
            end

            % If the device echoed back the latter 5 bytes as-is, it's binary.
            if (length(response) == 6)
                if (isequal(magicPing(2:6), response(2:6)))
                    protocol = Zaber.BinaryProtocol(aPort);
                    return;
                end

                % If the response looks like the first 6 bytes of an ASCII
                % response, then it's ASCII.
                if (~isequal([], regexp(char(response), '\@[0-9][0-9] [0-9] ')))
                    protocol = Zaber.AsciiProtocol(aPort);
                    return;
                end
            end
            
            % Default: Return nothing.
            protocol = [];
        end
    end
    
    
 %% Protected instance methods
    methods (Access = protected)
        function obj = Protocol(aPort)
        % PROTOCOL Constructor. Initializes the base class properties.
        %
        % The port argument must be a port object that has already been
        % configured appropriately for the Zaber devices attached, and
        % opened. 
        %
        % This constructor is meant to be used by subclasses only.
        
            obj.Port = aPort;
        end
    end
end

