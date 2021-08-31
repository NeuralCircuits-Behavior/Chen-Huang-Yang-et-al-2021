% This example shows how to use the Zaber Filter Wheel device,
% or other Zaber devices that have indexed positions.

% This example assumes your device is configured as device #1 and is using 
% the ASCII protocol. You will need to edit values in this example to make
% it work for your particular setup.

% Note for simplicity this example does no error checking.


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
    
    % Find out how many positions the device has.
    nPos = device.getnumindices();
    choice = -1;
    if (nPos > 1)
        fprintf('This device has %d indexed positions.\n', nPos);
        choice = menu('OK to make the device move?','Yes','No');
    else
        fprintf('This device does not support index moves. Terminating.\n');
    end

    if (choice == 1)
        fprintf('Homing the device...\n');
        device.home();
        device.waitforidle();
        
        fprintf('Moving to some random indices...\n');
        for (i = 1:20)
            index = randi(nPos);
            fprintf('%d\n', index);
            device.moveindexed(index);
            device.waitforidle();
        end
    end
    
catch exception
    % Clean up the port if an error occurs, otherwise it remains locked.
    fclose(port);
    rethrow(exception);
end

fclose(port);
delete(port);
clear all;
