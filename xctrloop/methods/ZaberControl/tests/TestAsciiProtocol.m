%% Test sending strings
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
assert(port.BytesAvailable == 0);
port.expect('Foo?', 'Bar!');
protocol.send('Foo?');
assert(port.BytesAvailable > 0);

%% Test sending AsciiMessage
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
message = Zaber.AsciiMessage(0, 'Foo?', []);
expected = message.serialize();
port.expect(expected, 'Bar!');
assert(port.BytesAvailable == 0);
protocol.send(expected);
assert(port.BytesAvailable > 0);

%% Test receive
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
message = Zaber.AsciiMessage(0, 'Foo?', []);
port.expect(message.serialize(), sprintf('@01 2 OK IDLE -- 0\r\n'));
protocol.send(message);
response = protocol.receive();
assert(isa(response, 'Zaber.AsciiMessage'));
assert(response.DeviceNo == 1);
assert(response.Data == 0);
assert(response.MessageType == Zaber.MessageType.Response);
assert(response.AxisNo == 2);
assert(strcmp(response.Flags, '--'));
assert(~response.IsError);

%% Test receive with insufficient reply data.
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
message = Zaber.AsciiMessage(0, 'Foo?', []);
port.expect(message.serialize(), sprintf('@01 2 OK IDLE -'));
protocol.send(message);
response = protocol.receive();
assert(isequal([], response));


%% Test request with message IDs.
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
message = Zaber.AsciiMessage(0, 'Foo?', [], 'MessageId', 65);
port.expect(message.serialize(), sprintf('@01 2 65 OK IDLE -- 0\r\n'));
response = protocol.request(message);
assert(isa(response, 'Zaber.AsciiMessage'));
assert(response.DeviceNo == 1);
assert(response.AxisNo == 2);
assert(response.MessageId == 65);

%% Test request without message IDs.
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
message = Zaber.AsciiMessage(0, 'Foo?', []);
port.expect(message.serialize(), sprintf('@01 2 OK IDLE -- 0\r\n'));
response = protocol.request(message);
assert(isa(response, 'Zaber.AsciiMessage'));
assert(response.DeviceNo == 1);
assert(response.AxisNo == 2);
assert(response.MessageId == -1);

%% Test find devices with no responses.
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
port.expect(Zaber.AsciiMessage(0, 'get deviceid', []), []);
devices = protocol.finddevices();
assert(isequal(devices, []));

%% Test find devices with one response.
port = MockPort();
port.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE -- 20031\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- 6.18\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get resolution', []), sprintf('@01 0 OK IDLE -- 32\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE NC 0 0 0 0\r\n'));
protocol = Zaber.AsciiProtocol(port);
devices = protocol.finddevices();
assert(length(devices) == 1);
device = devices(1);
assert(device.DeviceId == 20031);
assert(device.FirmwareVersion == 6.18);
assert(strcmp(device.Flags, 'NC'));
assert(device.Units.Resolution == 32);
assert(device.IsAxis);
assert(isempty(device.Axes));
assert(isempty(device.IO));

%% Test that force unit scale is read from the database.
port = MockPort();
port.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE -- 50419\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- 6.25\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 1\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 1), sprintf('@01 0 RJ IDLE WR BADCOMMAND\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get resolution', []), sprintf('@01 0 OK IDLE -- 1\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE -- 0 0 0 0\r\n'));
protocol = Zaber.AsciiProtocol(port);
devices = protocol.finddevices();
assert(length(devices) == 1);
device = devices(1);
assert(device.DeviceId == 50419);
assert(device.FirmwareVersion == 6.25);
assert(strcmp(device.Flags, '--'));
assert(device.Units.Resolution == 1);
assert(39 < device.Units.ForceUnitScale);
assert(device.Units.ForceUnitScale < 40);
assert(device.IsAxis);
assert(isempty(device.Axes));
assert(isempty(device.IO));

%% Test find devices with two responses.
port = MockPort();
port.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE NC 20031\r\n@02 0 OK IDLE -- 30222\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- 6.18\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get resolution', []), sprintf('@01 0 OK IDLE -- 32\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE -- 0 0 0 0\r\n'));
port.expect(Zaber.AsciiMessage(2, 'get version', []), sprintf('@02 0 OK IDLE -- 6.24\r\n'));
port.expect(Zaber.AsciiMessage(2, 'get system.axiscount', []), sprintf('@02 0 OK IDLE -- 2\r\n'));
port.expect(Zaber.AsciiMessage(2, 'get peripheralid', [], 'AxisNo', 1), sprintf('@02 1 OK IDLE -- 44122\r\n'));
port.expect(Zaber.AsciiMessage(2, 'get peripheralid', [], 'AxisNo', 2), sprintf('@02 2 OK IDLE NC 44112\r\n'));
port.expect(Zaber.AsciiMessage(2, 'get resolution', [], 'AxisNo', 1), sprintf('@02 1 OK IDLE -- 64\r\n'));
port.expect(Zaber.AsciiMessage(2, 'get resolution', [], 'AxisNo', 2), sprintf('@02 2 OK IDLE -- 128\r\n'));
port.expect(Zaber.AsciiMessage(2, 'io info', []), sprintf('@01 0 OK IDLE -- 1 2 3 4\r\n'));
protocol = Zaber.AsciiProtocol(port);
devices = protocol.finddevices();
assert(length(devices) == 2);
device = devices(1);
assert(device.DeviceId == 20031);
assert(device.FirmwareVersion == 6.18);
assert(strcmp(device.Flags, '--'));
assert(isempty(device.IO));
device = devices(2);
assert(device.DeviceId == 30222);
assert(device.FirmwareVersion == 6.24);
assert(strcmp(device.Flags, '--'));
assert(~device.IsAxis);
assert(length(device.Axes) == 2);
assert(~isempty(device.IO));
assert(device.IO.AnalogOutputCount == 1);
assert(device.IO.AnalogInputCount == 2);
assert(device.IO.DigitalOutputCount == 3);
assert(device.IO.DigitalInputCount == 4);
axis = device.Axes(1);
assert(axis.DeviceNo == 2);
assert(axis.AxisNo == 1);
assert(isempty(axis.Axes));
assert(axis.Units.Resolution == 64);
assert(axis.PeripheralId == 44122);
axis = device.Axes(2);
assert(axis.DeviceNo == 2);
assert(axis.AxisNo == 2);
assert(isempty(axis.Axes));
assert(axis.Units.Resolution == 128);
assert(axis.PeripheralId == 44112);


%% Cleanup
clear all;

