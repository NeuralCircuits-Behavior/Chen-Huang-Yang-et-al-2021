%% Test binary protocol detection.
port = MockPort();
port.expect([ 0, 55, 47, 13, 10, 0 ], [ 1, 55, 47, 13, 10, 0, 0, 0 ]);
protocol = Zaber.Protocol.detect(port);
assert(isa(protocol, 'Zaber.BinaryProtocol'));
% Port should be flushed.
assert(port.BytesAvailable == 0);

%% Test ASCII protocol detection.
port = MockPort();
port.expect([ 0, 55, 47, 13, 10, 0 ], '@01 0 OK IDLE -- 0');
protocol = Zaber.Protocol.detect(port);
assert(isa(protocol, 'Zaber.AsciiProtocol'));
% Port should be flushed.
assert(port.BytesAvailable == 0);

%% Test failed protocol detection.
port = MockPort();
port.expect([ 0, 55, 47, 13, 10, 0 ], 'Chargoggagoggmanchauggagoggchaubunagungamaugg');
protocol = Zaber.Protocol.detect(port);
assert(~isa(protocol, 'Zaber.AsciiProtocol'));
assert(~isa(protocol, 'Zaber.BinaryProtocol'));
% Port should be flushed.
assert(port.BytesAvailable == 0);


%% Cleanup
clear all;
