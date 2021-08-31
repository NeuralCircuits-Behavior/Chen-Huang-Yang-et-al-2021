% Common test data
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
device = AsciiDeviceWrapper(protocol, 1, 30222);

%% Test constructor.
assert(isequal(device.Protocol, protocol));
assert(device.DeviceNo == 1);
assert(device.DeviceId == 30222);

%% Test request method with empty command and data.
port.expect(sprintf('/1 0\r\n'), sprintf('@01 0 OK IDLE -- 0\r\n'));
device.request('', []);
assert(strcmp(device.Flags, '--'));

%% Test request method with string and empty data.
port.expect(sprintf('/1 0 foo\r\n'), sprintf('@01 0 OK IDLE NI 0\r\n'));
device.request('foo', []);
assert(strcmp(device.Flags, 'NI'));

%% Test request method with string and single numeric data element.
port.expect(sprintf('/1 0 foo 123\r\n'), sprintf('@01 0 OK IDLE NC 0\r\n'));
device.request('foo', 123);
assert(strcmp(device.Flags, 'NC'));

%% Test request method with string and single string data element.
port.expect(sprintf('/1 0 foo 123\r\n'), sprintf('@01 0 OK IDLE FB 0\r\n'));
device.request('foo', '123');
assert(strcmp(device.Flags, 'FB'));

%% Test request method with string and number array data argument.
port.expect(sprintf('/1 0 foo 123 456\r\n'), sprintf('@01 0 OK IDLE BL 0\r\n'));
device.request('foo', [123, 456]);
assert(strcmp(device.Flags, 'BL'));

%% Test request method with string and string array data argument.
port.expect(sprintf('/1 0 foo 123 456\r\n'), sprintf('@01 0 OK IDLE NP 0\r\n'));
device.request('foo', ['123'; '456']); % Must be column vector to prevent auto join.
assert(strcmp(device.Flags, 'NP'));

%% Test get method with single numeric value in reply.
port.expect(sprintf('/1 0 get foo\r\n'), sprintf('@01 0 OK IDLE -- 789\r\n'));
val = device.get('foo');
assert(val == 789);
assert(strcmp(device.Flags, '--'));

%% Test get method with multiple numeric values in reply.
port.expect(sprintf('/1 0 get foo\r\n'), sprintf('@01 0 OK IDLE -- 789 123\r\n'));
val = device.get('foo');
assert(isequal(val, [789, 123]));
assert(strcmp(device.Flags, '--'));

%% Test get method with string values in reply.
port.expect(sprintf('/1 0 get foo\r\n'), sprintf('@01 0 OK IDLE -- lorem ipsum\r\n'));
val = device.get('foo');
assert(strcmp(val, 'lorem ipsum'));
assert(strcmp(device.Flags, '--'));

%% Test get method with mixed string and numeric values in reply.
port.expect(sprintf('/1 0 get foo\r\n'), sprintf('@01 0 OK IDLE -- lorem 123 ipsum 456\r\n'));
val = device.get('foo');
assert(isequal(val, [123, 456]));
assert(strcmp(device.Flags, '--'));

%% Test set method with numeric data.
port.expect(sprintf('/1 0 set foo 123\r\n'), sprintf('@01 0 OK IDLE WR 00\r\n'));
val = device.set('foo', 123);
assert(val);
assert(strcmp(device.Flags, 'WR'));

%% Test set method with string data.
port.expect(sprintf('/1 0 set foo abc\r\n'), sprintf('@01 0 OK IDLE NC 00\r\n'));
val = device.set('foo', 'abc');
assert(val);
assert(strcmp(device.Flags, 'NC'));

%% Test set method handling of errors.
warning off 'Zaber:BinaryDevice:set:writeError'
port.expect(sprintf('/1 0 set foo 123\r\n'), sprintf('@01 0 RJ IDLE -- BADDATA\r\n'));
val = device.set('foo', 123);
assert(strcmp(val, 'BADDATA'));
assert(strcmp(device.Flags, '--'));
[warnStr warnId] = lastwarn;
assert(strcmp(warnId, 'Zaber:BinaryDevice:set:writeError'));
warning on 'Zaber:BinaryDevice:set:writeError'

%% Test getrange on rotary stage with new firmware.
AsciiDeviceWrapper.setupRotaryExpectations(port, 6.20);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Rotary);
port.expect(sprintf('/1 0 get limit.min\r\n'), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(sprintf('/1 0 get limit.cycle.dist\r\n'), sprintf('@01 0 OK IDLE -- 1000000\r\n'));
range = device.getrange();
assert(isequal(range, [0, 1000000]));

%% Test getrange on rotary stage with old firmware.
AsciiDeviceWrapper.setupRotaryExpectations(port, 6.19);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Rotary);
port.expect(sprintf('/1 0 get limit.min\r\n'), sprintf('@01 0 OK IDLE -- 1000\r\n'));
port.expect(sprintf('/1 0 get limit.max\r\n'), sprintf('@01 0 OK IDLE -- 1000000\r\n'));
range = device.getrange();
assert(isequal(range, [1000, 1000000]));

%% Test getrange on linear stage with old firmware.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Linear);
port.expect(sprintf('/1 0 get limit.min\r\n'), sprintf('@01 0 OK IDLE -- 1000\r\n'));
port.expect(sprintf('/1 0 get limit.max\r\n'), sprintf('@01 0 OK IDLE -- 1000000\r\n'));
range = device.getrange();
assert(isequal(range, [1000, 1000000]));

%% Test home and waitforidle.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect(sprintf('/1 0 home\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 0\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 0\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 0\r\n'), sprintf('@01 0 OK IDLE -- 0\r\n'));
result = device.home();
assert(isempty(result));
device.waitforidle();
assert(port.BytesAvailable == 0);

%% Test home response to error.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 home\r\n'), sprintf('@01 0 RJ IDLE -- BADCOMMAND\r\n'));
result = device.home();
assert(strcmp(result, 'BADCOMMAND'));

%% Test move absolute with one axis.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move abs 10000\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
result = device.moveabsolute(10000);
assert(isempty(result));

%% Test move absolute error response
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move abs 10000\r\n'), sprintf('@01 0 RJ BUSY -- BADCOMMAND\r\n'));
result = device.moveabsolute(10000);
assert(strcmp(result, 'BADCOMMAND'));

%% Test move absolute with two axes.
AsciiDeviceWrapper.setupXyExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 1 move abs 10000\r\n'), sprintf('@01 1 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 2 move abs 20000\r\n'), sprintf('@01 2 OK BUSY -- 0\r\n'));
result = device.moveabsolute([10000, 20000]);
assert(isempty(result));

%% Test move relative with one axis.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move rel 10000\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
result = device.moverelative(10000);
assert(isempty(result));

%% Test move relative error response
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move rel 10000\r\n'), sprintf('@01 0 RJ BUSY -- BADCOMMAND\r\n'));
result = device.moverelative(10000);
assert(strcmp(result, 'BADCOMMAND'));

%% Test move relative with two axes.
AsciiDeviceWrapper.setupXyExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 1 move rel 10000\r\n'), sprintf('@01 1 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 2 move rel 20000\r\n'), sprintf('@01 2 OK BUSY -- 0\r\n'));
result = device.moverelative([10000, 20000]);
assert(isempty(result));

%% Test move at velocity with one axis.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move vel 10000\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
result = device.moveatvelocity(10000);
assert(isempty(result));

%% Test move at velocity error response
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move vel 10000\r\n'), sprintf('@01 0 RJ BUSY -- BADCOMMAND\r\n'));
result = device.moveatvelocity(10000);
assert(strcmp(result, 'BADCOMMAND'));

%% Test move at velocity with two axes.
AsciiDeviceWrapper.setupXyExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 1 move vel 10000\r\n'), sprintf('@01 1 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 2 move vel 20000\r\n'), sprintf('@01 2 OK BUSY -- 0\r\n'));
result = device.moveatvelocity([10000, 20000]);
assert(isempty(result));

%% Test stop with one axis.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 stop\r\n'), sprintf('@01 0 OK IDLE -- 0\r\n'));
result = device.stop();
assert(isempty(result));

%% Test stop error response
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 stop\r\n'), sprintf('@01 0 RJ BUSY -- BADCOMMAND\r\n'));
result = device.stop();
assert(strcmp(result, 'BADCOMMAND'));

%% Test stop on an individual axis.
AsciiDeviceWrapper.setupXyExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 2 stop\r\n'), sprintf('@01 2 OK BUSY -- 0\r\n'));
result = device.Axes(2).stop();
assert(isempty(result));

%% Test get position.
port.expect(sprintf('/1 0 get pos\r\n'), sprintf('@01 0 OK IDLE -- 12345\r\n'));
val = device.getposition();
assert(val == 12345);

%% Test get position with multiple axes.
port.expect(sprintf('/1 0 get pos\r\n'), sprintf('@01 0 OK IDLE -- 12345 23456\r\n'));
val = device.getposition();
assert(isequal(val, [12345, 23456]));

%% Test num indices on a device that has a cycle size.
port.expect(sprintf('/1 0 get limit.cycle.dist\r\n'), sprintf('@01 0 OK IDLE -- 50000\r\n'));
port.expect(sprintf('/1 0 get motion.index.dist\r\n'), sprintf('@01 0 OK IDLE -- 5000\r\n'));
val = device.getnumindices();
assert(val == 10);

%% Test num indices on a device that does not have a cycle size.
port.expect(sprintf('/1 0 get limit.cycle.dist\r\n'), sprintf('@01 0 RJ IDLE -- BADCOMMAND\r\n'));
port.expect(sprintf('/1 0 get limit.max.dist\r\n'), sprintf('@01 0 OK IDLE -- 50000\r\n'));
port.expect(sprintf('/1 0 get motion.index.dist\r\n'), sprintf('@01 0 OK IDLE -- 5000\r\n'));
val = device.getnumindices();
assert(val == 10);

%% Test move indexed with one axis.
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move index 5\r\n'), sprintf('@01 0 OK BUSY -- 0\r\n'));
result = device.moveindexed(5);
assert(isempty(result));

%% Test move relative error response
AsciiDeviceWrapper.setupLinearExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 0 move index 5\r\n'), sprintf('@01 0 RJ BUSY -- BADCOMMAND\r\n'));
result = device.moveindexed(5);
assert(strcmp(result, 'BADCOMMAND'));

%% Test move relative with two axes.
AsciiDeviceWrapper.setupXyExpectations(port, 6.18);
device = protocol.finddevices();
port.expect(sprintf('/1 1 move index 4\r\n'), sprintf('@01 1 OK BUSY -- 0\r\n'));
port.expect(sprintf('/1 2 move index 5\r\n'), sprintf('@01 2 OK BUSY -- 0\r\n'));
result = device.moveindexed([4, 5]);
assert(isempty(result));


%% Cleanup
clear all;
