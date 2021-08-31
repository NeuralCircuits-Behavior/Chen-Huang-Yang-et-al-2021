classdef BinaryStatusType < uint8
%   BINARYSTATUSTYPE Enumeration to assist interpreting Zaber Binary protocol codes.
%   This enumeration represents documented values of the code returned by
%   the Binary protocol Return Status (54) command. For more information,
%   see the documentation for that command:
%   http://www.zaber.com/wiki/Manuals/Binary_Protocol_Manual#Return_Status_-_Cmd_54 
 
%   Author: Zaber Technologies Software Team <contact@zaber.com>

    enumeration
        Idle                        (0),
        Moving_to_Home              (1),
        Manual_Velocity_Move        (10),
        Manual_Move                 (11),
        Stalled_or_Displaced        (13),
        Moving_to_Stored_Position   (18), 
        Moving_to_Absolute_Position (20),
        Moving_to_Relative_Position (21),
        Moving_at_Velocity          (22),
        Stopping                    (23),
        Parked                      (65),
        Moving_to_Index             (78)
    end
end
