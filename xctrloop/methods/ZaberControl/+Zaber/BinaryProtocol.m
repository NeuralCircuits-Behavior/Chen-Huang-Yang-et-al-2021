classdef BinaryProtocol < Zaber.Protocol
%   BINARYPROTOCOL Zaber Binary protocol communication helper.
%   This class wraps a port instance and provides facilities for sending 
%   and receiving device messages using the BinaryMessage helper class.
%
%   See also Zaber.BinaryMessage, Zaber.Device, Zaber.Protocol,
%   Zaber.AsciiProtocol
 
%   Author: Zaber Technologies Software Team <contact@zaber.com>


%% Public instance methods
    methods
        function obj = BinaryProtocol(aPort)
        % BINARYPROTOCOL Constructor. Initializes the object properties.
        % protocol = Zaber.BINARYPROTOCOL(port)
        %
        % port     - An port that has already been configured and opened.
        % protocol - The initialized BinaryProtocol instance.
        %
        % This assumes you are certain the port is connected to Zaber
        % devices that are using the Binary protocol, and that the port is
        % set to the correct baud rate already.
            
            obj = obj@Zaber.Protocol(aPort);
        end
        
        
        function send(obj, aCommand)
        % SEND Send a binary command out over the port.
        % protocol.SEND(message)
        %
        % message - Either a BinaryMessage instance or an array of six
        %           bytes.
        %
        % Transmits a message over the port without waitinf for a
        % response. If the argument is a BinaryMessage, it will
        % automatically be serialized to six bytes and then sent. 
        %
        % See also receive, request
        
            packet = aCommand;
            if (isa(aCommand, 'Zaber.BinaryMessage'))
                packet = aCommand.serialize();
            end
            
            if (length(packet) ~= 6)
                error('Zaber:BinaryProtocol:send:badDataType', ...
                      'Binary protocol expects a BinaryMessage or 6 bytes.');
            end
            
            fwrite(obj.Port, packet, 'uint8');
        end
        
        
        function response = receive(obj, aMessageIdsEnabled)
        % RECEIVE Wait for a reply from any device
        % message = protocol.RECEIVE()
        % message = protocol.RECEIVE(idsenabled)
        %
        % idsenabled - Optional. Pass in true if the device has message
        %              ID mode enabled. This will cause the message IDs
        %              to automatically be separated from the data.
        % message    - The deserialized message, or the empty array if
        %              the port timed out.
        %
        % This method attempts to read six bytes from the port, and if
        % successful will attempt to parse that data into a BinaryMessage
        % object and return that. 
        %
        % If the read attempt times out (using the port's timeout setting)
        % then an empty array is returned.
        %
        % If data is read but there is an error attempting to parse it, an
        % error may be thrown.
        %
        % NOTE: This function blocks until either six bytes are received 
        % or the port times out. To change the timeout and suppress the 
        % timeout watning message, use these commands before opening the
        % port:
        %   set(port, 'Timeout', 0.5)
        %   warning off MATLAB:serial:fread:unsuccessfulRead
        %
        % See also send, request, canreceive
        
            data = fread(obj.Port, 6, 'uint8')';
            
            response = [];
            if (length(data) == 6)
                if (nargin > 1)
                    response = Zaber.BinaryMessage.deserialize(data, ...
                        aMessageIdsEnabled);
                else
                    response = Zaber.BinaryMessage.deserialize(data);
                end
            end
        end
        
        
        function ok = canreceive(obj)
        % CANRECEIVE Non-blocking check to see if a message is
        % available to receive.
        %
        % ok = protocol.canreceive();
        %
        % ok - Return value. True if six or more bytes are available in the
        %      port receive buffer. False otherwise.
        %
        % See also receive
        
            ok = (obj.Port.BytesAvailable >= 6);
        end
        
        
        function response = request(obj, aCommand)
        % REQUEST Send a command and return the next reply.
        % reply = protocol.REQUEST(command)
        %
        % Transmits the given BinaryMessage over the port and blocks until
        % either the first reply is received or the port times out. 
        %
        % NOTE this method is only safe to use if you use one device at 
        % a time and one command at a time. This method does not
        % correlate replies with commands so if there are multiple
        % devices in use or overlapping commands, it is possible the
        % reply you receive came from a device other than the one you
        % sent the command to, or that the reply is for a different
        % command. 
        %
        % See also send, receive
        
            obj.send(aCommand);
            if (aCommand.MessageId ~= 0)
                response = obj.receive(true);
            else
                response = obj.receive();
            end
        end
        
        
        function deviceArray = finddevices(obj)
        % FINDDEVICES Enumerate all available devices.
        % deviceArray = protocol.FINDDEVICES()
        %
        % Attempts to identify all Zaber devices available on the given
        % port using the Binary protocol. Returns an array of Zaber.Device
        % objects, which may be empty if none were found. 
        %
        % Warning messages are printed if any devices respond with an error
        % status.
        %
        % NOTE this method always waits for the port to time out in order
        % to be certain all device messages have been received. To reduce
        % the wait time and suppress the timeout warning messages, use the
        % following commands before opening the port:
        %   set(port, 'Timeout', 0.5)
        %   warning off MATLAB:serial:fread:unsuccessfulRead
        %
        % See also Zaber.Device, Zaber.AsciiProtocol.finddevices
        
            deviceArray = [];
            deviceIdArray = [];
            obj.send(...
                Zaber.BinaryMessage(0, ...
                    Zaber.BinaryCommandType.Return_Device_ID, 0));
                
            message = obj.receive();
            while (isa(message, 'Zaber.BinaryMessage'))
                if ((message.Command == Zaber.BinaryCommandType.Return_Device_ID) || ...
                    (message.Command == 3))
                    row = {message.DeviceNo message.Data};
                    deviceIdArray = [deviceIdArray ; row];
                elseif (message.IsError)
                    warning('Zaber:BinaryProtocol:finddevices:deviceError', ...
                            'Got error response %d from device %d.', ...
                            message.Data, message.DeviceNo);
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

