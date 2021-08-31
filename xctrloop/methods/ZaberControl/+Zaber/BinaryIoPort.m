classdef BinaryIoPort < Zaber.IoPort
%   BINARYIOPORT Interface for the I/O ports on Zaber controllers.
%
%   This class implements the Zaber.IoPort interface for binary devices.
%   Instances are automatically created and assigned to the Device.IO
%   property during the device detection process.
%
%   See also Zaber.IoPort, Zaber.Device, Zaber.Device.IO

%   Author: Zaber Technologies Software Team <contact@zaber.com>
    
%% Public instance methods    
    methods
        
        function value = readanaloginput(obj, aIndex)
        % READANALOGINPUT Read the value of an analog input.
        % value = io.READANALOGINPUT(index);
        %
        % index - The 1-based index of the analog input to read.
        % value - The voltage read on the specified input.
        %
        % Will throw an error if the index is out of range or there is a
        % communication error.
        %
        % See also AnalogInputCount, writeanalogoutput, readanalogoutput,
        % readdigitalinput
            
            reply = obj.Device.request(...
                Zaber.BinaryCommandType.Read_Analog_Input, aIndex);
            
            if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError)
                value = 0.0001 * double(reply.Data);
            else
                error('Zaber:BinaryIoPort:readanaloginput:deviceError', ...
                      'Device %d returned an error when attempting to read analog input %d.', ...
                      obj.Device.DeviceNo, aIndex);
            end
        end
        
        
        function writeanalogoutput(~, ~, ~)
        % WRITEANALOGOUTPUT Set the value of an analog output
        % io.WRITEANALOGOUTPUT(index, value);
        %
        % index - 1-based index of the port to write to.
        % value - New voltage to output.
        %
        % Note The Zaber Binary protocol currently has no support for
        % analog outputs, so this method will always throw an error.
        %
        % See also AnalogOutputCount, readanalogoutput, readanaloginput,
        % writedigitaloutput
            
            error('Zaber:BinaryIoPort:writeanalogoutput:notSupported', ...
                  'Analog outputs are currently not supported.');
        end
        
        
        function value = readanalogoutput(~, ~)
        % READANALOGOUTPUT Read back the value of an analog output.
        % value = io.READANALOGOUTPUT(index);
        %
        % index - The 1-based index of the analog output to read.
        % value - The voltage currently being output on the specified port.
        %
        % Will throw an error if the index is out of range or there is a
        % communication error.
        %
        % Note The Zaber Binary protocol currently has no support for
        % analog outputs, so this method will always throw an error.
        %
        % See also AnalogOutputCount, writeanalogoutput, readanaloginput,
        % readdigitaloutput
            
            error('Zaber:BinaryIoPort:readanalogoutput:notSupported', ...
                  'Analog outputs are currently not supported.');
        end
        
        
        function bits = readdigitalinput(obj, aIndex)
        % READDIGITALINPUT Read one or more digital input bits.
        % bits = io.READDIGITALINPUT();
        % bit = io.READDIGITALINPUT(index);
        %
        % index - Optional 1-based index of the bit to read. If not given,
        %         the output will be an array of bits starting with the
        %         lowest-numbered input bit. If specified, the output will
        %         be a single bit value.
        %
        % See also DigitalInputCount, writedigitaloutput,
        % readdigitaloutput, readanaloginput
           
            if (nargin > 1)
                reply = obj.Device.request(...
                    Zaber.BinaryCommandType.Read_Digital_Input, aIndex);
                
                if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError)
                    bits = reply.Data;
                end
            else
                reply = obj.Device.request(...
                    Zaber.BinaryCommandType.Read_All_Digital_Inputs, 0);
                
                if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError)
                    bits = zeros(1, obj.DigitalInputCount);
                    data = reply.Data;
                    for (i = 1:obj.DigitalInputCount)                        
                        bits(i) = bitand(data, 1);
                        data = bitshift(data, -1);
                    end
                end
            end
            
            if (~isa(reply, 'Zaber.BinaryMessage') || reply.IsError)
                error('Zaber:BinaryIoPort:readdigitalinput:deviceError', ...
                      'There was an error when reading digital inputs from device %d.', ...
                      obj.Device.DeviceNo);
            end
            
        end
        
        
        function writedigitaloutput(obj, aStartIndex, aBits)
        % WRITEDIGITALOUTPUT Set the value of one or more digital output bits.
        % io.WRITEDIGITALOUTPUT(startIndex, bits);
        %
        % startIndex - 1-based index of the first bit to write.
        % bits       - Array of bit values to write. The first entry will
        %              be written to the output bit corresponding to
        %              startIndex, end next entry to the next higher
        %              numbered output bit, and so on.
        %
        % Will issue a warning if the device returns an error.
        %
        % See also DigitalOutputCount, readdigitaloutput, readdigitalinput,
        % writeanalogoutput
            
            reply = [];
            
            if ((length(aBits) == obj.DigitalOutputCount) && (aStartIndex == 1))
                % Set all bits at once.
                data = 0;
                for (i = 1:obj.DigitalOutputCount)
                    data = bitor(data, bitshift(aBits(i), i - 1));
                end
                
                reply = obj.Device.request(...
                    Zaber.BinaryCommandType.Write_All_Digital_Outputs, data);
                
            else % One at a time.
                for (i = 1:length(aBits))
                    portIndex = i + aStartIndex - 1;
                    if (portIndex <= obj.DigitalOutputCount)
                        data = bitor(2 * portIndex, aBits(i));
                        reply = obj.Device.request(...
                            Zaber.BinaryCommandType.Write_Digital_Output, data);

                        if (reply.IsError)
                            break;
                        end
                    end
                end
            end
            
            if (~isempty(reply) && reply.IsError)
                warning('Zaber:BinaryIoPort:writedigitaloutput:deviceError', ...
                        'There was an error writing digital outputs on device %d.', ...
                        obj.Device.DeviceNo);
            end
        end
        
        
        function bits = readdigitaloutput(obj, aIndex)
        % READDIGITALOUTPUT Read back one or more digital output bits.
        % bits = io.READDIGITALOUTPUT();
        % bit = io.READDIGITALOUTPUT(index);
        %
        % index - Optional 1-based index of the bit to read. If not given,
        %         the output will be an array of bits starting with the
        %         lowest-numbered output port bit. If specified, the output 
        %         will be a single bit value.
        %
        % See also DigitalOutputCount, writedigitaloutput,
        % readdigitalinput, writeanalogoutput
            
            if (nargin > 1)
                reply = obj.Device.request(...
                    Zaber.BinaryCommandType.Read_Digital_Output, aIndex);
                
                if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError)
                    bits = reply.Data;
                end
            else
                reply = obj.Device.request(...
                    Zaber.BinaryCommandType.Read_All_Digital_Outputs, 0);
                
                if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError)
                    bits = zeros(1,obj.DigitalOutputCount);
                    data = reply.Data;
                    for (i = 1:obj.DigitalOutputCount)                        
                        bits(i) = bitand(data, 1);
                        data = bitshift(data, -1);
                    end
                end
            end
            
            if (~isa(reply, 'Zaber.BinaryMessage') || reply.IsError)
                error('Zaber:BinaryIoPort:readdigitalinput:deviceError', ...
                      'There was an error when reading digital outputs from device %d.', ...
                      obj.Device.DeviceNo);
            end
            
        end
    end

 
 %% Internal static methods
    methods (Static, Access = { ?Zaber.BinaryDevice })
        function ports = detect(aDevice)
        % DETECT Identify the I/O ports present on the given controller.
        % io = Zaber.BinaryIoPort.detect(device);
        %
        % device - An instance of Zaber.BinaryDevice.
        % io     - An instance of Zaber.BinaryIoPort, if the device
        %          supports I/O, or empty otherwise.
            
            ports = [];
            
            temp = Zaber.BinaryIoPort(aDevice);
            found = false;
            
            reply = aDevice.request(...
                Zaber.BinaryCommandType.Return_Analog_Output_Count, 0);
            
            if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError && (reply.Data > 0))
                found = true;
                temp.AnalogOutputCount = reply.Data;
            end
            
            reply = aDevice.request(...
                Zaber.BinaryCommandType.Return_Analog_Input_Count, 0);
            
            if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError && (reply.Data > 0))
                found = true;
                temp.AnalogInputCount = reply.Data;
            end

            reply = aDevice.request(...
                Zaber.BinaryCommandType.Return_Digital_Output_Count, 0);
            
            if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError && (reply.Data > 0))
                found = true;
                temp.DigitalOutputCount = reply.Data;
            end

            reply = aDevice.request(...
                Zaber.BinaryCommandType.Return_Digital_Input_Count, 0);
            
            if (isa(reply, 'Zaber.BinaryMessage') && ~reply.IsError && (reply.Data > 0))
                found = true;
                temp.DigitalInputCount = reply.Data;
            end
            
            if (found)
                ports = temp;
            end
        end
    end
    
    
 %% Protected instance methods
    methods (Access = protected)
        function obj = BinaryIoPort(aDevice)
            % BINARYIOPORT Initializes properties to their default values.
            obj = obj@Zaber.IoPort(aDevice);
        end
    end
    
end

