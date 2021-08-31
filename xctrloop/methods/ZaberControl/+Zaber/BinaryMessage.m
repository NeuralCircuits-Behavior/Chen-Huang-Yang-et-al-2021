classdef BinaryMessage < handle
%   BINARYMESSAGE Helper class for Zaber Binary protocol messages.
%   This class helps serialize and deserialize 6-byte binary messages 
%   used by the Zaber Binary protocol into their constituent parts.
%
%   See also BinaryProtocol, Device, BinaryDevice

%   Author: Zaber Technologies Software Team <contact@zaber.com>

    
%% Public instance properties
    properties
        % DEVICENO The address of a device being addressed.
        % For requests this will be the device the command is addressed
        % to, in the range of 1-99, or 0 to address all devices.
        % In replies this will be the address of the device responding.
        DeviceNo
        
        % COMMAND The command being issued or responded to.
        % Legal values are 0-255. See the Zaber Binary Protocol 
        % Manual for the meanings of the values:
        % http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual or use
        % the Zaber.BinaryCommandType enumeration.
        %
        % See also Data, Zaber.BinaryCommandType, Zaber.BinaryReplyType
        Command
        
        % MESSAGEID Optional message ID for correlating messages.
        % If message ID mode is enabled on a device, this value will
        % be echoed back by the device in its replies. Otherwise
        % the value should be zero. Note that use of message IDs
        % reduces the number of data bits available from 32 to 24.
        %
        % See also Data
        MessageId
        
        % DATA Data payload for requests and responses.
        % A signed integer. 32 bits, or 24 bits if message ID mode is
        % enabled, in which case this property is automatically 
        % sign-extended to 32 bits after deserialization.
        %
        % See also Command, MessageId
        Data
        
        % ISERROR True if this message represents a device error state.
        IsError
        
        % MESSAGETYPE Identifies whether this message is a request (a
        % command for a device) or a response (a reply from the device).
        MessageType
    end
    
 
 %% Public instance methods
    methods
        function obj = BinaryMessage(aDeviceNumber, aCommand, aData, aMessageId)
        % BINARYMESSAGE Construct a BinaryMessage object from values.
        % message = Zaber.BINARYMESSAGE(address, command, data)
        % message = Zaber.BINARYMESSAGE(address, command, data, messageid)
        %
        % address   - The daisy chain address of the device to talk to.
        % command   - The command or reply code for the message.
        % data      - The data payload. Use 0 when not applicable.
        % messageid - Optional message ID.
        %
        % This function constructs an instance of the BinaryMessage
        % class with its properties initialized. See the property
        % descriptions for information about the corresponding arguments. 
        %
        % NOTE
        % The message ID argument is optional and should only be used if
        % message ID mode is enabled on the device the command is being
        % sent to.

            if ((aDeviceNumber < 0) || (aDeviceNumber > 99))
                error('Zaber:BinaryMessage:badDeviceNo', ...
                      'Zaber device IDs must range from 0 to 99.');
            end
            
            obj.DeviceNo = uint8(aDeviceNumber);
            obj.MessageType = Zaber.MessageType.Request;
            
            if ((aCommand < 0) || (aCommand > 255))
                error('Zaber:Binarymessage:badCommandNo', ...
                      'Zaber binary command numbers must range from 0 to 255.');
            end
            
            obj.Command = uint8(aCommand);
            obj.IsError = (obj.Command == Zaber.BinaryReplyType.Error);
            
            val = int32(aData);
            
            if (nargin < 4)
                obj.MessageId = uint8(0);
            else
                if ((aMessageId < 0) || (aMessageId > 255))
                    error('Zaber:BinaryMessage:badMessageId', ...
                          'Message IDs must be in the range of 0 to 255.');
                end
                
                obj.MessageId = uint8(aMessageId);
            end
            
            obj.Data = val;
        end
        
        
        function bytes = serialize(obj)
        % SERIALIZE Convert to an array of bytes suitable for transmission.
        % bytes = message.SERIALIZE()
        %
        % Returns an array of six bytes ready to be transmitted to a
        % Zaber device using the Binary protocol.
        %
        % If the MessageId property is nonzero, this will truncate the
        % Data value to 24 bits and throw an error if doing so would
        % cause data loss.
        %
        % See also deserialize
        
            bytes = [ obj.DeviceNo obj.Command ];
            
            val = int64(obj.Data);
            if (val < 0)
                val = val + 256^4;
            end
            
            val = uint32(val);
            
            maxData = intmax('uint32');
            if (obj.MessageId > 0)
                maxData = 256 ^ 3 - 1;
            end
            
            if ((val < 0) || (val > maxData))
                error('Zaber:BinaryMessage:serialize:outOfRange', ...
                      'Data value ' + num2str(obj.Data) + ' cannot be represented.');
            end
            
            if (obj.MessageId > 0)
                for (i = 1:3)
                    byte = bitand(val, 255);
                    bytes = [bytes byte];
                    val = bitshift(val, -8);
                end
                bytes = [ bytes obj.MessageId ];
            else
                for (i = 1:4)
                    byte = bitand(val, 255);
                    bytes = [bytes byte];
                    val = bitshift(val, -8);
                end
            end            
        end
    end
    
    
 %% Public static methods
    methods (Static)
        function obj = deserialize(aBytes, aMessageIdsEnabled)
        % DESERIALIZE Convert an array of bytes to a BinaryMessage instance.
        % message = Zaber.BinaryMessage.DESERIALIZE(bytes)
        % message = Zaber.BinaryMessage.DESERIALIZE(bytes, hasid)
        %
        % bytes   - An array of six bytes received from a device.
        % hasid   - Optional. Pass in true if the device is using
        %           message IDs. This will cause the ID to be separated
        %           from the data. 
        % message - The deserialized BinaryMessage instance.
        %
        % Given an array of 6 values in the range of 0 to 255, this
        % will construct a corresponding BinaryMessage class with the
        % properties filled in accordingly. Use this to convert reply
        % data from a device into a more convenient form.
        %
        % NOTE: It is not possible to tell from the data directly if
        % message ID mode is enabled on the device, so the caller must
        % pass in true for the optional ID enabled argument if that mode
        % is in use. In that case, the MessageId field will be filled in
        % and the data payload will be sign-extended from 24 to 32 bits.
        %
        % See also serialize
        
            if (length(aBytes) ~= 6)
                error('Zaber:BinaryMessage:deserialize:badPacketLength', ...
                      'Binary packets must have 6 bytes');
            end
            
            for (i = 1:6)
                if ((aBytes(i) < 0) || (aBytes(i) > 255))
                    error('Zaber:Binarymessage:deserialize:badDataType', ...
                          'Binary packet elements must be representable as bytes.');
                end
            end
                        
            deviceNumber = aBytes(1);
            command = aBytes(2);
            
            data = int32(0);
            if ((nargin > 1) && aMessageIdsEnabled())
                messageId = aBytes(6);
                for (i = 5:-1:3)
                    data = bitshift(data, 8) + aBytes(i);
                end
                
                data = bitshift(bitshift(data, 8), -8); % Sign extend
                
                obj = Zaber.BinaryMessage(deviceNumber, command, data, messageId);
                obj.MessageType = Zaber.MessageType.Response;
            else
                for (i = 6:-1:3)
                    data = bitshift(data, 8) + int32(aBytes(i));
                end
                
                obj = Zaber.BinaryMessage(deviceNumber, command, data);
                obj.MessageType = Zaber.MessageType.Response;
            end
        end        
    end
    
end

