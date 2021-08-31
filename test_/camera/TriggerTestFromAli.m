
vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);
%%
%{
a =  arduino();
a.writeDigitalPin('D13',1);
%}
PulsePal('COM4');
SetPulsePalVoltage(4,0);
%%
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = inf;
src.TriggerMode =  'Edge Trigger';
src.Exposure = 300;

triggerconfig(vid, 'hardware', 'Falling edge', 'extern');
%%
start(vid);
%%
N = 10;
t = zeros(1,N);
for k = 1:N
clear im_captured


%{
a.writeDigitalPin('D13',0);
pause(0.02);
a.writeDigitalPin('D13',1);
%}
tic;
SetPulsePalVoltage(4,5);
pause(0.08);
SetPulsePalVoltage(4,0);

im_captured = getdata(vid);
t(k) = toc;
figure;imshow(im_captured);
end
disp(mean(t)*1000);
figure;histogram(t*1000);
%%
stop(vid);





