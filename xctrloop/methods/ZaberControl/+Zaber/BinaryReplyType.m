%   BINARYREPLYTYPE Enumeration to assist with interpreting Zaber Binary protocol codes.

%   THIS IS A GENERATED FILE - DO NOT EDIT. See DeviceDatabaseUpdate.py.

classdef BinaryReplyType < uint8
    enumeration
        Error                (255),
        Limit_Active         (9),
        Manual_Move          (11),
        Manual_Move_Tracking (10),
        Move_Tracking        (8),
        Slip_Tracking        (12),
        Unexpected_Position  (13)
    end
end
