classdef AsciiDevice < Zaber.Device    
%   ASCIIDEVICE Implements the Zaber.Device interface for the ASCII protocol.
%
%   device = Zaber.ASCIIDEVICE.initialize(protocol, address);
%   protocol - An instance of Zaber.AsciiProtocol.
%   address  - The numeric address of the device on a daisy chain. 
%              Legal values are 1-99.
%   device   - Output: An initialized instance of this class.
%
%   This class represents a single Zaber device on a possible daisy chain
%   of multiple devices. An instance of this class can be used to
%   communicate with the device, and its peripherals if it has any. The
%   generic methods and properties defined by the base class can be used
%   for interaction with basic features. More advanced usage requires
%   use of protocol-specific commands; the request method is useful for
%   that as it will automatically ensure your message is addressed to the
%   device represented by the class instance.
%
%   See also Zaber.Device, Zaber.Protocol.detect, Zaber.AsciiProtocol 

%   Author: Zaber Technologies Software Team <contact@zaber.com>
    

%% Public instance properties
    properties (SetAccess = protected)
        
        % FLAGS Last status flags returned by the device. Values of empty
        % or '--' indicate no warnings and can be ignored. It is best
        % practice to check the flags after completing a move command or
        % when determining the cause of an error. Meanings are documented
        % in the Zaber ASCII Protocol Manual:
        % http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual#Warning_Flags 
        Flags
    end
    
    
 %% Public instance methods
    methods        
        function reply = request(obj, aCommand, aData)
        % REQUEST Shortcut for transacting with a device.
        % reply = device.REQUEST(command, data);
        %
        % command - Command to send the device. This is always a
        %           string, but can be empty or have multiple words.
        % data    - Arguments for the command. Can be the empty array,
        %           a number, a string or an array of numbers or
        %           strings, depending on the command.
        % reply   - Response from the device as an AsciiMessage.
        %
        % This method is a shortcut for calling device.Protocol.request()
        % with the difference that this method will automatically attach
        % the device and axis numbers and will update the device's flags
        % from the response each time.
        %
        % This method requires knowledge of the Zaber ASCII protocol. Use
        % it when other methods do not provide the functionality you need.
        %
        % See also AsciiProtocol.request, AsciiMessage
            
            message = Zaber.AsciiMessage(...
                obj.DeviceNo, aCommand, aData, 'AxisNo', obj.AxisNo);
            
            reply = obj.Protocol.request(message);
            
            if (isa(reply, 'Zaber.AsciiMessage'))
                obj.Flags = reply.Flags;
            else
                error('Zaber:AsciiDevice:request:communicationError', ...
                      'Device %d failed to respond to request.', ...
                      obj.DeviceNo);
            end
        end
        
        
        function value = get(obj, aSetting)
        % GET Read a setting from the device.
        % value = device.GET(setting)
        %
        % setting - Name of the setting to read. See the 
        %           Zaber ASCII protocol manual for legal values:
        %           http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual#Device_Settings
        % value   - Current value of the setting. This can be a number, an
        %           array of numbers or a string.
        %
        % In the event of a communication error, an error will be thrown.
        % If the device returns an error result, a warning will occur and
        % the method will return the empty array.
        %
        % See also set
        
            value = [];
            reply = obj.request('get', aSetting);
            
            if (isa(reply, 'Zaber.AsciiMessage'))
                if (reply.IsError)
                    warning('Zaber:AsciiDevice:get:readError', ...
                            'Attempt to read setting %s from device %d resulted in error %s.', ...
                            aSetting, obj.DeviceNo, reply.DataString);
                else
                    if (length(reply.Data) > 0)
                        value = reply.Data;
                    else
                        value = reply.DataString;
                    end
                end
            end
        end
            
        
        function result = set(obj, aSetting, aValue)
        % SET Write a value to a device setting.
        % result = device.set(setting, value)
        %
        % setting - Numeric identifier for the setting to write. For legal
        %           values, see the Zaber ASCII protocol manual:
        %           http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual#Device_Settings
        % value   - New value of the setting, as a 32-bit integer or a string.
        %           Note that many settings expect integer values and will
        %           produce an error if sent a number with a decimal point.
        %           If passing in a number that is not expected to have a
        %           decimal point, it is recommended that you cast it to
        %           int32 first.
        % result  - True if the write succeeded, or the reply message if
        %           the device returned an error response.
        %
        % Errors will be thrown if there is a communication error. If the
        % setting does not exist, if the setting is read-only, or if the
        % value provided is out of range for the setting then a warning
        % will occur and the device's response message will be returned.
        %
        % See also get
        
            result = false;
            
            reply = obj.request(sprintf('set %s', aSetting), aValue);
            
            if (isa(reply, 'Zaber.AsciiMessage'))
                if (reply.IsError)
                    warning('Zaber:BinaryDevice:set:writeError', ...
                            'Attempt to read setting %s from device %d resulted in error %s.', ...
                            aSetting, obj.DeviceNo, reply.DataString);
                    result = reply.DataString;
                else
                    result = true;
                end
            end
        end
        
                
        function error = waitforidle(obj, aPingInterval)
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
        % See also home, stop, moveabsolute, moverelative,
        % moveatvelocity, moveindexed
            
            interval = 0.1;
            if (nargin > 1)
                interval = aPingInterval;
            end
            
            moving = true;
            if (~obj.IsAxis)
                moving = false;
            end
            
            while (moving)
                reply = obj.request('', []);
                if (~isa(reply, 'Zaber.AsciiMessage'))
                    moving = false;
                    error = reply;
                elseif (reply.IsError)
                    moving = false;
                    error = reply.Data;
                elseif (reply.IsIdle)
                    moving = false;
                else
                    pause(interval);
                end
            end
        end
        
        
        function range = getrange(obj)
        % GETRANGE Determine the movement limits of the device.
        % range = device.GETRANGE();
        %
        % range - A 1x2 matrix with the first entry being the lower bound
        %         on legal device position and the second entry being the
        %         upper bound. Empty array if the concept doesn't apply.
        %         For a multi-axis controller the result will be an Nx2
        %         array where N is the number of axes. For rotary devices
        %         the result is the range for one full rotation. Note
        %         that the range returned may not reflect physical limits
        %         if the device has been configured to use less than its
        %         full range of travel.
        %
        % Reads device settings to determine the device's current idea of
        % its range of movement. Returns the empty array if the concept
        % does not apply to the device type.
        %
        % See also getposition, getnumindices, Units
            
            devices = obj;
            if (~isempty(obj.Axes))
                devices = obj.Axes;
            elseif (~obj.IsAxis)
                range = [];
                return;
            end
            
            range = zeros(length(devices), 2);
            for (i = 1:length(devices))
                d = devices(i);
                
                if (d.FirmwareVersion >= 6.06)
                    range(i, 1) = d.get('limit.min');
                else
                    range(i, 1) = 0;
                end
                
                if (d.MotionType == Zaber.MotionType.Rotary)
                    if (d.FirmwareVersion >= 6.20)
                        rotationSize = d.get('limit.cycle.dist');
                    else
                        rotationSize = d.get('limit.max');
                    end
                    
                    circle = d.Units.positiontonative(360.0);
                    range(i, 2) = min(circle, rotationSize);
                else
                    range(i, 2) = d.get('limit.max');
                end
            end
        end

        
        function error = home(obj)
        % HOME Move the device to its home position.
        % error = device.HOME();
        %
        % error - Error message from the device, if the command fails. See
        %         the list of error codes in the Zaber Binary protocol
        %         manual:
        %         http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes 
        %
        % This command does not block. The device will likely be moving
        % after control returns to the caller. To wait for completion of
        % the move, use waitforidle().
        %
        % See also stop, waitforidle, moveabsolute, moverelative,
        % moveatvelocity, moveindexed
        
            error = [];
            
            reply = obj.request('home', []);
            
            if (isa(reply, 'Zaber.AsciiMessage') && reply.IsError)
                error = reply.DataString;
            end
        end

        
        function error = moveabsolute(obj, aPosition)
        % MOVEABSOLUTE Move the device to an absolute position.
        % error = device.moveabsolute(position);
        % 
        % position - Position to move to, in native device units. If this
        %            device has multiple axes, this must be an array of
        %            positions with the same number of entries as there are
        %            axes. To move an individual axis, use its device entry
        %            from the Axes property.
        % error    - Error message from the device, if the command fails.
        %
        % This command does not block. The device will likely be moving
        % after control returns to the caller. To wait for completion of
        % the move, use waitforidle().
        %
        % See also home, stop, waitforidle, getposition, moverelative,
        % moveatvelocity, moveindexed, Units
        
            error = obj.multiaxiscommand('move abs', int32(aPosition));
        end        
        
        
        function error = moverelative(obj, aDelta)
        % MOVERELATIVE Move the device by a relative amount.
        % error = device.MOVERELATIVE(delta);
        % 
        % delta    - Distance to move by, in native device units.
        % error    - Error information from the device, if any.
        %
        % This method returns immediately upon receiving acknowledgement
        % from the device. Movement will continue after that. Use
        % waitforidle() to block until the move finishes.
        %
        % See also home, stop, waitforidle, getposition, moveabsolute,
        % moveatvelocity, moveindexed, Units
        
            error = obj.multiaxiscommand('move rel', int32(aDelta));
        end
        
        
        function error = moveatvelocity(obj, aVelocity)
        % MOVEATVELOCITY Move the device at a specified velocity.
        % error = device.MOVEATVELOCITY(velocity);
        % 
        % velocity - Speed to move at, in native device units.
        % error    - Error information from the device, if any.
        %
        % This method returns immediately upon receiving acknowledgement
        % from the device. Movement will continue after that, until either
        % a limit is reached or a pre-empting command is send. Use
        % waitforidle() if you want to block until the end of the stage is
        % reached.
        %
        % See also home, stop, waitforidle, getposition, moveabsolute,
        % moverelative, moveindexed, Units

            error = obj.multiaxiscommand('move vel', int32(aVelocity));
        end
        
        
        function error = stop(obj)
        % STOP Stop the device if it is moving.
        % error = device.STOP();
        %
        % error    - Error information from the device(s), if any.
        %
        % If this device is a multi-axis controller, all axes will be
        % stopped. To stop an individual axis, retrieve it from the Axes
        % property and invoke its stop method instead.
        %
        % See also waitforidle, moveabsolute, moverelative, moveatvelocity,
        % moveindexed
        
            error = [];
            
            reply = obj.request('stop', []);

            if (isa(reply, 'Zaber.AsciiMessage') && reply.IsError)
                error = reply.DataString;
            end
        end
        
        
        function pos = getposition(obj)
        % GETPOSITION Get the current device position in native units.
        % pos = device.GETPOSITION();
        %
        % If there is a communication error or the device is not an axis,
        % the empty array will be returned.
        %
        % This method can be called while a device is moving, and will
        % return its position as of the time the message was received.
        %
        % See also stop, waitforidle, moveabsolute, moverelative,
        % moveatvelocity, moveindexed, getnumindices, Units
        
            pos = obj.get('pos');
        end
        
        
        function num = getnumindices(obj)
        % GETNUMINDICES Determine how many indexed positions the device has.
        % num = getvice.GETNUMINDICES();
        %
        % Return value is the maximum position that can be passed to
        % MOVEINDEXED. Returns zero on devices that do not support the
        % MOVEINDEXED command.
        %
        % This method is intended for use with devices such as the X-FWR
        % Filter Wheel holder.
        %
        % See also moveindexed, stop, waitforidle, getposition, range
            
            num = 0;
            
            reply = obj.request('get', 'limit.cycle.dist');

            maxDist = [];
            
            if (isa(reply, 'Zaber.AsciiMessage') && ~reply.IsError)
                maxDist = reply.Data;
            else
                reply = obj.request('get', 'limit.max.dist');

                if (isa(reply, 'Zaber.AsciiMessage') && ~reply.IsError)
                    maxDist = reply.Data;
                end
            end

            if (~isempty(maxDist))
                indexSize = obj.get('motion.index.dist');
                if (~isempty(indexSize))
                    num = int32(floor(maxDist / indexSize));
                end
            end
        end
        
        
        function error = moveindexed(obj, aIndex)
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
        % This method returns immediately after communicating with the
        % device. The hardware may continue moving for some time afterward;
        % use WAITFORIDLE to wait for the move to complete.
        %
        % See also getnumindices, getposition, stop, waitforidle,
        % moveabsolute, moverelative, moveatvelocity
            error = obj.multiaxiscommand('move index', aIndex);
        end
        
    end
    
    
 %% Public static methods
    methods (Static)
        function instance = initialize(aProtocol, aDeviceNumber, aDeviceId)
        % INITIALIZE Construct a representation for a single device.
        % device = Zaber.AsciiDevice.INITIALIZE(protocol, address, id)
        %
        % protocol - An AsciiProtocol instance.
        % address  - The daisy chain address of a device to represent.
        % id       - The numeric device type ID of the device.
        %            Optional; if not provided the device will be
        %            queried for it.
        % obj      - An initialized AsciiDevice instance.
        %
        % Given the daisy chain address and device type ID for a device
        % that has been found using the given protocol, queries the device
        % for its properties and constructs a new Zaber.Device subclass
        % instance to represent that device.
        %
        % See also AsciiDevice, BinaryDevice.initialize
            
            if (~isa(aProtocol, 'Zaber.AsciiProtocol'))
                error('Zaber:AsciiDevice:initialize:wrongProtocol', ...
                      'Protocol must be ASCII to use this method.');
            end
            
            if (nargin > 2)
                deviceId = aDeviceId;
            else
                reply = aProtocol.request(...
                    Zaber.AsciiMessage(aDeviceNumber, 'get', 'deviceid'));
                
                if (~isempty(reply) && ~reply.IsError)
                    deviceId = reply.Data;
                else
                    error('Zaber:AsciiDevice:initialize:idError', ...
                          'Failed to get the type ID for device %d.', ...
                          aDeviceNumber);
                end
            end
            
            instance = Zaber.AsciiDevice(aProtocol, aDeviceNumber, deviceId);
            
            % Get the firmware version.
            data = instance.get('version');
            if (isnumeric(data))
                instance.FirmwareVersion = data;
            end
            
            % Get database record for device.
            db = Zaber.DeviceDatabase.instance();
            deviceRecord = db.finddevice(instance.DeviceId);
            
            % Identify axes
            numAxes = instance.get('system.axiscount');
            hasPeripherals = false;
            if (numAxes > 0)
                hasPeripherals = true;
                peripheralIds = zeros(numAxes);
                
                for (iAxis = 1:numAxes)
                    reply = aProtocol.request(...
                        Zaber.AsciiMessage(aDeviceNumber, 'get', 'peripheralid', ...
                            'AxisNo', iAxis));
                        
                    if (~isempty(reply) && ~reply.IsError)
                        peripheralIds(iAxis) = reply.Data;
                    else
                        hasPeripherals = false;
                    end
                end
            end
            
            if (hasPeripherals)
                % Controller with peripherals
                instance.Name = db.getdevicename(deviceRecord);
                
                for (iAxis = 1:numAxes)
                    axis = Zaber.AsciiDevice(instance.Protocol, ...
                        instance.DeviceNo, instance.DeviceId);
                    
                    axis.AxisNo = iAxis;
                    axis.IsAxis = true;
                    axis.FirmwareVersion = instance.FirmwareVersion;
                    
                    % get axis peripheral ID
                    axis.PeripheralId = peripheralIds(iAxis);
                    
                    % Get database record for peripheral.
                    periRecord = db.findperipheral(deviceRecord, axis.PeripheralId);
                    
                    axis.Name = db.getdevicename(deviceRecord, periRecord);

                    % Get unit conversion properties from the database.
                    if (~isempty(periRecord))
                        [axis.MotionType, axis.Units] = ...
                            db.determinemotiontype(deviceRecord, periRecord);
                        
                        % Get resolution
                        axis.Units.Resolution = axis.get('resolution');
                    end
                    
                    instance.Axes = [instance.Axes, axis];
                end
                
            else
                % Integrated device or non-controller device.
                % Get resolution
                resolution = instance.get('resolution');
                if (~isempty(resolution))
                    instance.IsAxis = true;
                end

                % Get database record for peripheral.
                periRecord = db.findperipheral(deviceRecord, instance.PeripheralId);

                instance.Name = db.getdevicename(deviceRecord, periRecord);

                % Get unit conversion properties from the database.
                if (~isempty(periRecord))
                    [instance.MotionType, instance.Units] = ...
                        db.determinemotiontype(deviceRecord, periRecord);
                    
                    instance.Units.Resolution = resolution;
                end                
            end
            
            instance.IO = Zaber.AsciiIoPort.detect(instance);
            
        end
    end
    
    
 %% Protected instance methods
    methods (Access = protected)
        function obj = AsciiDevice(aProtocol, aDeviceNumber, aDeviceId)
        % ASCIIDEVICE Constructor. Initializes properties to their default values.
        %
        % Note there is no way for code other than a subclass to initialize
        % other device properties after constructing the object this way.
        % Application code should use Zaber.AsciiDevice.initialize instead.

            obj = obj@Zaber.Device(aProtocol, aDeviceNumber, aDeviceId);
        end
        
        
        function error = multiaxiscommand(obj, aCommand, aData)
        % Helper for the various move... methods.
        
            error = [];
            
            if (~isempty(obj.Axes))
                for (i = 1:length(obj.Axes))
                    error = obj.Axes(i).multiaxiscommand(aCommand, aData(i));
                    if (~isempty(error))
                        break;
                    end
                end
            else            
                reply = obj.request(aCommand, aData);

                if (isa(reply, 'Zaber.AsciiMessage') && reply.IsError)
                    error = reply.DataString;
                end
            end
        end
    end
end

