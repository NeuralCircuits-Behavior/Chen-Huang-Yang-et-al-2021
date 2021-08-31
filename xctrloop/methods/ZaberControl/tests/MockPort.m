 %   MOCKPORT Port mock for testing purposes.
 %   This is not part of the Zaber toolbox or examples; it is just used by
 %   the tests for the library.
 %
 %   This class overrides the behavior of the MATLAB port class in order to
 %   facilitate testing; no actual port is harmed during the running of
 %   tests. Instead the MockPort uses a script that lists messages it
 %   should expect to see sent, and fake responses to provide in return.
 %
 %   This works by using MATLAB's ability to override methods invoked
 %   through functional notation the same was as object notation. That is,
 %   'foo(obj)' is treated as 'obj.foo()' if the type of 'obj' happens to
 %   have a method that matches the needed signature of 'foo'.
 
 classdef MockPort < handle
    
    properties
        BytesAvailable;
        
        ReceiveBuffer;
        
        Expectations;
    end
    
    methods
        
        function obj = MockPort()
            obj.ReceiveBuffer = [];
            obj.Expectations = [];
        end
        
        
        function expect(obj, aExpectation, aResponse)
            e = aExpectation;

            if (isa(e, 'Zaber.BinaryMessage') || isa(e, 'Zaber.AsciiMessage'))
                e = e.serialize();
            end

            if (isa(e, 'char'))
                e = unicode2native(e);
            end
            
            r = aResponse;

            if (isa(r, 'Zaber.BinaryMessage') || isa(r, 'Zaber.AsciiMessage'))
                r = r.serialize();
            end

            if (isa(r, 'char'))
                r = unicode2native(r);
            end
            
            obj.Expectations = [obj.Expectations ; {e r}];
        end
        
        function flushinput(obj)
            obj.ReceiveBuffer = [];
        end
        
        
        function fwrite(obj, aBytes, aPrecision)
            if (isempty(obj.Expectations))
                error('Zaber:MockPort:fwrite:unexpectedCall', ...
                      'Received an unexpected fwrite call with %s | %s.', ... 
                      mat2str(aBytes), native2unicode(aBytes));
            end
            
            next = obj.Expectations(1,:);
            
            sz = size(obj.Expectations);
            if (sz(1) > 1)
                obj.Expectations = obj.Expectations(2:end,:);
            else
                obj.Expectations = [];
            end
            
            if (~isequal(aBytes, next{1}))
                error('Zaber:MockPort:fwrite:wrongData', ...
                      'Expected: %s | %s\nbut got: %s | %s', ...
                      mat2str(next{1}), native2unicode(next{1}), ...
                      mat2str(aBytes), native2unicode(aBytes));
            end
            
            obj.ReceiveBuffer = [obj.ReceiveBuffer next{2}];
        end
        
        
        function bytes = fread(obj, aCount, aPrecision)
            if (length(obj.ReceiveBuffer) < aCount)
                bytes = obj.ReceiveBuffer;
                obj.ReceiveBuffer = [];
            else
                bytes = obj.ReceiveBuffer(1:aCount)';
                obj.ReceiveBuffer = obj.ReceiveBuffer(1+aCount:end);
            end
        end
        
        
        function available = get.BytesAvailable(obj)
            available = length(obj.ReceiveBuffer);
        end
        
        
        function text = fgetl(obj)
            index = 1;
            found = false;
            c = '';
            while (~found && (index <= length(obj.ReceiveBuffer)))
                c = obj.ReceiveBuffer(index);
                if ((c == 10) || (c == 13))
                    found = true;
                else
                    index = index + 1;
                end
            end
            
            if (found)
                text = obj.ReceiveBuffer(1:index - 1);
            else
                text = [];
            end
            
            while (~isempty(c) && ((c == 10) || (c == 13)))
                index = index + 1;
                c = '';
                if (index <= length(obj.ReceiveBuffer))
                    c = obj.ReceiveBuffer(index);
                end
            end
            
            obj.ReceiveBuffer = obj.ReceiveBuffer(index:end);
        end
    end
    
end

