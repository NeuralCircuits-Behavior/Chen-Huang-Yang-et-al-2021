classdef (Abstract) Device < handle
%   DEVICE Base class for all Zaber devices.
%   This class defines the general-purpose interface for all Zaber
%   devices regardless of protocol or capability.
%
%   See also AsciiDevice, BinaryDevice, Protocol

%   Author: Zaber Technologies Software Team <contact@zaber.com>


%% Public instance properties
    properties (SetAccess=protected)
        % PROTOCOL The Protocol instance (and port) this device is on.
        %
        % See also Zaber.Protocol, Zaber.BinaryProtocol,
        % Zaber.AsciiProtocol
        Protocol
        
        % DEVICENO The device's address on the daisy chain.
        DeviceNo
        
        % AXISNO 1-based axis index if this device is a peripheral.
        AxisNo
        
        % DEVICEID Numerical identifier for the device controller type.
        DeviceId
        
        % PERIPHERALID Numerical identifier for the device peripheral type.
        PeripheralId
        
        % NAME Human-readable name for the device.
        Name
        
        % ISAXIS True if this device honors motion commands.
        IsAxis
        
        % AXES Array of peripheral devices attached, if any.
        Axes
        
        % FIRMWAREVERSION Device's firmware version.
        % The version number is represented as a floating point number
        % where the integer part is the major version and the remainder the
        % minor version. 0 means unknown.
        FirmwareVersion
        
        % MOTIONTYPE Type of motion produced by the device, if any.
        % Use this to determine whether the device is capable of movement,
        % and what units of measure are appropriate.
        %
        % See also Zaber.MotionType
        MotionType
        
        % UNITS Physical unit conversion factors for this device.
        % If empty, this device either doesn't support simple unit
        % conversions due to its motion type, or does not move.
        % See also MotionType, Zaber.DeviceUnits
        Units
        
        % IO I/O port interface if this device has I/O ports.
        % See also Zaber.IoPort
        IO
    end
    
    
 %% Public instance methods.
    methods (Abstract)
        
        % REQUEST Convenience method to transact with a device.
        % reply = device.REQUEST(command, data);
        %
        % command - Message to send to the device. This is a byte for the
        %           binary protocol or a string for the ASCII protocol.
        % data    - Arguments for the command. In the binary protocol this
        %           is a single integer. In the ASCII protocol this can be
        %           the empty array, a number, a string, or an array of
        %           numbers or strings.
        %           
        % reply   - Response from the device. Type is either BinaryMessage
        %           or AsciiMessage.
        %
        % This method ignores timeouts and will block until a message
        % is received.
        %
        % See also Zaber.AsciiDevice.request, Zaber.BinaryDevice.request
        reply = request(obj, aCommand, aData)
        

        % GET Read a setting from the device.
        % value = device.get(setting)
        %
        % setting - Identifier for the setting to read. For the Binary
        %           protocol this is a number and for the ASCII protocol
        %           it's a name string. See the relevant Zaber protocol
        %           manual for values.
        % value   - Current value of the setting. The type depends on the
        %           protocol and the setting, but is usually numeric.
        %
        % The behavior of this method is protocol-specific, but generally
        % it will read and return a setting from the device. In the event
        % of a communication error, an error will be thrown. If
        % communication succeeds but the device returns an error response,
        % a warning will be printed and the empty array returned.
        %
        % See also set
        value = get(obj, aSetting)
            
        
        % SET Write a value to a device setting.
        % result = device.set(setting, value)
        %
        % setting - Identifier for the setting to write. For the Binary
        %           protocol this is a number and for the ASCII protocol
        %           it's a name string. See the relevant Zaber protocol
        %           manual for values.
        % value   - New value of the setting. The type depends on the
        %           protocol and the setting, but is usually numeric.
        % result  - True if the write succeeded, or the reply message if
        %           the device returned an error response.
        %
        % The behavior of this method is protocol-specific, but generally
        % it will attempt to change the value of a seting on the device.
        % Errors will be thrown if there is a communication error. If the
        % setting does not exist, the setting is read-only, or if the
        % value provided is out of range for the setting (ie if the device
        % returns an error response) then a warning will be printed and
        % the device's response message will be returned.
        %
        % See also get
        result = set(obj, aSetting, aValue)
        
        
        % GETRANGE Determine the movement limits of the device.
        % range = device.GETRANGE();
        %
        % range - A 1x2 matrix with the first entry being the lower bound
        %         on legal device position and the second entry being the
        %         upper bound. Empty array of the concept doesn't apply.
        %         For a multi-axis controller the result will be an Nx2
        %         array where N is the number of axes. For rotary devices
        %         the range will be one full rotation. In all cases the
        %         device can be configured to have a restricted range of
        %         movement, and in that situation the user-configured range
        %         will be returned.
        %
        % Reads device settings to determine the device's current idea of
        % its range of movement. Returns the empty array if the concept
        % does not apply to the device type.
        %
        % See also getposition, getnumindices, moveabsolute
        range = getrange(obj)
        
        
        % WAITFORIDLE Block until the device stops moving.
        % error = device.WAITFORIDLE();
        % error = device.WAITFORIDLE(interval);
        %
        % interval - Optional; number of seconds to wait between checks
        %            of the device's state. Defaults to 0.1 seconds.
        % error    - Return value, normally empty. If the device
        %            entered an error state while this method was
        %            checking for idleness, this method will return the
        %            error message.
        %
        % This method will ping the device repeatedly until the device
        % either becomes idle or produces an error response.
        %
        % Note the behavior of this command is protocol-specific. See the
        % protocol-specific implementations for more details.
        %
        % See also stop, moveabsolute, moverelative, moveatvelocity,
        % moveindexed, home
        error = waitforidle(obj, aPingInterval)
        
        
        % HOME Move the device to its home position.
        % error = device.HOME();
        %
        % Note the behavior of this command is protocol-specific. See the
        % protocol-specific implementations for more details.
        %
        % See also getposition, stop, moveabsolute, moverelative,
        % moveatvelocity, moveindexed
        error = home(obj)
        
        
        % MOVEABSOLUTE Move the device to an absolute position.
        % error = device.moveabsolute(position);
        % 
        % position - Position to move to, in native device units.
        % error    - Error information from the device, if any.
        %
        % Note the behavior of this command is protocol-specific. See the
        % protocol-specific implementations for more details.
        %
        % See also home, stop, waitforidle, getposition, moverelative,
        % moveatvelocity, moveindexed, Units
        error = moveabsolute(obj, aPosition)
        
        
        % MOVERELATIVE Move the device by a relative amount.
        % error = device.MOVERELATIVE(delta);
        % 
        % delta    - Distance to move by, in native device units.
        % error    - Error information from the device, if any.
        %
        % Note the behavior of this command is protocol-specific. See the
        % protocol-specific implementations for more details.
        %
        % See also home, stop, waitforidle, getposition, moveabsolute,
        % moveatvelocity, moveindexed, Units
        error = moverelative(obj, aPosition)
        
        
        % MOVEATVELOCITY Move the device at a specified velocity.
        % error = device.MOVEATVELOCITY(velocity);
        % 
        % velocity - Speed to move at, in native device units.
        % error    - Error information from the device, if any.
        %
        % Note the behavior of this command is protocol-specific. See the
        % protocol-specific implementations for more details.
        %
        % See also home, stop, waitforidle, getposition, moverelative,
        % moveabsolute, moveindexed, Units
        error = moveatvelocity(obj, aVelocity)
        
        
        % STOP Stop the device if it is moving.
        % error = device.STOP();
        %
        % error    - Error information from the device, if any.
        %
        % See also waitforidle, getposition, stop, moveabsolute,
        % moverelative, moveatvelocity, moveindexed
        error = stop(obj)
        
        
        % GETPOSITION Get the current device position in native units.
        % pos = device.GETPOSITION();
        %
        % If there is a communication error or the device is not an axis,
        % the empty array will be returned.
        %
        % See also range, moveabsolute, moverelative, moveatvelocity,
        % moveindexed, Zaber.DeviceUnits, Units
        pos = getposition(obj)
        
        
        % GETNUMINDICES Determine how many indexed positions the device has.
        % num = getvice.GETNUMINDICES();
        %
        % Return value is the maximum position that can be passed to
        % moveindexed. Returns zero on devices that do not support the
        % moveindexed command.
        %
        % See also moveindexed, waitforidle, getposition, stop
        num = getnumindices(obj)
        
        
        % MOVEINDEXED Move to an indexed position.
        % error = device.MOVEINDEXED(index);
        %
        % index - The index of the position to move to. Minimum value is 1,
        %         and maximum value is the number returned by
        %         GETNUMINDICES. Will be rejected on devices that don't
        %         support indexed moves.
        % error - Protocol-specific error code if the command is rejected
        %         or generates an error. Empty on success.
        %
        % This command is intended for use with indexed-position devices
        % such as the Filter Wheel. Although the other movement commands
        % will often work with such devices, this method provides an easier
        % way to reach a useful position.
        %
        % Note the behavior of this command is protocol-specific. See the
        % protocol-specific implementations for more details.
        %
        % See also home, stop, waitforidle, getposition, moverelative,
        % moveatvelocity, moveabsolute, Units
        error = moveindexed(obj, aIndex)
    end

    
 %% Public static methods
    methods (Static)
        function instance = initialize(aProtocol, aDeviceNumber, aDeviceId)
        % INITIALIZE Construct a representation for a device.
        % device = Zaber.Device.INITIALIZE(protocol, address, id)
        %
        % protocol - Either an AsciiProtocol or a BinaryProtocol
        %            instance.
        % address  - The daisy chain address of the device to be
        %            identified.
        % id       - Optional type ID of the device. If not determined
        %            through code, you can look these IDs up on Zaber's
        %            website at: http://www.zaber.com/support/?tab=ID%20Mapping
        % instance - An initialized subclass of Device.
        % 
        % Given the daisy chain address and device type ID for a device
        % that has been found using the given protocol, queries the device
        % for its properties and constructs a new Zaber.Device subclass
        % instance to represent that device.
        %
        % This is the main dispatch point for identifying and
        % populating information about a single device. It will
        % automatically dispatch to the appropriate method for the
        % given protocol, and will return a Device subclass appropriate
        % to the protocol. This method is used by
        % Protocol.finddevices().
        %
        % Note depending on the protocol and baud rate, this method can
        % take a couple of seconds to query all of a device's
        % information.
        %
        % See also Protocol, AsciiDevice.initialize,
        % BinaryDevice.initialize
        
            if (isa(aProtocol, 'Zaber.BinaryProtocol'))
                if (nargin > 2)
                    instance = Zaber.BinaryDevice.initialize(aProtocol, aDeviceNumber, aDeviceId);
                else
                    instance = Zaber.BinaryDevice.initialize(aProtocol, aDeviceNumber);
                end
            elseif (isa(aProtocol, 'Zaber.AsciiProtocol'))
                if (nargin > 2)
                    instance = Zaber.AsciiDevice.initialize(aProtocol, aDeviceNumber, aDeviceId);
                else
                    instance = Zaber.AsciiDevice.initialize(aProtocol, aDeviceNumber);
                end
            else
                error('Zaber:Device:initialize:badProtocol', ...
                      'Protocol is not a known protocol type.');
            end
        end
    end
    
    
 %% Protected instance methods
    methods (Access = protected)
        function obj = Device(aProtocol, aDeviceNumber, aDeviceId)
            % DEVICE Initializes properties to their default values.
            % This constructor is meant to be called by subclass constructors
            % only.
            obj.Protocol = aProtocol;
            obj.DeviceNo = aDeviceNumber;
            obj.AxisNo = 0;
            obj.DeviceId = aDeviceId;
            obj.PeripheralId = 0;
            obj.IsAxis = false;
            obj.Axes = [];
            obj.FirmwareVersion = 0;
            obj.MotionType = Zaber.MotionType.None;
            obj.Units = [];
            obj.Name = 'Unitialized device class instance';
        end
    end
end

