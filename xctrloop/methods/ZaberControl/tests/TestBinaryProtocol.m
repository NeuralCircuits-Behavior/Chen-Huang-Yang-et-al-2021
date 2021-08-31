%% Test sending bytes
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
port.expect([ 0 1 2 3 4 5 ], 6);
assert(port.BytesAvailable == 0);
protocol.send([ 0 1 2 3 4 5 ]);
assert(port.BytesAvailable == 1);

%% Test sending wrong size packets
hadError = false;
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
try
    protocol.send([ 0 1 2 3 4 5 6 ]);
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, '6 bytes'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

hadError = false;
try
    protocol.send([ 0 1 2 3 4 ]);
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, '6 bytes'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test sending BinaryMessage
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
message = Zaber.BinaryMessage(0, 1, 2, 3);
expected = message.serialize();
port.expect(expected, 4);
assert(port.BytesAvailable == 0);
protocol.send(expected);
assert(port.BytesAvailable == 1);

%% Test receive
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
message = Zaber.BinaryMessage(0, 1, 2, 3);
port.expect(message.serialize(), [ 1 2 255 255 255 3 ]);
protocol.send(message);
response = protocol.receive(true);
assert(isa(response, 'Zaber.BinaryMessage'));
assert(response.DeviceNo == 1);
assert(response.Command == 2);
assert(response.Data == -1);
assert(response.MessageId == 3);

%% Test receive with insufficient reply data.
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
message = Zaber.BinaryMessage(0, 1, 2, 3);
port.expect(message.serialize(), [ 1 2 255 255 255 ]);
protocol.send(message);
response = protocol.receive();
assert(~isa(response, 'Zaber.BinaryMessage'));

%% Test request with message IDs.
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
message = Zaber.BinaryMessage(0, 1, 2, 3);
port.expect(message.serialize(), [ 1 2 255 255 255 255 ]);
response = protocol.request(message);
assert(isa(response, 'Zaber.BinaryMessage'));
assert(response.DeviceNo == 1);
assert(response.Command == 2);
assert(response.Data == -1);
assert(response.MessageId == 255);

%% Test request without message IDs.
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
message = Zaber.BinaryMessage(0, 1, 2);
port.expect(message.serialize(), [ 1 2 255 255 255 255 ]);
response = protocol.request(message);
assert(isa(response, 'Zaber.BinaryMessage'));
assert(response.DeviceNo == 1);
assert(response.Command == 2);
assert(response.Data == -1);
assert(response.MessageId == 0);

%% Test find devices with no responses.
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
port.expect([ 0 50 0 0 0 0 ], []);
devices = protocol.finddevices();
assert(isequal(devices, []));

%% Test find devices with one response.
port = MockPort();
port.expect([ 0 50 0 0 0 0 ], [ 1 50 177 29 0 0 ]); % T-LSQ600A
port.expect([ 1 51 0 0 0 0 ], [ 1 51 8 2 0 0 ]); % FW 5.20
port.expect([ 1 53 40 0 0 0 ], [ 1 40 0 0 0 0 ]); % Mode
port.expect([ 1 53 66 0 0 0 ], [ 1 255 36 0 0 0 ]); % Peripheral ID
port.expect([ 1 53 37 0 0 0 ], [ 1 37 64 0 0 0 ]); % Resolution
port.expect([ 1 77 0 0 0 0 ], [ 1 77 0 0 0 0 ]); % Analog output count.
port.expect([ 1 75 0 0 0 0 ], [ 1 75 0 0 0 0 ]); % Analog input count.
port.expect([ 1 70 0 0 0 0 ], [ 1 70 0 0 0 0 ]); % Digital output count.
port.expect([ 1 67 0 0 0 0 ], [ 1 67 0 0 0 0 ]); % Digital input count.
protocol = Zaber.BinaryProtocol(port);
devices = protocol.finddevices();
assert(length(devices) == 1);
device = devices(1);
assert(device.DeviceId == 7601);
assert(device.FirmwareVersion == 5.20);
assert(~device.MessageIdsEnabled);
assert(device.Units.Resolution == 64);
assert(device.PeripheralId == 0);
assert(isempty(device.IO));

%% Test find devices with two responses.
port = MockPort();
% T-LSQ600A and X-MCB2
port.expect([ 0 50 0 0 0 0 ], [ 1 50 177 29 0 0 2 50 14 118 0 0 ]); 
% Device 1
port.expect([ 1 51 0 0 0 0 ], [ 1 51 8 2 0 0 ]); % FW 5.20
port.expect([ 1 53 40 0 0 0 ], [ 1 40 0 0 0 0 ]); % Mode
port.expect([ 1 53 66 0 0 0 ], [ 1 255 36 0 0 0 ]); % Peripheral ID
port.expect([ 1 53 37 0 0 0 ], [ 1 37 64 0 0 0 ]); % Resolution
port.expect([ 1 77 0 0 0 0 ], [ 1 77 0 0 0 0 ]); % Analog output count.
port.expect([ 1 75 0 0 0 0 ], [ 1 75 0 0 0 0 ]); % Analog input count.
port.expect([ 1 70 0 0 0 0 ], [ 1 70 0 0 0 0 ]); % Digital output count.
port.expect([ 1 67 0 0 0 0 ], [ 1 67 0 0 0 0 ]); % Digital input count.
% Device 2
port.expect([ 2 51 0 0 0 0 ], [ 2 51 112 2 0 0 ]); % FW 6.24
port.expect([ 2 53 102 0 0 0 ], [ 2 102 1 0 0 0 ]); % Mode
port.expect([ 2 53 66 0 0 0 ], [ 2 66 8 180 0 0 ]); % Peripheral ID
port.expect([ 2 53 37 0 0 0 ], [ 2 37 128 0 0 0 ]); % Resolution
port.expect([ 2 77 0 0 0 0 ], [ 2 77 1 0 0 0 ]); % Analog output count.
port.expect([ 2 75 0 0 0 0 ], [ 2 75 2 0 0 0 ]); % Analog input count.
port.expect([ 2 70 0 0 0 0 ], [ 2 70 3 0 0 0 ]); % Digital output count.
port.expect([ 2 67 0 0 0 0 ], [ 2 67 4 0 0 0 ]); % Digital input count.
protocol = Zaber.BinaryProtocol(port);
devices = protocol.finddevices();
assert(length(devices) == 2);
device = devices(1);
assert(device.DeviceId == 7601);
assert(device.FirmwareVersion == 5.20);
assert(~device.MessageIdsEnabled);
assert(device.Units.Resolution == 64);
assert(device.PeripheralId == 0);
assert(isempty(device.IO));
device = devices(2);
assert(device.DeviceId == 30222);
assert(device.FirmwareVersion == 6.24);
assert(device.MessageIdsEnabled);
assert(device.Units.Resolution == 128);
assert(device.PeripheralId == 46088);
assert(~isempty(device.IO));
assert(device.IO.AnalogOutputCount == 1);
assert(device.IO.AnalogInputCount == 2);
assert(device.IO.DigitalOutputCount == 3);
assert(device.IO.DigitalInputCount == 4);


%% Cleanup
clear all;
