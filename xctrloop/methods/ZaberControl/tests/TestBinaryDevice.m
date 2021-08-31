% Common test data
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
device = BinaryDeviceWrapper(protocol, 1, 30222);

%% Test constructor.
assert(isequal(device.Protocol, protocol));
assert(device.DeviceNo == 1);
assert(device.DeviceId == 30222);

%% Test request method.
port.expect([1 50 0 0 0 0], [1 50 14 118 0 0 ]);
device.request(Zaber.BinaryCommandType.Return_Device_ID, 0);

%% Test get method.
port.expect([1 53 66 0 0 0], [1 66 80 172 0 0]);
val = device.get(Zaber.BinaryCommandType.Set_Peripheral_ID);
assert(val == 44112);

%% Test get method error handling.
warning off 'Zaber:BinaryDevice:get:readError'
port.expect([1 53 66 0 0 0], [1 255 25 0 0 0]);
val = device.get(Zaber.BinaryCommandType.Set_Peripheral_ID);
assert(isempty(val));
[warnStr warnId] = lastwarn;
assert(strcmp(warnId, 'Zaber:BinaryDevice:get:readError'));
warning on 'Zaber:BinaryDevice:get:readError'

%% Test get method handling wrong setting changed.
port.expect([1 53 66 0 0 0], [1 67 0 0 0 0]);
hadError = false;
try
    val = device.get(Zaber.BinaryCommandType.Set_Peripheral_ID);
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'wrong setting'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');


%% Test set method.
port.expect([1 66 80 172 0 0], [1 66 80 172 0 0]);
val = device.set(Zaber.BinaryCommandType.Set_Peripheral_ID, 44112);
assert(val);

%% Test set method handling of errors.
warning off 'Zaber:BinaryDevice:set:writeError'
port.expect([1 66 80 172 0 0], [1 255 5 0 0 0]);
val = device.set(Zaber.BinaryCommandType.Set_Peripheral_ID, 44112);
assert(~val);
[warnStr warnId] = lastwarn;
assert(strcmp(warnId, 'Zaber:BinaryDevice:set:writeError'));
warning on 'Zaber:BinaryDevice:set:writeError'

%% Test getrange on rotary stage with new firmware.
BinaryDeviceWrapper.setupRotaryExpectations(port, 6.22);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Rotary);
port.expect([ 1 53 106 0 0 0 ], [ 1 106 0 0 0 0]);
port.expect([ 1 53 80 0 0 0 ], [ 1 80 64 66 15 0]);
val = device.getrange();
assert(isequal(val, [0, 1000000]));

%% Test getrange on rotary stage with old firmware.
BinaryDeviceWrapper.setupRotaryExpectations(port, 6.21);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Rotary);
port.expect([ 1 53 106 0 0 0 ], [ 1 106 0 0 0 0]);
port.expect([ 1 53 44 0 0 0 ], [ 1 44 64 66 15 0]);
val = device.getrange();
assert(isequal(val, [0, 1000000]));

%% Test getrange on linear stage.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.24);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Linear);
port.expect([ 1 53 106 0 0 0 ], [ 1 106 0 0 0 0]);
port.expect([ 1 53 44 0 0 0 ], [ 1 44 64 66 15 0]);
val = device.getrange();
assert(isequal(val, [0, 1000000]));

%% Test waitforidle.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.24);
device = protocol.finddevices();
port.expect([ 1 54 0 0 0 0 ], [ 1 54 11 0 0 0]);
port.expect([ 1 54 0 0 0 0 ], [ 1 54 11 0 0 0]);
port.expect([ 1 54 0 0 0 0 ], [ 1 54 11 0 0 0]);
port.expect([ 1 54 0 0 0 0 ], [ 1 54 0 0 0 0]);
device.waitforidle();

%% Test home.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 1 0 0 0 0 ], [ 1 1 0 0 0 0]);
result = device.home();
assert(isempty(result));
assert(port.BytesAvailable == 0);

%% Test home response to error.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 1 0 0 0 0 ], [ 1 255 1 0 0 0]);
result = device.home();
assert(result == 1);
assert(port.BytesAvailable == 0);

%% Test move absolute.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 20 0 1 0 0 ], [ 1 20 0 1 0 0]);
result = device.moveabsolute(256);
assert(isempty(result));
assert(port.BytesAvailable == 0);

%% Test move absolute error response
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 20 0 1 0 0 ], [ 1 255 1 0 0 0]);
result = device.moveabsolute(256);
assert(result == 1);
assert(port.BytesAvailable == 0);

%% Test move relative.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 21 0 1 0 0 ], [ 1 21 0 1 0 0]);
result = device.moverelative(256);
assert(isempty(result));
assert(port.BytesAvailable == 0);

%% Test move relative error response
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 21 0 1 0 0 ], [ 1 255 1 0 0 0]);
result = device.moverelative(256);
assert(result == 1);
assert(port.BytesAvailable == 0);

%% Test move at velocity.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 22 0 1 0 0 ], [ 1 22 0 1 0 0]);
result = device.moveatvelocity(256);
assert(isempty(result));
assert(port.BytesAvailable == 0);

%% Test move at velocity error response
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 22 0 1 0 0 ], [ 1 255 1 0 0 0]);
result = device.moveatvelocity(256);
assert(result == 1);
assert(port.BytesAvailable == 0);

%% Test stop.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 23 0 0 0 0 ], [ 1 23 0 0 0 0]);
result = device.stop();
assert(isempty(result));
assert(port.BytesAvailable == 0);

%% Test stop error response
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 23 0 0 0 0 ], [ 1 255 1 0 0 0]);
result = device.stop();
assert(result == 1);
assert(port.BytesAvailable == 0);

%% Test get position.
port.expect([ 1 60 0 0 0 0 ], [ 1 60 0 1 0 0]);
val = device.getposition();
assert(val == 256);

%% Test get position error handling.
port.expect([ 1 60 0 0 0 0 ], [ 1 255 1 0 0 0]);
val = device.getposition();
assert(isempty(val));

%% Test num indices on a device that has a cycle size.
BinaryDeviceWrapper.setupRotaryExpectations(port, 6.22);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Rotary);
port.expect([ 1 53 106 0 0 0 ], [ 1 106 0 0 0 0]);
port.expect([ 1 53 80 0 0 0 ], [ 1 80 0 1 0 0]);
port.expect([ 1 53 79 0 0 0 ], [ 1 79 16 0 0 0]);
val = device.getnumindices();
assert(val == 16);

%% Test num indices on a device that does not have a cycle size.
BinaryDeviceWrapper.setupRotaryExpectations(port, 6.21);
device = protocol.finddevices();
assert(device.MotionType == Zaber.MotionType.Rotary);
port.expect([ 1 53 106 0 0 0 ], [ 1 106 0 0 0 0]);
port.expect([ 1 53 44 0 0 0 ], [ 1 44 0 1 0 0]);
port.expect([ 1 53 79 0 0 0 ], [ 1 79 16 0 0 0]);
val = device.getnumindices();
assert(val == 16);

%% Test move indexed.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 78 5 0 0 0 ], [ 1 78 5 0 0 0]);
result = device.moveindexed(5);
assert(isempty(result));

%% Test move indexed error handling.
BinaryDeviceWrapper.setupLinearExpectations(port, 6.19);
device = protocol.finddevices();
port.expect([ 1 78 5 0 0 0 ], [ 1 255 1 0 0 0]);
result = device.moveindexed(5);
assert(result == 1);
assert(port.BytesAvailable == 0);


%% Cleanup
clear all;


