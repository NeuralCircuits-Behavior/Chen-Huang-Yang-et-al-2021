classdef AsciiIoPort < Zaber.IoPort
%   ASCIIIOPORT Interface for the I/O ports on Zaber controllers.
%
%   This class implements the Zaber.IoPort interface for ASCII devices.
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
            
            reply = obj.Device.request('io get ai', aIndex);
            
            value = reply.Data;
        end
        
        
        function writeanalogoutput(obj, aIndex, aValue)
        % WRITEANALOGOUTPUT Set the value of an analog output
        % io.WRITEANALOGOUTPUT(index, value);
        %
        % index - 1-based index of the port to write to.
        % value - New voltage to output.
        %
        % Note no devices currently support analog outputs so calling this
        % method will cause an error.
        %
        % See also AnalogOutputCount, readanalogoutput, readanaloginput,
        % writedigitaloutput
            
            reply = obj.Device.request('io get ao', [aIndex, aValue]);
                
            if (reply.IsError)
                warning('Zaber:AsciiIoPort:writeanalogoutput:deviceError', ...
                        'Device rejected analog output command: %s', ...
                        reply.DataString);
            end
        end
        
        
        function value = readanalogoutput(obj, aIndex)
        % READANALOGOUTPUT Read back the value of an analog output.
        % value = io.READANALOGOUTPUT(index);
        %
        % index - The 1-based index of the analog output to read.
        % value - The voltage currently being output on the specified port.
        %
        % Note no devices currently support analog outputs so calling this
        % method will cause an error.
        %
        % See also AnalogOutputCount, writeanalogoutput, readanaloginput,
        % readdigitalinput
        
            if (nargin > 1) 
                reply = obj.Device.request('io get ao', aIndex);
            else
                reply = obj.Device.request('io get ao', []);
            end
            
            value = reply.Data;
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
                reply = obj.Device.request('io get di', aIndex);
            else
                reply = obj.Device.request('io get di', []);
            end
            
            bits = reply.Data;
            
        end
        
        
        function writedigitaloutput(obj, aStartIndex, aBits)
        % WRITEDIGITALOUTPUT Set the value of one or more digital output bits.
        % io.WRITEDIGITALOUTPUT(startIndex, bits);
        %
        % startIndex - 1-based index of the first bit to write.
        % bits       - Array of bit values to write. The first entry will
        %              be written to the output bit corresponding to
        %              startIndex, end next entry to the next higher
        %              numbered output bit, and so on. Higher-indexed bits
        %              will be discarded if their positions exceed the
        %              number of port bits available.
        %
        % Will issue a warning if the device returns an error.
        %
        % See also DigitalOutputCount, readdigitaloutput, readdigitalinput,
        % writeanalogoutput
            
            if (length(aBits) == 1)
                reply = obj.Device.request('io set do', [aStartIndex, aBits]);
            else
                bits = zeros(1,obj.DigitalOutputCount);
                
                for (i = 1:(length(aBits)) - (aStartIndex - 1))
                    bits(i + aStartIndex - 1) = aBits(i);
                end
                
                reply = obj.Device.request('io set do port', bits);
            end
            
            if (reply.IsError)
                warning('Zaber:AsciiIoPort:deviceError', ...
                        'Device rejected io set command with message %s.', ...
                        reply.DataString);
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
        % readdigitalinput, readanaloginput
            
            if (nargin > 1) 
                reply = obj.Device.request('io get do', aIndex);
            else
                reply = obj.Device.request('io get do', []);
            end
            
            bits = reply.Data;
            
        end
    end

    
%% Internal static methods
    methods (Static, Access = {?Zaber.AsciiDevice})
        function ports = detect(aDevice)
        % DETECT Identify the I/O ports present on the given controller.
        % io = Zaber.AsciiIoPort.detect(device);
        %
        % device - An instance of Zaber.AsciiDevice.
        % io     - An instance of Zaber.AsciiIoPort, if the device
        %          supports I/O, or empty otherwise.
        %
        % Note this method is called automatically during the device
        % detection process.
            
            ports = [];
            
            reply = aDevice.request('io info', []);
            
            if (isa(reply, 'Zaber.AsciiMessage') && ~reply.IsError)
                if ((length(reply.Data) == 4) && (sum(reply.Data) > 0))
                    ports = Zaber.AsciiIoPort(aDevice);
                    ports.AnalogOutputCount = reply.Data(1);
                    ports.AnalogInputCount = reply.Data(2);
                    ports.DigitalOutputCount = reply.Data(3);
                    ports.DigitalInputCount = reply.Data(4);
                end
            end
        end
    end
    
    
 %% Protected instance methods
    methods (Access = protected)
        function obj = AsciiIoPort(aDevice)
            % ASCIIIOPORT Initializes properties to their default values.
            obj = obj@Zaber.IoPort(aDevice);
        end
    end
    
end

