classdef BinaryDevice < Zaber.Device
%   BINARYDEVICE Implements the Zaber.Device interface for the Binary protocol.
%
%   device = Zaber.BINARYDEVICE.initialize(protocol, address);
%   protocol - An instance of Zaber.BinaryProtocol.
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
%   See also Zaber.Device, Zaber.Protocol.detect, Zaber.BinaryProtocol 

%   Author: Zaber Technologies Software Team <contact@zaber.com>
    
    
%% Public instance properties
    properties (SetAccess = protected)
        % MESSAGEIDSENABLED Set to true if the device is using message IDs.
        MessageIdsEnabled
    end
    
    
%% Public instance methods
    methods
        function reply = request(obj, aCommand, aData)
        % REQUEST Convenience method to transact with a device.
        % reply = device.REQUEST(command, data);
        %
        % command - Command to send the device. This is a byte.
        % data    - Integer argument for the command.
        % reply   - Response from the device, as a BinaryMessage. 
        %           Note that if there are overlapping requests this
        %           will actually be the next response received on the
        %           port, which could potentially be from another
        %           device or another command.
        %
        % This method ignores timeouts and will block until a message
        % is received.
        %
        % See also Zaber.BinaryProtocol.request, Zaber.BinaryProtocol.send,
        % Zaber.BinaryProtocol.receive, Zaber.BinaryErrorType
            
            message = Zaber.BinaryMessage(obj.DeviceNo, aCommand, aData);
            
            obj.Protocol.send(message);
            while (~obj.Protocol.canreceive())
                pause(0.01);
            end
            
            reply = obj.Protocol.receive(obj.MessageIdsEnabled);
        end
        
        
        function value = get(obj, aSetting)
        % GET Read a setting from the device.
        % value = device.get(setting)
        %
        % setting - Numeric identifier for the setting to read. See the 
        %           Zaber Binary protocol manual for legal values:
        %           http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Return_Setting_-_Cmd_53
        %           or use the Zaber.BinaryCommandType enumeration.
        % value   - Current value of the setting, as a 32-bit integer. 
        %
        % In the event of a communication error, an error will be thrown.
        % If the device returns an error result, a warning will occur and
        % the method will return the empty array.
        %
        % See also set, Zaber.BinaryCommandType, Zaber.BinaryErrorType
        
            value = [];
            reply = obj.request(Zaber.BinaryCommandType.Return_Setting, aSetting);
            
            if (~isa(reply, 'Zaber.BinaryMessage'))
                error('Zaber:BinaryDevice:get:communicationError', ...
                      'Device %d failed to respond to request to read setting %d.', ...
                      obj.DeviceNo, aSetting);
            elseif (reply.IsError)
                warning('Zaber:BinaryDevice:get:readError', ...
                        'Attempt to read setting %d from device %d resulted in error %d (%s).', ...
                        aSetting, obj.DeviceNo, reply.Data, ...
                        char(Zaber.BinaryErrorType(reply.Data)));
            elseif (reply.Command ~= aSetting)
                error('Zaber:BinaryDevice:get:badSetting', ...
                      'Device %d responded with wrong setting number when reading setting %d.', ...
                      obj.DeviceNo, aSetting);
            else
                value = reply.Data;
            end
        end
            
        
        function result = set(obj, aSetting, aValue)
        % SET Write a value to a device setting.
        % result = device.set(setting, value)
        %
        % setting - Numeric identifier for the setting to write. For legal
        %           values, see the Zaber binary protocol manual:
        %           http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual
        %           or use the Zaber.BinaryCommandType enumeration.
        % value   - New value of the setting, as a 32-bit integer.
        % result  - True if the write succeeded, or the reply message if
        %           the device returned an error response.
        %
        % Errors will be thrown if there is a communication error. If the
        % setting does not exist, if the setting is read-only, or if the
        % value provided is out of range for the setting then a warning
        % will occur and the device's response message will be returned.
        %
        % See also get, Zaber.BinaryCommandType, Zaber.BinaryErrorType
        
            result = false;
            reply = obj.Protocol.request(...
                Zaber.BinaryMessage(obj.DeviceNo, int32(aSetting), aValue));
            
            if (~isa(reply, 'Zaber.BinaryMessage'))
                error('Zaber:BinaryDevice:set:commandFailed', ...
                      'Device %d failed to respond to request to write setting %d.', ...
                      obj.DeviceNo, aSetting);
            elseif (reply.IsError)
                warning('Zaber:BinaryDevice:set:writeError', ...
                        'Attempt to read setting %d from device %d resulted in error %d (%s).', ...
                        aSetting, obj.DeviceNo, reply.Data, ...
                        char(Zaber.BinaryErrorType(reply.Data)));
            else
                result = true;
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
        % See also getposition, moveabsolute, getnumindices, Units
        
            minPos = 0;
            if (obj.FirmwareVersion >= 6.0)
                minPos = obj.get(Zaber.BinaryCommandType.Set_Minimum_Position);
            end
        
            if (obj.MotionType == Zaber.MotionType.Rotary)
                if (obj.FirmwareVersion >= 6.22)
                    maxPos = obj.get(Zaber.BinaryCommandType.Set_Cycle_Distance);
                else
                    maxPos = obj.get(Zaber.BinaryCommandType.Set_Maximum_Position);
                end
                
                circle = obj.Units.positiontonative(360.0);
                maxPos = min(circle, maxPos);
                
            else
                maxPos = obj.get(Zaber.BinaryCommandType.Set_Maximum_Position);
            end
            
            range = [minPos maxPos];
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
        % Note this command is of little utility when using the Binary
        % protocol because most of the command helpers block until they get
        % a response. It's included for API completeness and to aid protocol
        % independence. This method returns immediately if there is a
        % device error, the device is stalled or the device is parked.
            
            interval = 0.1;
            if (nargin > 1)
                interval = aPingInterval;
            end
        
            moving = true;
            if (~obj.IsAxis)
                moving = false;
            end
            
            while (moving)
                reply = obj.request(...
                    Zaber.BinaryCommandType.Return_Status, 0);
                
                if (~isa(reply, 'Zaber.BinaryMessage'))
                    error = reply;
                    moving = false;
                elseif (reply.IsError || ...
                    (reply.Data == Zaber.BinaryStatusType.Idle) || ...
                    (reply.Data == Zaber.BinaryStatusType.Stalled_or_Displaced) || ...
                    (reply.Data == Zaber.BinaryStatusType.Parked))
                    error = reply.Data;
                    moving = false;
                else
                    pause(interval);
                end
            end
        end

        
        function error = home(obj)
        % HOME Move the device to its home position.
        % error = device.HOME();
        %
        % error - Error code from the device, if the command fails. See
        %         the list of error codes in the Zaber Binary protocol
        %         manual:
        %         http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes
        %         or use the Zaber.BinaryErrorType enumeration.
        %
        % This command will block until the move completes or an error
        % occurs - potentially a long time. 
        %
        % See also moveabsolute, moverelative, moveatvelocity, moveindexed,
        % getposition, stop, waitforidle, Zaber.BinaryErrorType
        
            error = [];
            
            response = obj.request(Zaber.BinaryCommandType.Home, 0);
            if (response.IsError)
                error = response.Data;
            end
        end
        
        
        function error = moveabsolute(obj, aPosition)
        % MOVEABSOLUTE Move the state to an absolute position.
        % error = device.moveabsolute(position);
        % 
        % position - Position to move to, in native device units.
        % error    - Error code from the device, if the command fails. See
        %            the list of error codes in the Zaber Binary protocol
        %            manual:
        %            http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes
        %            or use the Zaber.BinaryErrorType enumeration.
        %
        % This command will block until the move completes or an error
        % occurs - potentially a long time. 
        % If the move completes successfully, the empty array is returned.
        %
        % See also home, stop, waitforidle, getposition, moverelative,
        % moveatvelocity, moveindexed, Units, Zaber.BinaryErrorType  
        
            error = [];
            
            response = obj.request(...
                Zaber.BinaryCommandType.Move_Absolute, int32(aPosition));
            
            if (response.IsError)
                error = response.Data;
            end
        end        
        
        
        function error = moverelative(obj, aDelta)
        % MOVERELATIVE Move the device by a relative amount.
        % error = device.MOVERELATIVE(delta);
        % 
        % delta    - Distance to move by, in native device units.
        % error    - Error code from the device, if the command fails. See
        %            the list of error codes in the Zaber Binary protocol
        %            manual:
        %            http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes
        %            or use the Zaber.BinaryErrorType enumeration.
        %
        % This method blocks until the move completes.
        %
        % See also home, stop, waitforidle, getposition, moveabsolute,
        % moveatvelocity, moveindexed, Units, Zaber.BinaryErrorType  
        
            error = [];
            
            response = obj.request(...
                Zaber.BinaryCommandType.Move_Relative, int32(aDelta));
            
            if (response.IsError)
                error = response.Data;
            end
        end
        
        
        function error = moveatvelocity(obj, aVelocity)
        % MOVEATVELOCITY Move the device at a specified velocity.
        % error = device.MOVEATVELOCITY(velocity);
        % 
        % velocity - Speed to move at, in native device units.
        % error    - Error code from the device, if the command fails. See
        %            the list of error codes in the Zaber Binary protocol
        %            manual:
        %            http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes
        %            or use the Zaber.BinaryErrorType enumeration.
        %
        % This method blocks until the move completes.
        %
        % See also home, stop, waitforidle, getposition, moverelative,
        % moveabsolute, moveindexed, Units, Zaber.BinaryErrorType 
        
            error = [];
            
            response = obj.request(...
                Zaber.BinaryCommandType.Move_at_Constant_Speed, int32(aVelocity));
            
            if (response.IsError)
                error = response.Data;
            end
        end
        
        
        function error = stop(obj)
        % STOP Stop the device if it is moving.
        % error = device.STOP();
        %
        % error     - Error code from the device, if the command fails. See
        %             the list of error codes in the Zaber Binary protocol
        %             manual:
        %             http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes
        %             or use the Zaber.BinaryErrorType enumeration.
        %
        % See also home, waitforidle, getposition, moveabsolute,
        % moverelative, moveatvelocity, moveindexed, Units,
        % Zaber.BinaryErrorType 
        
            error = [];
            
            response = obj.request(Zaber.BinaryCommandType.Stop, 0);
            if (response.IsError)
                error = response.Data;
            end
        end
        
        
        function pos = getposition(obj)
        % GETPOSITION Get the current device position in native units.
        % pos = device.GETPOSITION();
        %
        % If there is a communication error or the device is not an axis,
        % the empty array will be returned.
        %
        % See also range, stop, Units, moveabsolute, moverelative,
        % moveatvelocity, moveindexed, waitforidle
        
            pos = [];
            
            response = obj.request(...
                Zaber.BinaryCommandType.Return_Current_Position, 0);
            
            if (~response.IsError)
                pos = response.Data;
            end
        end
        
        
        function num = getnumindices(obj)
        % GETNUMINDICES Determine how many indexed positions the device has.
        % num = getvice.GETNUMINDICES();
        %
        % Return value is the maximum position that can be passed to
        % MOVEINDEXED. Returns zero on devices that do not support the
        % MOVEINDEXED command.
        %
        % See also range, moveindexed, getposition
            
            num = 0;
            
            range = obj.getrange();
            indexSize = obj.get(Zaber.BinaryCommandType.Set_Index_Distance);
            
            if (~isempty(range) && ~isempty(indexSize))
                num = range(2) / indexSize;
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
        % error - Error code from the device, if the command fails. See
        %         the list of error codes in the Zaber Binary protocol
        %         manual:
        %         http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Error_Codes
        %         or use the Zaber.BinaryErrorType enumeration.
        %
        % This command is intended for use with indexed-position devices
        % such as the Filter Wheel. Although the other movement commands
        % will often work with such devices, this method provides an easier
        % way to reach a useful position.
        %
        % This command will block until the movement completes.
        %
        % See also home, stop, waitforidle, moveabsolute, moverelative,
        % moveatvelocity, Zaber.BinaryErrorType
        
            error = [];
            
            response = obj.request(...
                Zaber.BinaryCommandType.Move_Index, int32(aIndex));
            
            if (response.IsError)
                error = response.Data;
            end
        end
        
    end
    
    
 %% Public static methods
    methods (Static)
        function instance = initialize(aProtocol, aDeviceNumber, aDeviceId)
        % INITIALIZE Construct a representation for a single device.
        % device = Zaber.BinaryDevice.INITIALIZE(protocol, address, id)
        %
        % protocol - A BinaryProtocol instance.
        % address  - The daisy chain address of a device to represent.
        % id       - The numeric device type ID of the device.
        %            Optional. If not provided it will be queried for.
        % obj      - An initialized BinaryDevice instance.
        %
        % Given the daisy chain address and device type ID for a device
        % that has been found using the given protocol, queries the device
        % for its properties and constructs a new Zaber.Device subclass
        % instance to represent that device.
        %
        % See also Zaber.BinaryProtocol, Zaber.Device,
        % Zaber.AsciiDevice.initialize
            
            if (~isa(aProtocol, 'Zaber.BinaryProtocol'))
                error('Zaber:BinaryDevice:initialize:badProtocol', ...
                      'Protocol must be binary to use this method.');
            end
            
            if (nargin > 2)
                deviceId = aDeviceId;
            else
                reply = aProtocol.request(...
                    Zaber.BinaryMessage(aDeviceNumber, ...
                        Zaber.BinaryCommandType.Return_Device_ID, 0));
                
                if (~isempty(reply) && ~reply.IsError)
                    deviceId = reply.Data;
                else
                    error('Zaber:BinaryDevice:initialize:idError', ...
                          'Failed to get the type ID for device %d.', ...
                          aDeviceNumber);
                end
            end
                  
            
            instance = Zaber.BinaryDevice(aProtocol, aDeviceNumber, deviceId);
            
            % Get the firmware version.
            reply = aProtocol.request(...
                Zaber.BinaryMessage(instance.DeviceNo, ...
                    Zaber.BinaryCommandType.Return_Firmware_Version, 0));
                
            if (~reply.IsError)
                instance.FirmwareVersion = double(reply.Data) / 100.0;
            end
            
            % Determine if message ID mode is enabled.
            if (instance.FirmwareVersion < 6.0)                
                data = instance.get(Zaber.BinaryCommandType.Set_Device_Mode);
                if (isnumeric(data))
                    instance.MessageIdsEnabled = (0 ~= bitand(data, 64));
                else
                    error('Zaber:BinaryDevice:initialize:messageIdCheckFailed', ...
                          'Failed to determine message ID mode on device %d.', ...
                          aDeviceNumber);
                end
            else
                data = instance.get(Zaber.BinaryCommandType.Set_Message_ID_Mode);
                if (isnumeric(data))
                    instance.MessageIdsEnabled = (data == 1);
                else
                    error('Zaber:BinaryDevice:initialize:messageIdCheckFailed', ...
                          'Failed to determine message ID mode on device %d.', ...
                          aDeviceNumber);
                end
            end
            
            % Get the peripheral ID.
            reply = instance.Protocol.request(...
                Zaber.BinaryMessage(instance.DeviceNo, ...
                    Zaber.BinaryCommandType.Return_Setting, ...
                    Zaber.BinaryCommandType.Set_Peripheral_ID));
            
            if (isa(reply, 'Zaber.BinaryMessage') && ...
                ~reply.IsError && (reply.Command == Zaber.BinaryCommandType.Set_Peripheral_ID))
                instance.PeripheralId = reply.Data;
            end
            
            % Find database records for this device and peripheral.
            db = Zaber.DeviceDatabase.instance();
            deviceRecord = db.finddevice(instance.DeviceId);
            periRecord = db.findperipheral(deviceRecord, instance.PeripheralId);
            instance.Name = db.getdevicename(deviceRecord, periRecord);
            
            % Get unit conversion properties from the database.
            if (~isempty(periRecord))
                [instance.MotionType, instance.Units] = ...
                    db.determinemotiontype(deviceRecord, periRecord);
                % Get the current resolution.
                instance.Units.Resolution = instance.get(...
                    Zaber.BinaryCommandType.Set_Microstep_Resolution);
            end
            
            instance.IsAxis = (instance.MotionType ~= Zaber.MotionType.None);
            
            instance.IO = Zaber.BinaryIoPort.detect(instance);
        end
    end

    
 %% Protected instance methods
    methods (Access = protected)
        function obj = BinaryDevice(aProtocol, aDeviceNumber, aDeviceId)
        % BINARYDEVICE Initializes properties to their default values.
        % device = Zaber.BINARYDEVICE(protocol, address, id)
        %
        % protocol - A BinaryProtocol instance.
        % address  - The daisy chain address of a device to represent.
        % id       - The numeric device type ID of the device.
        % obj      - An initialized BinaryDevice instance.
        %
        % The device ID argument is the type number of the device. If not
        % detected through code, you can look these IDs up on Zaber's
        % website at: http://www.zaber.com/support/?tab=ID%20Mapping
        %
        % This constructor does not fill in the properties of the
        % device. Use the static initialize method to do that.
        %
        % See also initialize, Device
            
            obj = obj@Zaber.Device(aProtocol, aDeviceNumber, aDeviceId);
            obj.MessageIdsEnabled = false;
        end
    end
end

