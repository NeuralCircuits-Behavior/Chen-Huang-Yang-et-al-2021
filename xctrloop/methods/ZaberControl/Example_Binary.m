% This is an example of how to use the Zaber MATLAB toolbox when you know
% what devices you have connected and have already set them all to use the
% Binary protocol. 

% You will need to edit values in this example to make it work for your
% particular setup.

% For simplicity this example does no error checking.


% Initialize port.
port = serial('COM1');

% Set default serial port properties for the binary protocol.
set(port, ...
    'BaudRate', 9600, ...
    'DataBits', 8, ...
    'FlowControl', 'none', ...
    'Parity', 'none', ...
    'StopBits', 1);

% There are cases where the Zaber toolbox deliberately waits for
% port reception to time out. To reduce the wait time and suppress
% timeout messages, use the following two commands.
set(port, 'Timeout', 0.5)
warning off MATLAB:serial:fread:unsuccessfulRead

% Open the port.
fopen(port);

% In this example we know we're using the binary protocol, so just
% instantiate it directly.
protocol = Zaber.BinaryProtocol(port);

try
    % This example assumes we have a device in binary mode at address 1.
    % Create a representation of it and query the device for its
    % properties.
    device = Zaber.BinaryDevice.initialize(protocol, 1);   
    fprintf('Device 1 is a %s with firmware version %f\n', ...
        device.Name, device.FirmwareVersion);
    
  if (device.IsAxis)    
        
        % Print some information about the device's physical movement.
        range = device.getrange();
        fprintf('Movement range in device units is %s.\n', mat2str(range));
        
        unitName = 'microsteps';
        if (device.MotionType == Zaber.MotionType.Linear)
            fprintf('Device travel length is %f m.\n', ...
                device.Units.nativetoposition(range(2) - range(1)));
            unitName = 'm';
        elseif (device.MotionType == Zaber.MotionType.Rotary)
            fprintf('This is a rotary device.\n');
            unitName = '°';
        else
            fprintf('This is neither a linear nor a rotary stage.\n');
        end
        
        choice = menu('OK to make the device move?','Yes','No');
        if (choice == 1)
            % Demonstrate the home command.
            fprintf('Homing the device...\n');
            device.home();
            pause(1.0);
            
            % Demonstrate the move absolute command.
            targetPos = range(1) + (range(2) - range(1)) / 10;
            fprintf('Moving to the 10%% position (%f %s)...\n', ...
                device.Units.nativetoposition(targetPos), ...
                unitName);
            device.moveabsolute(targetPos);
            pause(1.0);
            
            % Demonstrate the move at velocity command.
            maxVel = device.get(Zaber.BinaryCommandType.Set_Target_Speed);
            fprintf('Device''s maximum speed is %d (%f %s/s).\n', ...
                maxVel, device.Units.nativetovelocity(maxVel), ...
                unitName);
            fprintf('Moving forward at 25%% max velocity...\n');
            device.moveatvelocity(maxVel / 4);
            pause(3.0);

            % Demonstate the stop command.
            device.stop();            
            pos = device.getposition();
            fprintf('Current position is %d (%f %s) from home.\n', ...
                pos, device.Units.nativetoposition(pos), ...
                unitName);
            pause(1.0);
            
            % Demonstrage the move relative command.
            fprintf('Moving backwards by 10%% of length...\n');
            device.moverelative(-targetPos);
            pause(1.0);
        end
       
    else
        fprintf('This device is not a movable axis.\n');
    end

    % Example of how to communicate with the device when no helper
    % method is provided for the command. Let's try to get the
    % device's serial number. You need to look up the magic command numbers
    % (63 in this case) in the Zaber Binary Protocol Manual:
    % http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual
    reply = device.request(Zaber.BinaryCommandType.Return_Serial_Number, 0);
    if (isempty(reply) || reply.IsError)
        fprintf('The device did not respond to the serial number request.\n');
    else
        fprintf('Device serial number is %d.\n', reply.Data);
    end
    
catch exception
    % Clean up the port if an error occurs, otherwise it remains locked.
    fclose(port);
    rethrow(exception);
end

fclose(port);
delete(port);
clear all;
