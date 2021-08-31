% 
% 
% mainMObj = ModelMain();
% % mainMObj.stageMObj = StageM();
% % mainMObj.piezoMObj = PiezoM();
% % mainMObj.userMObj = UserM();
% %mainMObj.cameraMObj = CameraM('simulate',[3334,4874]);
% %%mainMObj.cameraMObj = CameraM('simulate',[5740,15306]);
% 
% 
% 
% mainVObj = ViewMain();
% % mainVObj.userVObj = UserV(mainMObj.userMObj);
% % mainVObj.stageVObj = StageV(mainMObj.stageMObj);
% % mainVObj.piezoVObj = PiezoV(mainMObj.piezoMObj);
% % mainVObj.cameraVObj = CameraV(mainMObj.cameraMObj);
% 
% 
% 
% im = imread('Concatenated Stacks1_181.tif');
% im = imresize(im(:,:,1),size(im(:,:,1))*4);
% % hsz = 2048/2;
% hsz = 1200/2;
% tpi = im(9000-hsz:9000+hsz,12500-hsz:12500+hsz);
% 
% dirObj = DetectedDir1(tpi,[0.1,0.1]);   % only need once
% 
% 
% mainMObj.edObj = EdgeDetect2(dirObj,mainMObj); 
% 
% mainMObj.ndetectedge = 1; mainMObj.edObj.detectEdge(mainMObj);
% 
% 

% vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
% src = getselectedsource(vid);
% vid.FramesPerTrigger = 1;
% % fast acq use, 2017/8/29, CH ----------
% vid.TriggerRepeat = Inf;
% triggerconfig(vid, 'manual');
% % ---------------------------------------
% 
% src.ReadoutRate = 'P0S1: 100MHz, 16b, CMOS';
% src.GainIndex = 'Gain 1-HDR';
% src.TriggerMode = 'Trigger first';
% 
% start(vid);
% wait(vid,1);
% 
% inter = 200;
% 
% t = zeros(1,inter);
% for k =1:inter
% 
% % trigger(vid);
% SetPulsePalVoltage(2, 0);pause(0.2);SetPulsePalVoltage(2,3);pause(0.2);SetPulsePalVoltage(2, 0);
% % tic
% im = getdata(vid);
% % t(k) = toc;
% end
% mean(t)
% min(t)
% max(t)

% Example for external Trigger
clc
close all
clear 
 %%
% Select the PM Adaptor
vid = videoinput('pmimaq',1);
src = getselectedsource(vid);
 
% Set exposure time and resolution
src.Exposure = 10;
src.ExpRes = 'ms';
 
% Specify number of frames to acquire
vid.FramesPerTrigger = 1;
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
% src.TriggerMode = 'Internal Trigger'; % software internal trigger
src.TriggerMode = 'Edge Trigger';       % Edge Trigger
% src.TriggerMode = 'Trigger First';    % First Edge Trigger
 
% Expose out Mode
src.ExposeOutMode = 'First Row';
% src.ExposeOutMode = 'All Rows';
% src.ExposeOutMode = 'Any Row';
% src.ExposeOutMode = 'Rolling Shutter';
 %%
% Start continuous buffered acquisition and wait for acquisition to complete
start(vid);
% wait(vid,10)
 %%
% Transfer acquired frames and timestamps from acquisition input buffer 
% into workspace
inter = 20;
t = nan(1,inter);

for i = 1:inter
    
SetPulsePalVoltage(2, 3);
tic
[data, ts] = getdata(vid, vid.FramesAvailable);
% [data, ts] = getdata(vid,vid.FramesAvailable);
t(i) = toc;
SetPulsePalVoltage(2, 0);
end
%%
stop(vid)
 %%
figure;
imaqmontage(data)
figure;
plot(ts, '.')
xlabel('Frame index');
ylabel('Timestamp (s)');
 
delete(vid);
clear vid;

