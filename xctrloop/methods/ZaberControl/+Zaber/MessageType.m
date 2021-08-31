classdef MessageType
%   MESSAGETYPE Enumeration for identifying the type of a Zaber device
%   message. Binary messages are either requests or responses. ASCII
%   messages can be request, responses, info messages or alerts. For more
%   information on ASCII message types, see the Zaber ASCII protocol
%   manual: http://www.zaber.com/wiki/Manuals/ASCII_Protocol_Manual#Message_Format
%
%   See also Zaber.AsciiMessage, Zaber.BinaryMessage
 
%   Author: Zaber Technologies Software Team <contact@zaber.com>

   enumeration
      Invalid, Request, Response, Info, Alert
   end
end