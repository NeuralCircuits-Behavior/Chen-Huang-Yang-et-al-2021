classdef MotionType < int32
%   MOTIONTYPE Enumeration for identifying the movement type of a Zaber
%   device.
%
%   The motion type can be used to determine which units of measure are
%   appropriate for movement commands and position measurements.
%
%   Linear - For straight stages and X-Y stages. Length units.
%   Rotary - Rotating stages. Angle units.
%   Tangential - Stages where a linear and rotary mechanisms are coupled
%                in a nonlinear way. Unit conversions are not available
%                for these because the conversion factor depends on the
%                current position.
%   None   - The device cannot move on its own. For example, standalone
%            controllers and joysticks.
%   Other  - Cases not covered above. For future compatibility.
%
%   See also Zaber.Device.MotionType
 
%   Author: Zaber Technologies Software Team <contact@zaber.com>

   enumeration
      None       (0),
      Linear     (1),
      Rotary     (2),
      Tangential (3),
      Other      (9)
   end
end