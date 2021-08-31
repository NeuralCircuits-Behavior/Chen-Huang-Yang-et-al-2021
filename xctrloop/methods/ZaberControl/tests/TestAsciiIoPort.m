% Common test data
port = MockPort();
protocol = Zaber.AsciiProtocol(port);
port.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE -- 30222\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- 6.18\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 2\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 1), sprintf('@01 1 OK IDLE -- 44122\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 2), sprintf('@01 2 OK IDLE -- 44112\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get resolution', [], 'AxisNo', 1), sprintf('@01 1 OK IDLE -- 64\r\n'));
port.expect(Zaber.AsciiMessage(1, 'get resolution', [], 'AxisNo', 2), sprintf('@01 2 OK IDLE -- 64\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE -- 1 2 3 4\r\n'));
device = protocol.finddevices();
io = device.IO;

%% Test detection.
assert(~isempty(io));
assert(io.AnalogOutputCount == 1);
assert(io.AnalogInputCount == 2);
assert(io.DigitalOutputCount == 3);
assert(io.DigitalInputCount == 4);

%% Test reading analog inputs.
port.expect(Zaber.AsciiMessage(1, 'io get ai', 1), sprintf('@01 0 OK IDLE -- 7.5\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get ai', 2), sprintf('@01 0 OK IDLE -- 8.5\r\n'));
val = io.readanaloginput(1);
assert(val == 7.5);
val = io.readanaloginput(2);
assert(val == 8.5);

% Analog outputs not tested because no devices currently support them.

%% Test reading single digital inputs.
port.expect(Zaber.AsciiMessage(1, 'io get di', 1), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get di', 2), sprintf('@01 0 OK IDLE -- 1\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get di', 3), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get di', 4), sprintf('@01 0 OK IDLE -- 1\r\n'));
val = io.readdigitalinput(1);
assert(val == 0);
val = io.readdigitalinput(2);
assert(val == 1);
val = io.readdigitalinput(3);
assert(val == 0);
val = io.readdigitalinput(4);
assert(val == 1);

%% Test bulk reading digital inputs.
port.expect(Zaber.AsciiMessage(1, 'io get di', []), sprintf('@01 0 OK IDLE -- 0 1 0 1\r\n'));
val = io.readdigitalinput();
assert(isequal(val, [0, 1, 0, 1]));

%% Test writing single digital outputs.
port.expect(Zaber.AsciiMessage(1, 'io set do', [1, 1]), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io set do', [2, 0]), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io set do', [3, 1]), sprintf('@01 0 OK IDLE -- 0\r\n'));
io.writedigitaloutput(1, 1);
io.writedigitaloutput(2, 0);
io.writedigitaloutput(3, 1);

%% Test bulk writing digital outputs.
port.expect(Zaber.AsciiMessage(1, 'io set do port', [1, 0, 1]), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io set do port', [0, 1, 0]), sprintf('@01 0 OK IDLE -- 0\r\n'));
io.writedigitaloutput(1, [1, 0, 1]);
io.writedigitaloutput(2, [1, 0, 1]);

%% Test reading single digital outputs.
port.expect(Zaber.AsciiMessage(1, 'io get do', 1), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get do', 2), sprintf('@01 0 OK IDLE -- 1\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get do', 3), sprintf('@01 0 OK IDLE -- 0\r\n'));
port.expect(Zaber.AsciiMessage(1, 'io get do', 4), sprintf('@01 0 OK IDLE -- 1\r\n'));
val = io.readdigitaloutput(1);
assert(val == 0);
val = io.readdigitaloutput(2);
assert(val == 1);
val = io.readdigitaloutput(3);
assert(val == 0);
val = io.readdigitaloutput(4);
assert(val == 1);

%% Test bulk reading digital outputs.
port.expect(Zaber.AsciiMessage(1, 'io get do', []), sprintf('@01 0 OK IDLE -- 0 1 0 1\r\n'));
val = io.readdigitaloutput();
assert(isequal(val, [0, 1, 0, 1]));


%% Cleanup
clear all;
