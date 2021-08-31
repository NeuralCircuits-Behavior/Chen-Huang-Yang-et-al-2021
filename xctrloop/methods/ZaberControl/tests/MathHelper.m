classdef MathHelper
    %MATHHELPER Helper class for tests.
    %   Provides math-related utility functions for tests.
    
    methods (Static)
        function result = issimilar(a, b, tolerance)
        %% Test for equality of two floats within a tolerance range. 
        %% Default tolerance is the floating point epsilon of the smaller value.
        %% If the tolerance input is given, it's a maximum absolute difference.
            tol = eps(min(abs(a), abs(b)));
            if (nargin > 2)
                tol = tolerance;
            end

            result = (abs(a - b) <= tol);
        end
    end
end

