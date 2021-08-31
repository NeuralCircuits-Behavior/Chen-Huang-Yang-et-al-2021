clear
vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);
vid.FramesPerTrigger = 2;
src.CircularBufferEnabled = 'SNAP';
src.TriggerMode = 'Edge Trigger';
vid.TriggerRepeat = Inf;
triggerconfig(vid, 'hardware', 'Falling edge', 'Extern');
%%
start(vid);


%{
pause(5);
stop(vid);
im_captured = getdata(vid);
%}



