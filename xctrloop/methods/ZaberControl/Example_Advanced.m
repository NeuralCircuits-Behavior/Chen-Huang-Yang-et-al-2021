% This is an ADVANCED example for an uncommon use case. This example
% demonstrates how to automatically detect Zaber devices without knowing
% what protocol or baud rate they're using; it will scan a selected serial
% port with various settings it finds some Zaber devices, then it will 
% make them move using the generic device representations provided by the
% Zaber toolbox.

% It's more common to already know what protocol and serial port settings
% you're using, and how your devices are set up. See the Ascii and Binary
% examples for simpler, more common usage.


% This example uses only one port.  You could try this same detection
% procedure with each available serial port until you find something, but
% that could cause problems if you have other serial hardware hooked up.

% You probably need to change the port name depending on your
% OS and hardware setup.
portName = 'COM17';
port = serial(portName);

% Set default serial port properties for both protocols.
set(port, ...
    'DataBits', 8, ...
    'FlowControl', 'none', ...
    'Parity', 'none', ...
    'StopBits', 1, ...
    'Terminator','CR/LF');

% There are cases where the Zaber toolbox deliberately waits for
% port reception to time out. To reduce the wait time and suppress
% timeout messages, use the following two commands.
set(port, 'Timeout', 0.5)
warning off MATLAB:serial:fread:unsuccessfulRead
warning off MATLAB:serial:fgetl:unsuccessfulRead


% List of supported baud rates to try.
baudRates = [ 115200 57600 38400 19200 9600 ];

% Try each baud rate until we get a response.
protocol = [];
i = 1;
while ((i <= length(baudRates)) && ~isa(protocol, 'Zaber.Protocol'))
    
    baudRate = baudRates(i);
    fprintf('Attempting detection on %s at %d baud...\n', ...
        portName, baudRate);
    set(port, 'BaudRate', baudRate);
    
    % Open the port.
    if (strcmp(port.Status, 'open'))
        fclose(port);
    end
    
    fopen(port);
    
    try
        % Try to detect a protocol on this port.
        protocol = Zaber.Protocol.detect(port);
        if (isa(protocol, 'Zaber.BinaryProtocol'))
            fprintf('Detected binary protocol!\n');
        elseif (isa(protocol, 'Zaber.AsciiProtocol'))
            fprintf('Detected ASCII protocol!\n');
        end

    catch exception
        % Clean up the port if an error occurs, otherwise it remains locked.
        fclose(port);
        fprintf('Error while attempting to detect the protocol.\n');
        rethrow(exception);
    end
    
    i = i + 1;
end

if (~isa(protocol, 'Zaber.Protocol'))
    fclose(port);
    error('Failed to detect any Zaber devices on port %s.', portName);
end


try
    % We've found some devices on this port. Now what we know the protocol
    % and baud rate, we can enumerate the devices and detect their
    % properties.
    devices = protocol.finddevices();
    
catch exception
    % Clean up the port if an error occurs, otherwise it remains locked.
    fclose(port);
    rethrow(exception);
end
   
fprintf('Found %d devices:\n', length(devices));


% Loop over the devices we found and put the parts that move into a
% separate list.
axes = [];
for (i = 1:length(devices))
    device = devices(i);
    disp(device);
    
    % For the movement section, generate a list of just the axes.
    if (device.IsAxis)
        axes = [axes, device];
    end
    
    for (j = 1:length(device.Axes))
        if (device.Axes(j).IsAxis)
            axes = [axes, device.Axes(j)];
        end
    end
end


% Now loop over the moving parts, print information about them, and
% optionally make them move.
choice = 0;
if (~isempty(axes))
    choice = menu('OK to make the devices move?','Yes','No');
    if (choice == 1)
        for (i = 1:length(axes))
            try
                device = axes(i);
                if (device.MotionType ~= Zaber.MotionType.None)
                    fprintf('Moving device %d axis %d (%s)...\n', ...
                        device.DeviceNo, device.AxisNo, device.Name);

                    range = double(device.getrange());
                    if (~isempty(device.Units))                   
                        range = device.Units.nativetoposition(range);
                    end
                    
                    fprintf('- Moving to home.\n');
                    device.home();
                    device.waitforidle();
                    
                    fprintf('- Range = %s\n', mat2str(range));
                    targetPos = range(1) + 0.1 * (range(2) - range(1));
                    fprintf('- Moving to %s.\n', mat2str(targetPos));
                    if (~isempty(device.Units))                   
                        targetPos = device.Units.positiontonative(targetPos);
                    end

                    device.moveabsolute(targetPos);
                    device.waitforidle();
                    
                else
                    fprintf('Skipping device %d because it doesn''t move.', i);
                end
                
                fprintf('\n');

            catch exception
                % Clean up the port if an error occurs, otherwise it remains locked.
                fclose(port);
                fprintf('There was an error while moving devices.\n');
                rethrow(exception);
            end
        end
    end
end

fclose(port);
delete(port);
clear all;
