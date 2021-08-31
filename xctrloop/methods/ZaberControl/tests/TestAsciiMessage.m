%% Test: Constructor intializes fields correctly with numeric data and non-defaults.
message = Zaber.AsciiMessage(1, 'foo', [ 1 2 ], 'AxisNo', 4, 'MessageId', 5);
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, 'foo'));
assert(isequal(message.Data, [ 1 2 ]));
assert(strcmp(message.DataString, '1 2'));
assert(message.MessageId == 5);
assert(message.AxisNo == 4);
assert(strcmp(message.Flags, ''));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Request);
assert(message.IsIdle);

%% Test: Constructor intializes fields correctly with string data.
message = Zaber.AsciiMessage(1, 'foo', '1 2');
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, 'foo'));
assert(isequal(message.Data, [ 1 2 ]));
assert(strcmp(message.DataString, '1 2'));
assert(isequal(message.MessageId, -1));
assert(message.AxisNo == 0);
assert(strcmp(message.Flags, ''));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Request);
assert(message.IsIdle);

%% Test: Constructor intializes fields correctly with no data.
message = Zaber.AsciiMessage(1, 'foo', []);
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, 'foo'));
assert(isequal(message.Data, [ ]));
assert(strcmp(message.DataString, ''));
assert(isequal(message.MessageId, -1));
assert(message.AxisNo == 0);
assert(strcmp(message.Flags, ''));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Request);
assert(message.IsIdle);

%% Test: Serialize
message = Zaber.AsciiMessage(1, 'foo', 2);
s = native2unicode(message.serialize());
assert(strcmp(s, sprintf('/1 0 foo 2\r\n')));

%% Test: Serialize with no data
message = Zaber.AsciiMessage(1, 'foo', []);
s = native2unicode(message.serialize());
assert(strcmp(s, sprintf('/1 0 foo\r\n')));

%% Test: Serialize with message ID
message = Zaber.AsciiMessage(1, 'foo', [ 2 3 ], 'AxisNo', 4, 'MessageId', 5);
s = native2unicode(message.serialize());
assert(strcmp(s, sprintf('/1 4 5 foo 2 3\r\n')));

%% Test: Serialize with checksum
message = Zaber.AsciiMessage(1, 'foo', 2);
s = native2unicode(message.serialize(true));
assert(strcmp(s, sprintf('/1 0 foo 2:C9\r\n')));

%% Test: Deserialize request from string
message = Zaber.AsciiMessage.deserialize(sprintf('/1 3 foo 2\r\n'));
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, 'foo'));
assert(message.Data == 2);
assert(strcmp(message.DataString, '2'));
assert(message.MessageId == -1);
assert(message.AxisNo == 3);
assert(strcmp(message.Flags, ''));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Request);
assert(message.IsIdle);

%% Test: Deserialize response from string
message = Zaber.AsciiMessage.deserialize(sprintf('@1 3 OK IDLE -- 7 3 4\r\n'));
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, ''));
assert(isequal(message.Data, [7 3 4]));
assert(strcmp(message.DataString, '7 3 4'));
assert(message.MessageId == -1);
assert(message.AxisNo == 3);
assert(strcmp(message.Flags, '--'));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Response);
assert(message.IsIdle);

%% Test: Deserialize response from byte array
message = Zaber.AsciiMessage.deserialize(unicode2native(sprintf('@1 3 OK IDLE -- 0\r\n')));
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, ''));
assert(message.Data == 0);
assert(strcmp(message.DataString, '0'));
assert(message.MessageId == -1);
assert(message.AxisNo == 3);
assert(strcmp(message.Flags, '--'));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Response);
assert(message.IsIdle);

%% Test: Deserialize busy response from string
message = Zaber.AsciiMessage.deserialize(sprintf('@1 3 OK BUSY -- 0\r\n'));
assert(strcmp(message.Flags, '--'));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Response);
assert(~message.IsIdle);

%% Test: Deserialize error response from string
message = Zaber.AsciiMessage.deserialize(sprintf('@1 3 RJ IDLE WR AGAIN\r\n'));
assert(strcmp(message.Flags, 'WR'));
assert(message.IsError);
assert(message.MessageType == Zaber.MessageType.Response);
assert(message.IsIdle);
assert(strcmp(message.DataString, 'AGAIN'));

%% Test: Deserialize info message from string
message = Zaber.AsciiMessage.deserialize(sprintf('#1 3 foo 2 bar 4\r\n'));
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, ''));
assert(isequal(message.Data, [2 4]));
assert(strcmp(message.DataString, 'foo 2 bar 4'));
assert(message.MessageId == -1);
assert(message.AxisNo == 3);
assert(strcmp(message.Flags, ''));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Info);
assert(message.IsIdle);

%% Test: Deserialize alert message from string
message = Zaber.AsciiMessage.deserialize(sprintf('!1 3 BUSY --\r\n'));
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, ''));
assert(isempty(message.Data));
assert(strcmp(message.DataString, ''));
assert(message.MessageId == -1);
assert(message.AxisNo == 3);
assert(strcmp(message.Flags, '--'));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Alert);
assert(~message.IsIdle);

%% Test: Deserialize response with message ID and checksum
message = Zaber.AsciiMessage.deserialize(sprintf('@1 3 9 OK IDLE -- 0:61\r\n'));
assert(message.DeviceNo == 1);
assert(strcmp(message.Command, ''));
assert(message.Data == 0);
assert(strcmp(message.DataString, '0'));
assert(message.MessageId == 9);
assert(message.AxisNo == 3);
assert(strcmp(message.Flags, '--'));
assert(~message.IsError);
assert(message.MessageType == Zaber.MessageType.Response);
assert(message.IsIdle);

%% Test: Deserialize response with bad checksum
hadError = false;
try
    message = Zaber.AsciiMessage.deserialize(sprintf('@1 3 9 OK IDLE -- 0:60\r\n'));
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'checksum'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test: Deserialize truncated response
hadError = false;
try
    message = Zaber.AsciiMessage.deserialize(sprintf('@1 3 9 OK IDLE --'));
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'enough'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test: Deserialize response with bogus axis number
hadError = false;
try
    message = Zaber.AsciiMessage.deserialize(sprintf('@1 a OK IDLE -- 0\r\n'));
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'axis'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test: Deserialize response with bogus device number
hadError = false;
try
    message = Zaber.AsciiMessage.deserialize(sprintf('@x 1 OK IDLE -- 0\r\n'));
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'device'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test: Deserialize bogus message type
hadError = false;
try
    message = Zaber.AsciiMessage.deserialize(sprintf('Frumple!\r\n'));
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'Unrecognized'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');


%% Cleanup
clear all;
