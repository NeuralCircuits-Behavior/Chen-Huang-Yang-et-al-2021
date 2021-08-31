clear
%%
a = arduino();
a.writeDigitalPin('D13',0);
%% 
vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);

vid.TriggerRepeat = inf;
src.Exposure = 30;
%% trigger setting
vid.FramesPerTrigger = 1;
vid.Timeout = 24*60*60;
src.CircularBufferEnabled = 'ON';
src.ClearMode = 'Never';
src.ExposeOutMode = 'First Row';
src.TriggerMode = 'Edge Trigger';
triggerconfig(vid, 'hardware', 'Falling edge', 'Extern');

%%
vid.FramesPerTrigger = 2;
triggerconfig(vid, 'manual');
%}

%% start
start(vid);
%% hardware trigger, trigger 100 times
disp(' ');
for i = 1:1
n = 100;
t = zeros(n,1);
for k = 1:n
    tic
    a.writeDigitalPin('D13',1);
    pause(0.002);
    a.writeDigitalPin('D13',0);
    im_captured = getdata(vid);
    t(k) = toc;
    %figure;imshow(im_captured);
    pause(0.2)
    fprintf('.')
end
disp([mean(t),min(t),max(t)]);
figure;histogram(t);
end

%% internal trigger

disp(' ');
for i = 1:1
n = 100;
t = zeros(n,1);
for k = 1:n
    tic
    trigger(vid);
    im_captured = getdata(vid,2);
    im_captured = squeeze(im_captured(:,:,1,end));
    t(k) = toc;
    %figure;imshow(im_captured);

end
disp([mean(t),min(t),max(t)]);
figure;histogram(t);
end
%}
%% stop
stop(vid);
%}




