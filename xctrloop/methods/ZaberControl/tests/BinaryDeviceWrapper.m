classdef BinaryDeviceWrapper < Zaber.BinaryDevice
%BINARYDEVICEWRAPPER Wrapper to expose protected methods for testing.
    
    methods
        function obj = BinaryDeviceWrapper(aProtocol, aDeviceNumber, aDeviceId)
            obj = obj@Zaber.BinaryDevice(aProtocol, aDeviceNumber, aDeviceId);
        end
    end
    
    methods (Static)
        function setupRotaryExpectations(aPort, aFirmwareVersion)
        % Test helper - sets up port expectations for a rotary device.
            aPort.expect([ 0 50 0 0 0 0 ], [ 1 50 81 195 0 0 ]);
            fwv = 100 * aFirmwareVersion;
            aPort.expect([ 1 51 0 0 0 0 ], [ 1 51 uint8(fwv - 256 * floor(fwv / 256)) uint8(floor(fwv / 256)) 0 0 ]);
            if (aFirmwareVersion < 6.0)
                aPort.expect([ 1 53 40 0 0 0 ], [ 1 40 0 0 0 0 ]); % Mode
            else
                aPort.expect([ 1 53 102 0 0 0 ], [ 1 102 0 0 0 0 ]); % Mode
            end
            aPort.expect([ 1 53 66 0 0 0 ], [ 1 255 36 0 0 0 ]); % Peripheral ID
            aPort.expect([ 1 53 37 0 0 0 ], [ 1 37 64 0 0 0 ]); % Resolution
            aPort.expect([ 1 77 0 0 0 0 ], [ 1 77 0 0 0 0 ]); % Analog output count.
            aPort.expect([ 1 75 0 0 0 0 ], [ 1 75 0 0 0 0 ]); % Analog input count.
            aPort.expect([ 1 70 0 0 0 0 ], [ 1 70 0 0 0 0 ]); % Digital output count.
            aPort.expect([ 1 67 0 0 0 0 ], [ 1 67 0 0 0 0 ]); % Digital input count.
        end

        function setupLinearExpectations(aPort, aFirmwareVersion)
        % Test helper - sets up port expectations for a linear device.
            aPort.expect([ 0 50 0 0 0 0 ], [ 1 50 185 195 0 0 ]);
            fwv = 100 * aFirmwareVersion;
            aPort.expect([ 1 51 0 0 0 0 ], [ 1 51 uint8(fwv - 256 * floor(fwv / 256)) uint8(floor(fwv / 256)) 0 0 ]);
            if (aFirmwareVersion < 6.0)
                aPort.expect([ 1 53 40 0 0 0 ], [ 1 40 0 0 0 0 ]); % Mode
            else
                aPort.expect([ 1 53 102 0 0 0 ], [ 1 102 0 0 0 0 ]); % Mode
            end
            aPort.expect([ 1 53 66 0 0 0 ], [ 1 255 36 0 0 0 ]); % Peripheral ID
            aPort.expect([ 1 53 37 0 0 0 ], [ 1 37 64 0 0 0 ]); % Resolution
            aPort.expect([ 1 77 0 0 0 0 ], [ 1 77 0 0 0 0 ]); % Analog output count.
            aPort.expect([ 1 75 0 0 0 0 ], [ 1 75 0 0 0 0 ]); % Analog input count.
            aPort.expect([ 1 70 0 0 0 0 ], [ 1 70 0 0 0 0 ]); % Digital output count.
            aPort.expect([ 1 67 0 0 0 0 ], [ 1 67 0 0 0 0 ]); % Digital input count.
        end
    end
end

