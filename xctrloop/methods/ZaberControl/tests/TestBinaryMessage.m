% Test data
packet = [ 1 2 6 5 4 3 ];
packetWithId = [ 1 2 5 4 3 7 ];
packetWithNegative = [ 1 2 255 255 255 255 ];

% Preconditions

%% Test: Constructor initializes fields correctly without message ID.
message = Zaber.BinaryMessage(1, 2, 50595078); % 50595078 = 0x03040506
assert(message.DeviceNo == 1);
assert(message.Command == 2);
assert(message.Data == 50595078);
assert(message.MessageId == 0);
assert(~message.IsError);

%% Test: Constructor initializes fields correctly with message ID.
message = Zaber.BinaryMessage(1, 2, 197637, 7); % 197637 = 0X030405
assert(message.DeviceNo == 1);
assert(message.Command == 2);
assert(message.Data == 197637);
assert(message.MessageId == 7);
assert(~message.IsError);

%% Test: Serialize 
message = Zaber.BinaryMessage(1, 2, 50595078);
bytes = message.serialize();
assert(isequal(packet, bytes));
assert(~message.IsError);

%% Test: Serialize with message ID
message = Zaber.BinaryMessage(1, 2, 197637, 7);
bytes = message.serialize();
assert(isequal(packetWithId, bytes));

%% Test: Serialize negative value
message = Zaber.BinaryMessage(1, 2, -1);
bytes = message.serialize();
assert(isequal(packetWithNegative, bytes));

%% Test: Serialize value that will be truncated for message ID
message = Zaber.BinaryMessage(1, 2, 50595078, 7);
hadError = false;
try
    bytes = message.serialize();
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'cannot be represented'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test: Deserialize 
message = Zaber.BinaryMessage.deserialize(packet);
assert(message.DeviceNo == 1);
assert(message.Command == 2);
assert(message.Data == 50595078);
assert(message.MessageId == 0);
assert(~message.IsError);

%% Test: Deserialize with message ID
message = Zaber.BinaryMessage.deserialize(packetWithId, true);
assert(message.DeviceNo == 1);
assert(message.Command == 2);
assert(message.Data == 197637);
assert(message.MessageId == 7);
assert(~message.IsError);

%% Test: Deserialize negative value
message = Zaber.BinaryMessage.deserialize(packetWithNegative);
assert(message.DeviceNo == 1);
assert(message.Command == 2);
assert(message.Data == -1);
assert(message.MessageId == 0);
assert(~message.IsError);

%% Test: Deserialize negative value with message ID
message = Zaber.BinaryMessage.deserialize(packetWithNegative, true);
assert(message.DeviceNo == 1);
assert(message.Command == 2);
assert(message.Data == -1);
assert(message.MessageId == 255);
assert(~message.IsError);

%% Test: Deserialize error response
errorPacket = [ 1 255 3 4 5 6 ];
message = Zaber.BinaryMessage.deserialize(errorPacket);
assert(message.IsError);

%% Test: Deserialize with wrong packet sizes
shortPacket = [ 1 2 3 4 5 ];
longPacket = [ packet 8];
hadError = false;
try
    message = Zaber.BinaryMessage.deserialize(shortPacket);
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, '6 bytes'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

hadError = false;
try
    message = Zaber.BinaryMessage.deserialize(longPacket);
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, '6 bytes'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');

%% Test: Deserialize with bogus data
wrongPacket = [ 1.0 -2 400 4 5 6 ];
hadError = false;
try
    message = Zaber.BinaryMessage.deserialize(wrongPacket);
catch e
    text = getReport(e);
    assert(~isequal(strfind(text, 'representable as bytes'), []));
    hadError = true;
end
assert(hadError, 'An exception was expected');


%% Cleanup
clear all;
