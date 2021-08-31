function r = func_IsStMoving(h)
% Read StatusBits returned by GetStatusBits_Bits method and determine if
% the motor shaft is moving; Return 1 if moving, return 0 if stationary
s = h.GetStatusBits_Bits(0);
r = bitget(abs(s),5)||bitget(abs(s),6);
end
