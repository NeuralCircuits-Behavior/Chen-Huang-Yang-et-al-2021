% Common test data
port = MockPort();
protocol = Zaber.BinaryProtocol(port);
port.expect([ 0 50 0 0 0 0 ], [ 1 50 185 195 0 0 ]);
port.expect([ 1 51 0 0 0 0 ], [ 1 51 112 2 0 0 ]);
port.expect([ 1 53 102 0 0 0 ], [ 1 102 0 0 0 0 ]); % Mode
port.expect([ 1 53 66 0 0 0 ], [ 1 255 36 0 0 0 ]); % Peripheral ID
port.expect([ 1 53 37 0 0 0 ], [ 1 37 64 0 0 0 ]); % Resolution
port.expect([ 1 77 0 0 0 0 ], [ 1 77 1 0 0 0 ]); % Analog output count.
port.expect([ 1 75 0 0 0 0 ], [ 1 75 2 0 0 0 ]); % Analog input count.
port.expect([ 1 70 0 0 0 0 ], [ 1 70 3 0 0 0 ]); % Digital output count.
port.expect([ 1 67 0 0 0 0 ], [ 1 67 4 0 0 0 ]); % Digital input count.
device = protocol.finddevices();
io = device.IO;

%% Test detection.
assert(~isempty(io));
assert(io.AnalogOutputCount == 1);
assert(io.AnalogInputCount == 2);
assert(io.DigitalOutputCount == 3);
assert(io.DigitalInputCount == 4);

%% Test reading analog inputs.
port.expect([ 1 76 1 0 0 0], [1 76 248 36 1 0]);
port.expect([ 1 76 2 0 0 0], [1 76 8 76 1 0]);
val = io.readanaloginput(1);
assert(val == 7.5);
val = io.readanaloginput(2);
assert(val == 8.5);

% Analog outputs not tested because no devices currently support them.

%% Test reading single digital inputs.
port.expect([ 1 68 1 0 0 0], [1 68 0 0 0 0]);
port.expect([ 1 68 2 0 0 0], [1 68 1 0 0 0]);
port.expect([ 1 68 3 0 0 0], [1 68 0 0 0 0]);
port.expect([ 1 68 4 0 0 0], [1 68 1 0 0 0]);
val = io.readdigitalinput(1);
assert(val == 0);
val = io.readdigitalinput(2);
assert(val == 1);
val = io.readdigitalinput(3);
assert(val == 0);
val = io.readdigitalinput(4);
assert(val == 1);

%% Test bulk reading digital inputs.
port.expect([ 1 69 0 0 0 0], [1 69 10 0 0 0]);
val = io.readdigitalinput();
assert(isequal(val, [0, 1, 0, 1]));

%% Test writing single digital outputs.
port.expect([ 1 73 3 0 0 0], [1 73 3 0 0 0]);
port.expect([ 1 73 4 0 0 0], [1 73 4 0 0 0]);
port.expect([ 1 73 7 0 0 0], [1 73 7 0 0 0]);
io.writedigitaloutput(1, 1);
io.writedigitaloutput(2, 0);
io.writedigitaloutput(3, 1);

%% Test bulk writing digital outputs.
port.expect([ 1 74 5 0 0 0], [1 74 5 0 0 0]);
port.expect([ 1 73 5 0 0 0], [1 73 5 0 0 0]);
port.expect([ 1 73 6 0 0 0], [1 73 6 0 0 0]);
io.writedigitaloutput(1, [1, 0, 1]);
io.writedigitaloutput(2, [1, 0, 1]);

%% Test reading single digital outputs.
port.expect([ 1 71 1 0 0 0], [1 71 1 0 0 0]);
port.expect([ 1 71 2 0 0 0], [1 71 0 0 0 0]);
port.expect([ 1 71 3 0 0 0], [1 71 1 0 0 0]);
val = io.readdigitaloutput(1);
assert(val == 1);
val = io.readdigitaloutput(2);
assert(val == 0);
val = io.readdigitaloutput(3);
assert(val == 1);

%% Test bulk reading digital outputs.
port.expect([ 1 72 0 0 0 0], [1 72 5 0 0 0]);
val = io.readdigitaloutput();
assert(isequal(val, [1, 0, 1]));


%% Cleanup
clear all;
