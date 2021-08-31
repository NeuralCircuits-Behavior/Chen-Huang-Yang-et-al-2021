% Example for external Trigger
clc
close all
clear all
 
% Select the PM Adaptor
vid = videoinput('pmimaq',1);
src = getselectedsource(vid);
 
% Set exposure time and resolution
src.Exposure = 10;
src.ExpRes = 'ms';
 
% Specify number of frames to acquire
vid.FramesPerTrigger = 10;
vid.TriggerRepeat = 0;
 
% The default videoinput trigger type is 'immediate', which is explicitly
% configured here for clarity.
triggerconfig(vid, 'immediate');
% triggerconfig(vid, 'manual'); % MATLAB GUI based trigger control image acqusition
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trigger is device specific - so TriggerMode and ExposeOutMode work as
% external triggering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Trigger Mode
src.TriggerMode = 'Internal Trigger'; % software internal trigger
% src.TriggerMode = 'Edge Trigger';       % Edge Trigger
% src.TriggerMode = 'Trigger First';    % First Edge Trigger
 
% Expose out Mode
% src.ExposeOutMode = 'First Row';
src.ExposeOutMode = 'All Rows';
% src.ExposeOutMode = 'Any Row';
% src.ExposeOutMode = 'Rolling Shutter';
 
% Start continuous buffered acquisition and wait for acquisition to complete
start(vid);
wait(vid,10)
 
% Transfer acquired frames and timestamps from acquisition input buffer 
% into workspace
[data, ts] = getdata(vid, vid.FramesAvailable);
 
stop(vid)
 
figure;
imaqmontage(data)
figure;
plot(ts, '.')
xlabel('Frame index');
ylabel('Timestamp (s)');
 
delete(vid);
clear vid;
