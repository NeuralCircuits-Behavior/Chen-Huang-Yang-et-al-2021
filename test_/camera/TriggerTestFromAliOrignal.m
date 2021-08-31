clear
vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);
vid.FramesPerTrigger = 5;
src.TriggerMode = 'Trigger first';

triggerconfig(vid, 'hardware', 'rising edge', 'extern');

start(vid);
pause(5);
im_captured = getdata(vid);
stop(vid);





