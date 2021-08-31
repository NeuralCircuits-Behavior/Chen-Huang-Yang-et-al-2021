classdef (Abstract) IoPort < handle
%   IOPORT Interface for the I/O ports on Zaber controllers.
%   This class defines the general-purpose interface for the
%   analog and digital I/O ports found on some Zaber devices.
%
%   See also Zaber.Device.IO

%   Author: Zaber Technologies Software Team <contact@zaber.com>

    
%% Public instance properties
    properties (SetAccess = protected)
        
        % ANALOGINPUTCOUNT The number of analog inputs available.
        AnalogInputCount
        
        % ANALOGOUTPUTCOUNT The number of analog outputs available.
        AnalogOutputCount
        
        % DIGITALINPUTCOUNT The number of digital input bits available.
        DigitalInputCount
        
        % DIGITALOUTPUTCOUNT The number of digital output bits available.
        DigitalOutputCount
    end
    
    
 %% Protected instance properties
    properties (Access = protected)
        % DEVICE The device this set of ports is associated with.
        Device
    end
    
    
 %% Public instance methods
    methods (Abstract)
        
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
        value = readanaloginput(obj, aIndex)
        
        
        % WRITEANALOGOUTPUT Set the value of an analog output
        % io.WRITEANALOGOUTPUT(index, value);
        %
        % index - 1-based index of the port to write to.
        % value - New voltage to output.
        %
        % NOTE no devices currently support analog outputs. This method
        % will always throw an error.
        %
        % See also AnalogOutputCount, readanalogoutput, readanaloginput,
        % writedigitaloutput
        writeanalogoutput(obj, aIndex, aValue)
        
        
        % READANALOGOUTPUT Read back the value of an analog output.
        % value = io.READANALOGOUTPUT(index);
        %
        % index - The 1-based index of the analog output to read.
        % value - The voltage currently being output on the specified port.
        %
        % NOTE no devices currently support analog outputs. This method
        % will always throw an error.
        %
        % See also AnalogOutputCount, writeanalogoutput, readanaloginput,
        % readdigitalinput 
        value = readanalogoutput(obj, aIndex)
        
        
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
        bits = readdigitalinput(obj, aIndex)
        
        
        % WRITEDIGITALOUTPUT Set the value of one or more digital output bits.
        % io.WRITEDIGITALOUTPUT(startIndex, bits);
        %
        % startIndex - 1-based index of the first bit to write.
        % bits       - Array of bit values to write. The first entry will
        %              be written to the output bit corresponding to
        %              startIndex, end next entry to the next higher
        %              numbered output bit, and so on.
        %
        % See also DigitalOutputCount, readdigitaloutput, readdigitalinput,
        % writeanalogoutput
        writedigitaloutput(obj, aStartIndex, aBits)
        
        
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
        bits = readdigitaloutput(obj, aIndex)
    end
    
    
 %% Protetcted instance methods
    methods (Access = protected)
        function obj = IoPort(aDevice)
            % IOPORT Initializes properties to their default values.
            % This constructor is meant to be called by subclass constructors
            % only.
            obj.Device = aDevice;
            obj.AnalogInputCount = 0;
            obj.AnalogOutputCount = 0;
            obj.DigitalInputCount = 0;
            obj.DigitalOutputCount = 0;
        end
    end
    
end

