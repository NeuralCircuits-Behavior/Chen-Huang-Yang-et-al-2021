classdef DeviceUnits < handle
%   DEVICEUNITS Unit conversion helper for Zaber devices.
%   This class is used to store the unit scale factors for Zaber devices.
%   Unit conversions vary from device to device according to variations in
%   physical characteristics.
%
%   Note that for most devices, the device's resolutions setting must be
%   factored into the conversions. The scale properties found in this
%   class are typically measures of the number of device "steps" per
%   standard unit, but native device units are "microsteps" of which there
%   are "resolution" amount per step. So for example the native quantity
%   for position is the position scale times the number of meters times
%   the device resolution.
%
%   See also Zaber.Device.Units
 
%   Author: Zaber Technologies Software Team <contact@zaber.com>
 

%% Public instance properties
    properties
        % POSITIONUNITSCALE Number of coarse position units per meter or 
        % degree.
        PositionUnitScale
        
        % VELOCITYUNITSCALE Number of coarse velocity units per m/s or 
        % degrees/s.
        VelocityUnitScale
        
        % ACCELERATIONUNITSCALE Number of coarse acceleration units per 
        % m/s^2 or degrees/s^2.
        AccelerationUnitScale
        
        % FORCEUNITSCALE Number of force units per newton.
        ForceUnitScale
        
        % RESOLUTION Device resolution in units of microstep per step,
        % where applicable. Set to 1 if not applicable.
        Resolution
    end
    
    
 %% Public instance methods
    methods
        function obj = DeviceUnits()
        % DEVICEUNITS Constructor. Initializes conversions to unity.
            obj.PositionUnitScale = 1.0;
            obj.VelocityUnitScale = 1.0;
            obj.AccelerationUnitScale = 1.0;
            obj.ForceUnitScale = 1.0;
            obj.Resolution = 1.0;
        end

        
        function result = positiontonative(obj, aPosition)
        % POSITIONTONATIVE Convert position to device units.
        % microsteps = units.POSITIONTONATIVE(position);
        %
        % position   - The desired position for the device. Units are
        %              meters if it is a linear device, or degrees if it
        %              is a rotary device.
        % microsteps - The number to send to the device in a move
        %              absolute command to reach the desired position.
        
            result = double(aPosition) * obj.PositionUnitScale * double(obj.Resolution);
        end

        
        function result = nativetoposition(obj, aPosition)
        % NATIVETOPOSITION Convert device position units to standard.
        % siUnits = units.NATIVETOPOSITION(position);
        %
        % position - The current position of the device in its native
        %            units.
        % siUnits  - The device position converted to meters for linear
        %            devices or degrees for rotary devices.
        
            result = (double(aPosition) / double(obj.Resolution)) / obj.PositionUnitScale;
        end

        
        function result = velocitytonative(obj, aVelocity)
        % VELOCITYTONATIVE Convert velocity to device units.
        % microsteps = units.VELOCITYTONATIVE(position);
        %
        % velocity   - The desired velocity for the device. Units are
        %              meters per second if it is a linear device, or 
        %              degrees per second if it is a rotary device.
        % microsteps - The number to send to the device in a move
        %              at velocity command to reach the desired speed.
        
            result = double(aVelocity) * obj.VelocityUnitScale * double(obj.Resolution);
        end

        
        function result = nativetovelocity(obj, aVelocity)
        % NATIVETOVELOCITY Convert device velocity units to standard.
        % siUnits = units.NATIVETOVELOCITY(velocity);
        %
        % velocity - A velocity of the device in its native units.
        % siUnits  - The device velocity converted to meters per second 
        %            for linear devices or degrees per second for rotary
        %            devices. 
        
            result = (double(aVelocity) / double(obj.Resolution)) / obj.VelocityUnitScale;
        end

        
        function result = accelerationtonative(obj, aAccel)
        % ACCELERATIONTONATIVE Convert acceleration to device units.
        % microsteps = units.ACCELERATIONTONATIVE(accel);
        %
        % accel      - The desired acceleration for the device. Units are
        %              meters per second squared if it is a linear device, or 
        %              degrees per second squared if it is a rotary device.
        % microsteps - The number to send to the device when changing
        %              an acceleration setting.
        
            result = double(aAccel) * obj.AccelerationUnitScale * double(obj.Resolution);
        end

        
        function result = nativetoacceleration(obj, aAccel)
        % NATIVETOACCELERATION Convert device acceleration units to standard.
        % siUnits = units.NATIVETOACCELERATION(accel);
        %
        % accel   - An acceleration of the device in its native units.
        % siUnits - The device acceleration converted to meters per second 
        %           squared for linear devices or degrees per second
        %           squared for rotary devices. 
        
            result = (double(aAccel) / double(obj.Resolution)) / obj.AccelerationUnitScale;
        end

        
        function result = forcetonative(obj, aNewtons)
        % FORCETONATIVE Convert force in newtons to device units.
        % deviceunits = units.FORCETONATIVE(newtons);
        %
        % newtons    - The desired force output from the device, in 
        %              newtons. Note that only some device types support
        %              force output mode.
        % deviceunits - The number to send to the device when issuing a
        %               force output command.
        
            result = double(aNewtons) * obj.ForceUnitScale;
        end

        
        function result = nativetoforce(obj, aDeviceUnits)
        % NATIVETOFORCE Convert device force units to newtons.
        % newtons = units.NATIVETOFORCE(deviceunits);
        %
        % deviceunits - A force measurement from the device, in its own
        %               units.
        % newtons - The device force converted to newtons.
        
            result = double(aDeviceUnits) / obj.ForceUnitScale;
        end
    end
    
end

