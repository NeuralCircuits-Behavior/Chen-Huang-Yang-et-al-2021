classdef AsciiDeviceWrapper < Zaber.AsciiDevice
%ASCIIDEVICEWRAPPER Wrapper to expose protected methods for testing.
    
    methods
        function obj = AsciiDeviceWrapper(aProtocol, aDeviceNumber, aDeviceId)
            obj = obj@Zaber.AsciiDevice(aProtocol, aDeviceNumber, aDeviceId);
        end
    end
    
    methods (Static)
        
        function setupRotaryExpectations(aPort, aFirmwareVersion)
        % Support function for tests - sets up port expectations for a
        % rotary device.
            aPort.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE -- 50001\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- %f\r\n', aFirmwareVersion));
            aPort.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 1\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 1), sprintf('@01 0 RJ IDLE -- BADCOMMAND\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get resolution', []), sprintf('@01 0 OK IDLE -- 64\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE NC 0 0 0 0\r\n'));
        end

        function setupLinearExpectations(aPort, aFirmwareVersion)
            % Support function for tests - sets up port expectations for a
            % linear device.
            aPort.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE -- 50105\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- %f\r\n', aFirmwareVersion));
            aPort.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 1\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 1), sprintf('@01 0 RJ IDLE -- BADCOMMAND\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get resolution', []), sprintf('@01 0 OK IDLE -- 64\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE NC 0 0 0 0\r\n'));
        end

        function setupXyExpectations(aPort, aFirmwareVersion)
            % Support function for tests - sets up port expectations for a
            % two-axis linear device.
            aPort.expect(Zaber.AsciiMessage(0, 'get deviceid', []), sprintf('@01 0 OK IDLE -- 30222\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get version', []), sprintf('@01 0 OK IDLE -- %f\r\n', aFirmwareVersion));
            aPort.expect(Zaber.AsciiMessage(1, 'get system.axiscount', []), sprintf('@01 0 OK IDLE -- 2\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 1), sprintf('@01 1 OK IDLE -- 44122\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get peripheralid', [], 'AxisNo', 2), sprintf('@01 2 OK IDLE -- 44112\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get resolution', [], 'AxisNo', 1), sprintf('@01 1 OK IDLE -- 64\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'get resolution', [], 'AxisNo', 2), sprintf('@01 2 OK IDLE -- 64\r\n'));
            aPort.expect(Zaber.AsciiMessage(1, 'io info', []), sprintf('@01 0 OK IDLE NC 0 0 0 0\r\n'));
        end
    end
end

