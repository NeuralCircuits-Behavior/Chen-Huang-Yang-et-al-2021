classdef AsciiProtocol < Zaber.Protocol
%   ASCIIPROTOCOL Zaber ASCII protocol communication helper.
%   This class wraps a port instance and provides facilities for sending 
%   and receiving device messages using the AsciiMessage helper class.
%
%   See also Zaber.Protocol, Zaber.Protocol.detect, Zaber.AsciiMessage,
%   Zaber. Device, Zaber.AsciiDevice 
 
%% Public instance methods 
    methods
        function obj = AsciiProtocol(aPort)
        % ASCIIPROTOCOL Constructor. Initializes the object properties.
        % protocol = Zaber.ASCIIPROTOCOL(port);
        %
        % port  - An already configured and opened port.
        % obj   - An initialized AsciiProtocol instance containing a
        %         reference to the given port.
        %
        % This assumes you are certain the port is connected to Zaber
        % devices that are using the ASCII protocol, and that the port
        % is set to the correct baud rate already.
        %
        % See also Zaber.Protocol.detect
            
            obj = obj@Zaber.Protocol(aPort);
        end
        
        
        function send(obj, aCommand)
        % SEND Send an ASCII command out over the port.
        % protocol.SEND(message);
        %
        % message - A string or AsciiMessage to be transmitted.
        %
        % Transmits either a verbatim string or an AsciiMessage object
        % over the port. If the argument is an AsciiMessage, it will
        % automatically be serialized to a string and then sent.
        % This method does not wait for a response.
        %
        % See also receive, request, AsciiMessage
            
            message = aCommand;
            if (isa(message, 'Zaber.AsciiMessage'))
                message = message.serialize();
            end
            
            if (isa(message, 'char'))
                message = unicode2native(message, 'US-ASCII');
            end
            
            fwrite(obj.Port, message);
        end
        
        
        function response = receive(obj)
        % RECEIVE Wait for a reply and attempt to parse it.
        % response = protocol.RECEIVE()
        %
        % response - The next response from the serial port if it is a
        %            valid ASCII protocol message, or an empty array if
        %            the port times out.
        %
        % This method attempts to read a line of text from the port,
        % and if successful will attempt to parse that data into an
        % AsciiMessage object and return that.
        %
        % If the read attempt times out (using the port's timeout
        % setting) or no data is received then an empty array is
        % returned. 
        %
        % If data is read but there is an error attempting to parse it,
        % an error may be thrown.
        %
        % NOTE: This function blocks until either a CR/LF is received 
        % or the port times out. To change the timeout and suppress the
        % timeout watning message, use these commands before opening
        % the port:
        %   set(port, 'Timeout', 0.5)
        %   warning off MATLAB:serial:fgetl:unsuccessfulRead
        %
        % See also send, request, AsciiMessage
            
            data = fgetl(obj.Port);
            if (~isempty(data))
                response = Zaber.AsciiMessage.deserialize(data);
            else
                response = [];
            end
        end
        
        
        function response = request(obj, aCommand)
        % REQUEST Send a command and return the next reply.
        % response = protocol.REQUEST(message)
        %
        % message  - An AsciiMessage or string to transmit.
        % response - The next AsciiMessage read from the port, or an
        %            empty array if the port times out.
        %
        % Transmits the given AsciiMessage over the port and blocks
        % until either the first reply is received or the port times
        % out.  
        %
        % If data is received but it does not successfully parse into
        % an AsciiMessage, an error will be thrown.
        %
        % NOTE this method is only safe to use if you use one device at
        % a time and one command at a time. This method does not
        % correlate replies with commands so if there are multiple
        % devices in use or overlapping commands, it is possible the
        % reply you receive came from a device other than the one you
        % send the command to, or that the reply is for a different
        % command.  
        %
        % See also send, receive, AsciiMessage
            
            obj.send(aCommand);
            response = obj.receive();
        end
        
        
        function deviceArray = finddevices(obj)
        % FINDDEVICES Enumerate all available devices on the port.
        % deviceArray = protocol.FINDDEVICES()
        %
        % deviceArray - An array of zero or more Device instances.
        %
        % Attempts to identify all Zaber devices available on the given
        % port using the ASCII protocol. Returns an array of
        % Zaber.Device objects, which may be empty if none were found. 
        %
        % Warning messages are printed if any devices respond with an
        % error status.
        %
        % NOTE this method always waits for the port to time out in
        % order to be certain all device messages have been received.
        % To reduce the wait time and suppress the timeout warning
        % messages, use the following commands before opening the port:
        %   set(port, 'Timeout', 0.5)
        %   warning off MATLAB:serial:fgetl:unsuccessfulRead
        %
        % See also Zaber.Device, Zaber.AsciiDevice
            
            deviceArray = [];
            deviceIdArray = [];
            obj.send(Zaber.AsciiMessage(0, 'get deviceid', []));
            
            message = obj.receive();
            while (isa(message, 'Zaber.AsciiMessage'))
                if (message.MessageType == Zaber.MessageType.Response)
                    if (~message.IsError)
                        row = {message.DeviceNo message.Data};
                        deviceIdArray = [deviceIdArray ; row];
                    else
                        warning('Zaber:AsciiProtocol:finddevices:errorResponse', ...
                                'Got error response %s from device %d.', ...
                                message.DataString, message.DeviceNo);
                    end
                end
                
                message = obj.receive();
            end
            
            sz = size(deviceIdArray);
            for (i = 1:sz(1))
                pair = deviceIdArray(i,:);
                device = Zaber.Device.initialize(obj, pair{1}, pair{2});
                if (isa(device, 'Zaber.Device'))
                    deviceArray = [deviceArray device];
                end
            end
        end
    end
end

