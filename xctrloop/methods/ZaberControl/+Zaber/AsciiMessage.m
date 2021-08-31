classdef AsciiMessage < handle
%   ASCIIMESSAGE Helper class for Zaber ASCII protocol messages.
%   This class helps serialize and deserialize string messages 
%   used by the Zaber ASCII protocol into their constituent parts.
%
%   See also AsciiProtocol, Device, AsciiDevice
    
%   Author: Zaber Technologies Software Team <contact@zaber.com>

%% Public instance properties
    properties
        % DEVICENO The address of a device on a serial daisy chain.
        % For commands this will be the device the command is addressed
        % to, in the range of 1-99, or 0 to address all devices.
        % In replies this will be the address of the device responding.
        DeviceNo
        
        % AXISNO The index of the peripheral addressed, if relevant.
        % If the device addressed by DeviceNo has multiple peripherals
        % and a message is addressed to or from the peripheral, this
        % property stores the 1-based index of the peripheral. Zero is
        % treated as addressing the parent controller.
        AxisNo
        
        % COMMAND The main key word or phrase of the command, without data.
        % For example, 'move abs'.
        %
        % See also Data
        Command
        
        % MESSAGEID Optional message ID for correlating messages.
        % If message ID mode is enabled on a device, this value will
        % be echoed back by the device in its replies. Use a negative value
        % to disable sending a message ID (default).
        MessageId
        
        % DATA Numeric data payload for commands and replies.
        % An array of 32-bit signed integers. This will contain any integer
        % values successfully parsed from the payload section of the
        % message. Note that some messages have numbers interspersed with
        % non-numeric values; see the DataString property to retrieve
        % those.
        %
        % See also DataString
        Data
        
        % DATASTRING Payload component of a message.
        % This includes all the data associated with a command or response,
        % without the device address components, device ID, flags or message
        % checksum.
        %
        % See also Data
        DataString
        
        % FLAGS Device warning flags. 
        % Only applicable to device replies - indicates error or warning
        % conditions in the device. See
        % http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual#Warning_Flags
        % for a list of their meanings.
        Flags
        
        % ISERROR True if this message represents a device error state.
        IsError
        
        % ISIDLE True if the device was idle when the message was sent.
        IsIdle
        
        % MESSAGETYPE Identifies whether this message is a request (a
        % command for a device), a response (a reply from the device), an
        % informational message or an alert.
        %
        % See also Zaber.MessageType
        MessageType
    end
    
 %% Public instance methods
    methods
        function obj = AsciiMessage(aDeviceNo, aCommand, aData, varargin)
        % ASCIIMESSAGE Construct an AsciiMessage object from values.
        % message = Zaber.ASCIIMESSAGE(address, command, data)
        % message = Zaber.ASCIIMESSAGE(address, command, data,
        %               'MessageId' = id, 'AxisNo' = index)
        %
        % address     - The numeric address of a device, or 0 for all.
        % command     - The command to send to the device.
        % data        - Arguments to the command. Can be an array of
        %               numbers if the command only has numeric
        %               arguments, or a string otherwise. Use an empty
        %               array if there are no arguments.
        % 'MessageId' - Optional message ID. If included, the device
        %               will include the same message ID in its
        %               response. 
        % 'AxisNo'    - Optional axis number for peripheral-specific
        %               commands and responses. Defaults to 0.
        % message     - Return value: An initialized instance of the
        %               AsciiMessage class.
        %
        % This function constructs an instance of the AsciiMessage
        % class with its properties initialized.
        %
        % Note construction and serialization from the MATLAB end are
        % intended only for sending requests. Only the deserialize
        % method can create instances that represent responses, alerts
        % or info messages.
            
            obj.DeviceNo = 0;
            obj.AxisNo = 0;
            obj.Command = '';
            obj.MessageId = -1;
            obj.Data = [];
            obj.DataString = '';
            obj.Flags = '';
            obj.IsError = false;
            obj.IsIdle = true;
            obj.MessageType = Zaber.MessageType.Request;
            
            p = inputParser;
            addParameter(p, 'MessageId', -1); 
            addParameter(p, 'AxisNo', 0); 
            parse(p, varargin{:});
            obj.MessageId = p.Results.MessageId;
            obj.AxisNo = p.Results.AxisNo;
            
            if ((aDeviceNo < 0) || (aDeviceNo > 99))
                error('Zaber:AsciiMessage:badAddress', ...
                      'Zaber device addresses must range from 0 to 99.');
            end
            
            obj.DeviceNo = uint8(aDeviceNo);

            if (isnumeric(aData) && ~isempty(aData))
                obj.Data = aData;
                if (length(aData) > 1)
                    obj.DataString = [sprintf('%d ',aData(1:end-1)), num2str(aData(end))];
                else
                    obj.DataString = num2str(aData(end));
                end
                
            elseif (isa(aData, 'char'))
                sz = size(aData);
                if (sz(1) < 2)
                    obj.DataString = aData;
                else
                    s = aData(1,:);
                    for (i = 2:sz(1))
                        s = sprintf('%s %s', s, aData(i,:));
                    end
                    
                    obj.DataString = s;
                end
                
                parts = Zaber.AsciiMessage.splitstrings(obj.DataString);
                for (i = 1:length(parts))
                    num = str2double(parts{i});
                    if (isnumeric(num))
                        obj.Data = [obj.Data num];
                    end
                end
            end
            
            if (~isa(aCommand, 'char'))
                error('Zaber:AsciiMessage:missingCommand', ...
                      'Zaber ASCII commands require a command string.');
            end
            
            obj.Command = aCommand;
        end
        
        
        function byteArray = serialize(obj, aUseChecksum)
        % SERIALIZE Convert to an array of bytes suitable for transmission.
        % byteArray = message.SERIALIZE()
        % byteArray = message.SERIALIZE(useChecksum)
        %
        % useChecksum - Optional. Set to true to include a checksum in
        %               the serialized message. The receiving device
        %               will verify the checksum before honoring the
        %               command.
        % byteArray   - Return value. An array of bytes to send.
        %
        % Returns an array of bytes ready to be transmitted to a
        % Zaber device using the ASCII protocol.
        %
        % See also deserialize
            
            paddedCmd = obj.Command;
            if (~isempty(paddedCmd))
                paddedCmd = sprintf(' %s', paddedCmd);
            end
            
            if (isnumeric(obj.MessageId) && (obj.MessageId >= 0))
                s = sprintf('%d %d %d%s', ...
                    obj.DeviceNo, obj.AxisNo, obj.MessageId, ...
                    paddedCmd);
            else
                s = sprintf('%d %d%s', ...
                    obj.DeviceNo, obj.AxisNo, ...
                    paddedCmd);
            end
            
            if (~isempty(obj.DataString))
                s = sprintf('%s %s', s, obj.DataString);
            end
            
            if ((nargin > 1) && aUseChecksum)
                checksum = int32(0);
                temp = unicode2native(s, 'US-ASCII');
                for (i = 1:length(temp))
                    checksum = checksum + int32(temp(i));
                end
                checksum = bitand(checksum, 255);
                checksum = bitxor(checksum, 255) + 1;
                checksum = bitand(checksum, 255);
                s = sprintf('%s:%02X', s, checksum);
            end
            
            s = sprintf('/%s\r\n', s);
            
            byteArray = unicode2native(s, 'US-ASCII');
        end
    end
    

%% Public static methods
    methods (Static)
        function obj = deserialize(aBytes)
        % DESERIALIZE Convert an array of bytes or a string to an AsciiMessage.
        % message = Zaber.AsciiMessage.DESERIALIZE(line)
        %
        % line    - A string or array of bytes containing a line of ASCII
        %           text. Leading and trailing whitespace will be removed
        %           automatically.
        % message - Return value. An AsciiMessage object parsed from
        %           the input line.
        %
        % Given a string or an array of bytes representing an ASCII string,
        % this method will construct a corresponding AsciiMessage class
        % with the properties filled in accordingly. Use this to convert
        % reply data from a device into a more convenient form.
        %
        % Message IDs and checksums are automatically detected and
        % checksums verified.
        %
        % If the message is not properly formatted, an error will be
        % thrown.
        %
        % See also serialize
        
            obj = Zaber.AsciiMessage(0, ' ', '');
            obj.Command = '';
            
            s = aBytes;
            if (isnumeric(s))
                sz = size(s);
                if ((sz(1) == 1) && (sz(2) >= 1))
                    s = native2unicode(s);
                end
            end
            
            if (~isa(s, 'char'))
                error('Zaber:AsciiMessage:deserialize:badType', ...
                      'AsciiMessage.deserialize() expects a string or byte array.');
            end
            
            originalString = s;
            s = strtrim(s);
            
            % Consume the message type identifier.
            obj.MessageType = Zaber.MessageType.Invalid;
            switch(s(1))
                case '!'
                    obj.MessageType = Zaber.MessageType.Alert;
                case '#'
                    obj.MessageType = Zaber.MessageType.Info;
                case '@'
                    obj.MessageType = Zaber.MessageType.Response;
                case '/'
                    obj.MessageType = Zaber.MessageType.Request;
                otherwise
                    error('Zaber:AsciiMessage:deserialize:parseFailure', ...
                          'Unrecognized message type: %s', originalString);
            end
            
            s = s(2:end);
            
            % Check checksum if present
            i = strfind(s, ':');
            if (length(i) > 1)
                error('Zaber:AsciiMessage:deserialize:multipleChecksums', ...
                      'Message contains multiple checksum markers: %s', ...
                      originalString);
            elseif (length(i) == 1)
                if (i(1) ~= (length(s) - 2))
                    error('Zaber:AsciiMessage:deserialize:malformedChecksum', ...
                          'Malformed checksum in message: %s', originalString);
                end
                
                checksum = hex2dec(s(i(1) + 1 : end));
                s = s(1:i - 1);
                
                verif = int32(0);
                checkBytes = unicode2native(s, 'US-ASCII');
                for (i = 1:length(checkBytes))
                    verif = verif + int32(checkBytes(i));
                end
                
                verif = bitand(verif, 255);
                verif = bitxor(verif, 255) + 1;
                verif = bitand(verif, 255);
                if (verif ~= checksum)
                    error('Zaber:AsciiMessage:deserialize:badChecksum', ...
                          'Message checksum is incorrect (expected %02X): %s\r\n', ...
                          verif, originalString);
                end
            end
            
            % Extract address and message ID (if present)
            tokens = Zaber.AsciiMessage.splitstrings(s);
            if (length(tokens) > 1)
                obj.DeviceNo = str2double(tokens{1});
                tokens = tokens(2:end);
            end
            
            if (~isnumeric(obj.DeviceNo) || (length(obj.DeviceNo) ~= 1) ...
                 || isnan(obj.DeviceNo) || (obj.DeviceNo < 1) || (obj.DeviceNo > 99))
                error('Zaber:AsciiMessage:deserialize:invalidDeviceNo', ...
                      'Invalid device number in message: %s', originalString);
            end
            
            if (length(tokens) > 1)
                obj.AxisNo = str2double(tokens{1});
                tokens = tokens(2:end);
            end
            
            if (~isnumeric(obj.AxisNo) || (length(obj.AxisNo) ~= 1) || isnan(obj.AxisNo))
                error('Zaber:AsciiMessage:deserialize:invalidAxisNo', ...
                      'Invalid axis number in message: %s', originalString);
            end
            
            if (length(tokens) > 1)
                possibleId = str2double(tokens{1});
                if (isnumeric(possibleId) && (length(possibleId) == 1) && ~isnan(possibleId))
                    obj.MessageId = possibleId;
                    tokens = tokens(2:end);
                end
            end
                
            switch (obj.MessageType)
                case Zaber.MessageType.Response
                    if (length(tokens) < 4)
                        error('Zaber:AsciiMessage:deserialize:messageTruncated', ...
                              'Not enough content in response: %s', originalString);
                    end

                    obj.IsError = ~strcmp(tokens{1}, 'OK');
                    obj.IsIdle = strcmp(tokens{2}, 'IDLE');
                    obj.Flags = tokens{3};
                    tokens = tokens(4:end);
                    obj.DataString = Zaber.AsciiMessage.joinstrings(tokens, ' ');
                    obj.Data = Zaber.AsciiMessage.findnumbers(tokens);
                    
                case Zaber.MessageType.Alert
                    if (length(tokens) >= 2)
                        obj.IsIdle = strcmp(tokens{1}, 'IDLE');
                        obj.Flags = tokens{2};
                        tokens = tokens(3:end);
                    end

                    obj.DataString = Zaber.AsciiMessage.joinstrings(tokens, ' ');
                    obj.Data = Zaber.AsciiMessage.findnumbers(tokens);

                case Zaber.MessageType.Request
                    if (length(tokens) >= 1)
                        obj.Command = tokens{1};
                        obj.DataString = Zaber.AsciiMessage.joinstrings(tokens(2:end), ' ');
                        obj.Data = Zaber.AsciiMessage.findnumbers(tokens(2:end));
                    end
                    
                case Zaber.MessageType.Info
                    obj.DataString = Zaber.AsciiMessage.joinstrings(tokens, ' ');
                    obj.Data = Zaber.AsciiMessage.findnumbers(tokens);
                    
                otherwise
                    error('Zaber:AsciiMessage:deserialize:invalidType', ...
                          'Invalid message type detected.');
            end
            
            obj.DataString = Zaber.AsciiMessage.defaultstring(obj.DataString, '');
        end
    end
    
    
%% Private static methods
    methods (Static, Access = private)

        function numArray = findnumbers(aStringArray)
        % Extracts all numeric values from an array of strings.
            nums = str2double(aStringArray);
            mask = arrayfun(...
                @(x) isnumeric(x) && ~isnan(x) && (length(x) == 1), nums);
            numArray = nums(mask)';
        end
        
        function result = joinstrings(aStringArray, aDelimiter)
        % Version-safe method to join an array of strings into one,
        % with a space delimiter between.
            persistent JoinFunc;
            if isempty(JoinFunc)
                if (verLessThan('matlab', '9.1'))
                    JoinFunc = @strjoin;
                else
                    % join is recommended for R2016b and later.
                    JoinFunc = @join;
                end
            end
            
            if (isempty(aStringArray))
                result = '';
            else
                result = JoinFunc(aStringArray, aDelimiter);
            end
        end
        
        function result = splitstrings(aString)
        % Version-safe function to split a string into a string array
        % by whitespace.
            persistent SplitFunc;
            if isempty(SplitFunc)
                if (verLessThan('matlab', '9.1'))
                    % split doesn't work on strings before R2016b, and
                    % strsplit returns a column vector instead of a row.
                    SplitFunc = @(s) strsplit(s)';
                else
                    % split is recommended for R2016b and later.
                    SplitFunc = @split;
                end
            end
            
            result = SplitFunc(aString);
        end
        
        function result = defaultstring(aString, aDefault)
        % Version-safe function to replace a missing string with
        % a default, in order to ensure a string is always present.
            persistent FixStringFunc;
            if isempty(FixStringFunc)
                if (verLessThan('matlab', '9.1'))
                    % split doesn't work on strings before R2016b, and
                    % strsplit returns a column vector instead of a row.
                    FixStringFunc = @Zaber.AsciiMessage.defaultstringold;
                else
                    % split is recommended for R2016b and later.
                    FixStringFunc = @Zaber.AsciiMessage.defaultstringnew;
                end
            end
            
            % Unbox the string so the type checks will work.
            if isa(aString, 'cell')
                aString = aString{:};
            end
            
            result = FixStringFunc(aString, aDefault);
        end
        
        function result = defaultstringold(aString, aDefault)
            % ismissing doesn't exist in older matlab versions.
            if (isempty(aString) || (~isa(aString, 'string') && ~isa(aString, 'char')))
                result = aDefault;
            else
                result = aString;
            end
        end
        
        function result = defaultstringnew(aString, aDefault)
            if (ismissing(aString))
                result = aDefault;
            else
                result = aString;
            end
        end
    end
end


