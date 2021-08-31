%% User Guide
% This toolbox provides some flexibility in its setup to allow for
% different use cases. The general progression is to set up your
% communication port, detect or choose a protocol, identify your devices,
% and then control the devices. The following sections go through these
% phases in that order.

%% Port and Protocol initialization
% Assuming you have already set up your hardware and configured your Zaber
% devices (see <introduction.html#3 Requirements), the first step is to
% configure and open a serial port in MATLAB.
%
% Some of the recommended port settings depend on the baud rate and
% protocol you have configured your devices to use. 
%
%%% Binary Protocol
%
%   port = serial('COM3'); % Substitute the correct name of your port.
%
% Set default serial port properties for the binary protocol.
%
%   set(port, ...
%       'BaudRate', 9600, ...
%       'DataBits', 8, ...
%       'FlowControl', 'none', ...
%       'Parity', 'none', ...
%       'StopBits', 1);
%
% There are cases where the Zaber toolbox deliberately waits for
% port reception to time out. To reduce the wait time and suppress
% timeout messages, use the following two commands.
%
%   set(port, 'Timeout', 0.5)
%   warning off MATLAB:serial:fread:unsuccessfulRead
%
% Open the port.
%
%   fopen(port);
%
% In this example we know we're using the binary protocol, so just
% instantiate it directly.
%
%   protocol = Zaber.BinaryProtocol(port);

%%% ASCII Protocol
%
%   port = serial('COM3'); % Substitute the correct name for your port.
%
% Set default serial port properties for the ASCII protocol.
% Note the ASCII protocol supports multiple baud rates from 9600 up to
% 115200, but the latter is the most commonly used.
%
%   set(port, ...
%       'BaudRate', 115200, ...
%       'DataBits', 8, ...
%       'FlowControl', 'none', ...
%       'Parity', 'none', ...
%       'StopBits', 1, ...
%       'Terminator','CR/LF');
%
% There are cases where the Zaber toolbox deliberately waits for
% port reception to time out. To reduce the wait time and suppress
% timeout messages, use the following two commands.
%
%   set(port, 'Timeout', 0.5)
%   warning off MATLAB:serial:fgetl:unsuccessfulRead
%
% Open the port.
%
%   fopen(port);
%
% In this example we know we're using the ASCII protocol, so just
% instantiate it directly.
%
%   protocol = Zaber.AsciiProtocol(port);

%%% Protocol and baud rate not known
% This toolbox also provides the ability to detect which protocol your
% first device (the one directly connected to the computer) is using. If
% you don't know the baud rate your device is set to, you can attempt
% detection at multiple baud rates in a loop until you get a response. See
%  Example_Advanced.m for a full example, but the
% general steps are: initialize the port as in the above examples, pick a
% baud rate, open the port, then call:
%
%   protocol = Zaber.Protocol.detect(port);
%
% If 'protocol' is empty after this call, then detection failed and you
% should close the port, reopen it at a different baud rate, and try
% again.
%
% Note that it is possible to have a situation where you have multiple
% devices in a daisy chain, each using different protocol and baud rate
% settings, and also possibly having conflicting addresses. In such cases
% protocol detection may fail, or device detection may not find all of your
% devices. <http://www.zaber.com/wiki/Software/Zaber_Console Zaber Console>
% can be used to force all devices into a consistent and non-conflicting
% configuration.

%% Identify Devices
% If you know which protocol you are using and have instantiated it as
% above, and you know what addresses your devices are configured to use on
% the serial port, then you can just manually create a device class
% instance for each one as follows:
%
% Binary protocol, device address 1
%
%   device1 = Zaber.BinaryDevice.initialize(protocol, 1); 
%
% or ASCII protocol, device address 1
%
%   device1 = Zaber.AsciiDevice.initialize(protocol, 1);
%
% Note that 'initialize' means 'initialize the device class', not
% 'initialize the device hardware'. This method creates a class instance
% and fills it in using data read from the device and from the device
% database included with this toolbox. You will see the communication
% lights on the device flash, but the software is not changing any settings
% on the device during this process.
%
% If you are using the protocol-agnostic interface and don't know or care
% which protocol is in use or what the device addresses are, you can
% automatically enumerate all of the devices like this:
%
%   devices = protocol.finddevices();
%
% This gives you back an array of initialized device instances, and you can
% start calling their methods to make the devices move. Note that the
% indices of the devices in this array do NOT correspond to the device
% addresses; use the DeviceNo property on an instance to learn its address.

%% Control Devices
% Once you have an initialized device instance, you can make calls on it to
% make the device move. For example, to start with you should move the
% device to its home position to ensure it has a reference position:
%
%   device.home();
%   device.waitforidle();
%
% Now let's say you have a linear stage and you want to move it to a
% position 10cm from its home position. You can do the unit conversion and
% the move as follows:
%
%   position = device.Units.positiontonative(0.1); % 10cm = 0.1m.
%   device.moveabsolute(position); % Tell the device to move.
%   device.waitforidle(); % Wait for the move to finish.
%
% The generic device class provides methods for moving to absolute,
% relative or indexed positions, moving at a specified velocity, moving to
% the home position, stopping, waiting for completion, and getting the
% device's current position and range of motion. 
%
% Most Zaber devices have additional capabilities not covered by the above
% set of functions, as well as many settings that can be read and written.
% To access those capabilities you need to know which protocol you are
% using in order to formulate a command and interpret the response from the
% device. For example, here's how to read the device's serial number in
% both protocols:
%
% Binary - commands and data are all numbers. Enumerations are provided to
% give symbolic names to the numbers. A full protocol description is available
% here: http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual
%
%   reply = device.request(Zaber.BinaryCommandType.Return_Serial_Number, 0);
%   if (isempty(reply))
%       fprintf('The device did not respond to the serial number request.\n');
%   elseif (reply.IsError)
%       fprintf('The device responsed with error %d (%s).\n', ...
%           reply.Data, char(Zaber.BinaryErrorType(reply.Data)));
%   else
%       fprintf('Device serial number is %d.\n', reply.Data);
%   end
%
% ASCII - all commands are strings, and data can be strings or numbers. A full
% protocol description is available here: 
% http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual
%
%   reply = device.request('get', 'system.serial');
%   if (isempty(reply))
%       fprintf('The device did not respond to the serial number request.\n');
%   elseif (reply.IsError)
%       fprintf('The device responsed with error %d (%s).\n', ...
%           reply.Data, char(Zaber.BinaryErrorType(reply.Data)));
%   else
%       fprintf('Device serial number is %d.\n', reply.Data);
%   end

%% Port leaks
%
% If a device error or a communication error occurs, many methods in this
% toolbox will throw an error. When this happens the port is not
% automatically closed, and attempts to reopen it will fail. It is easy to
% leak open ports by assigning a new serial port instance to the same name
% without first closing the previous instance. When this happens you can
% find and close the previous instance as in this example:
%
%   >> serialObj = instrfind
% 
%   Instrument Object Array
% 
%   Index:    Type:     Status:   Name:  
%   1         serial    closed    Serial-COM3
%   2         serial    open      Serial-COM3
%   3         serial    closed    Serial-COM3
% 
%   >> fclose(serialObj(2))
%
% To avoid this, we recommend that you enclose all usage of the Zaber
% toolbox in try/catch blocks, and clean up the serial port in the catch
% block - see the examples.
