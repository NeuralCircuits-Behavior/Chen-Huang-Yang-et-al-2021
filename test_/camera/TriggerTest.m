%% create video and source objects
vidObj = videoinput('pmimaq_1_0_20', 1, 'PM-Cam 1200x1200');
vsrcObj = getselectedsource(vidObj);

%% some general setting of camera 
vsrcObj.GainPortSpeed = 'P0S1: 100MHz, 16b, CMOS';
vsrcObj.Gain = 'Gain 1-HDR';
vsrcObj.Exposure = 100; % ms

%% connect to Arduino hardware
% arduino here is used to create external trigger signal
aObj = arduino();

%% hardware trigger setting 
vidObj.FramesPerTrigger = 1;
vidObj.TriggerRepeat = Inf; % this setting make start camera only need once 
triggerconfig(vidObj, 'hardware', 'First Row', 'Edge Trigger');
vsrcObj.TriggerMode = 'Edge Trigger';

%% obtain exclusive use of image acquisition device
start(vidObj);

%% trigger and capture
% use arduino to generate a ~50ms 5V pulse as trigger signal.
% Before open the camera, I already connected the arduino and the camera using
% the BNC breakout cable.
aObj.writeDigitalPin('D13',1);
pause(0.05);
aObj.writeDigitalPin('D13',0);

% get the triggered images
% NOTE: failed here, the camera is not logging, can use 
% >> islogging(vidObj) to confirm
im_captured = getdata(vidObj);

%% stop video input object
stop(vidObj);