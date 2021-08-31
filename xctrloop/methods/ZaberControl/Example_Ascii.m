% This is an example of how to use the Zaber MATLAB toolbox when you know
% what devices you have connected and have already set them all to use the
% ASCII protocol. 

% You will need to edit values in this example to make it work for your
% particular setup.

% Note for simplicity this example does little error checking.

% Initialize port.
port = serial('COM1');

% Set default serial port properties for the ASCII protocol.
set(port, ...
    'BaudRate', 115200, ...
    'DataBits', 8, ...
    'FlowControl', 'none', ...
    'Parity', 'none', ...
    'StopBits', 1, ...
    'Terminator','CR/LF');

% There are cases where the Zaber toolbox deliberately waits for
% port reception to time out. To reduce the wait time and suppress
% timeout messages, use the following two commands.
set(port, 'Timeout', 0.5)
warning off MATLAB:serial:fgetl:unsuccessfulRead

% Open the port.
fopen(port);

% In this example we know we're using the ASCII protocol, so just
% instantiate it directly.
protocol = Zaber.AsciiProtocol(port);

try
    % This example assumes we have a device in ASCII mode at address 1.
    % Create a representation of it and query the device for its
    % properties.
    device = Zaber.AsciiDevice.initialize(protocol, 1);   
    fprintf('Device 1 is a %s with firmware version %f\n', ...
        device.Name, device.FirmwareVersion);
    
    axes = [];
    if (device.IsAxis)
        axes = device;
    else
        axes = device.Axes;
    end
    
    if (~isempty(axes))    
        
        choice = -1;
        
        for (i = 1:length(axes))
            axis = axes(i);
        
            % Print some information about the device's physical movement.
            range = axis.getrange();
            fprintf('Axis %d movement range in device units is %s.\n', i, mat2str(range));

            unitName = 'microsteps';
            if (axis.MotionType == Zaber.MotionType.Linear)
                fprintf('Device travel length is %f m.\n', ...
                    axis.Units.nativetoposition(range(2) - range(1)));
                unitName = 'm';
            elseif (axis.MotionType == Zaber.MotionType.Rotary)
                fprintf('This is a rotary device.\n');
                unitName = '°';
            else
                fprintf('This is neither a linear nor a rotary stage.\n');
            end
        
            
            if (choice == -1)
                choice = menu('OK to make the device(s) move?','Yes','No');
            end
            
            if (choice == 1)
                % Demonstrate the home command.
                fprintf('Homing %s...\n', axis.Name);
                axis.home();
                axis.waitforidle();
                pause(1.0);
                
                if (~strcmp(axis.Flags, '--'))
                    fprintf('Aborting because this device is in a warning state (''%s'').\n', ...
                            axis.Flags);
                    continue;
                end

                % Demonstrate the move absolute command.
                targetPos = range(1) + (range(2) - range(1)) / 10;
                fprintf('Moving to the 10%% position (%f %s)...\n', ...
                    axis.Units.nativetoposition(targetPos), ...
                    unitName);
                axis.moveabsolute(targetPos);
                axis.waitforidle();
                pause(1.0);

                % Demonstrate the move at velocity command.
                maxVel = axis.get('maxspeed');
                fprintf('Device''s maximum speed is %d (%f %s/s).\n', ...
                    maxVel, axis.Units.nativetovelocity(maxVel), ...
                    unitName);
                fprintf('Moving forward at 25%% max velocity...\n');
                axis.moveatvelocity(maxVel / 4);
                pause(3.0);

                % Demonstrate the stop command.
                axis.stop();            
                axis.waitforidle();
                pos = axis.getposition();
                fprintf('Current position is %d (%f %s) from home.\n', ...
                    pos, axis.Units.nativetoposition(pos), ...
                    unitName);
                pause(1.0);

                % Demonstrage the move relative command.
                fprintf('Moving backwards by 10%% of length...\n');
                axis.moverelative(-targetPos);
                axis.waitforidle();
                pause(1.0);
            end
        end       
    else
        fprintf('This device has no movable axes.\n');
    end

    % Example of how to communicate with the device when no helper
    % method is provided for the command. Let's try to get the
    % device's serial number. You can look up possible commands in the
    % Zaber ASCII Protocol Manual:
    % http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual
    reply = device.request('get', 'system.serial');
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
