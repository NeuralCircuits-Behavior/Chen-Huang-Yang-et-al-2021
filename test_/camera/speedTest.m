vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);
vid.TriggerRepeat = inf;
vid.FramesPerTrigger = 1;
src.ExposeOutMode = 'First Row';
src.PortSpeedGain = 'Port0-Speed1-100MHz-16bit-Gain1-HDR';

triggerconfig(vid, 'manual');

%%
src.Exposure = 10;
vid.TriggerRepeat = inf;
vid.FramesPerTrigger = 1;
start(vid);
t = ones(1000000,1);
for k = 1:numel(t)
    if ~mod(k,100)
        disp(k);
    end
    tic;trigger(vid);
    pause(0.002)
    im = getdata(vid,1);
    t(k) = toc;
end
stop(vid);

disp(1/mean(t));
disp(mean(t));
%%
set(0,'UserData',vid);
src.Exposure = 10;
start(get(0,'UserData'));
t = ones(1000,1);
for k = 1:numel(t)
    tic;trigger(get(0,'UserData'));
    [ims,time] = getdata(get(0,'UserData'),2);
    t(k) = toc;
end
stop(get(0,'UserData'));

disp(1/mean(t));
disp(mean(t));
%%
Context.getInstance.register('vid',vid);
src.Exposure = 10;
start(Context.getInstance.getData('vid'));
t = ones(1000,1);
for k = 1:numel(t)
    tic;trigger(Context.getInstance.getData('vid'));
    [ims,time] = getdata(Context.getInstance.getData('vid'),2);
    t(k) = toc;
end
stop(Context.getInstance.getData('vid'));

disp(1/mean(t));
disp(mean(t));
%%
vid.TriggerRepeat = 1;
vid.FramesPerTrigger = inf;

t0 = zeros(5,2);
for k = 1:5
    tic;
    start(vid);
    trigger(vid);
    t0(k,1) = toc;
    t = ones(100,1);
    for kk = 1:numel(t)
        tic;
        [ims,time] = getdata(vid,2);
        t(kk) = toc;
    end
    tic;
    stop(vid);
    flushdata(vid,'all');
    t0(k,2) = toc;
end

disp(1/mean(t));
disp(mean(t));
disp(mean(t0));
%%
vid.TriggerRepeat = inf;
vid.FramesPerTrigger = 1;

src.Exposure = 10;
start(vid);
t = ones(1000,1);
for k = 1:numel(t)
    tic;trigger(vid);
    [ims,time] = getdata(vid);
    t(k) = toc;
end
stop(vid);

disp(1/mean(t));
disp(mean(t));
%%
src.Exposure = 10;
start(vid);
t = ones(1000,1);
for k = 1:numel(t)
    tic;trigger(vid);
    [ims,time] = getdata(vid,2);
    func_writeTifFast16(ims,...
        'D:\Data\confocalRelated\testData\imaging\tmp\tmp.tif');
    t(k) = toc;
end
stop(vid);

disp(1/mean(t));
disp(mean(t));

%% RAM
v.cameraVObj.vsrcObj.Exposure = 10;
v.cameraVObj.vsrcObj.ExposeOutMode = 'First Row';
start(v.cameraVObj.vidObj);
t = ones(1000,1);
for k = 1:numel(t)
    tic;
    im = m.cameraMObj.captureImage();
    t(k) = toc;
end
stop(v.cameraVObj.vidObj);

disp(1/mean(t));
disp(mean(t));

%%
src = v.cameraVObj.vsrcObj;
vid = v.cameraVObj.vidObj;
src.Exposure = 1;
start(vid);
t = ones(1000,1);
for k = 1:numel(t)
    tic;trigger(vid);
    [ims,time] = getdata(vid,2);
    t(k) = toc;
end
stop(vid);

disp(1/mean(t));
disp(mean(t));

%% 
v.cameraVObj.vsrcObj.Exposure = 80;
start(v.cameraVObj.vidObj);
t = ones(1000,1);
for k = 1:numel(t)
    tic;
    im = m.cameraMObj.captureImage();
    m.cameraMObj.saveImage(im,...
        'D:\Data\confocalRelated\testData\imaging\tmp\tmp.tif');
    t(k) = toc;
end
stop(v.cameraVObj.vidObj);

disp(1/mean(t));
disp(mean(t));

%% 
v.cameraVObj.vsrcObj = [];
v.cameraVObj.vidObj = [];

vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);
vid.TriggerRepeat = inf;
vid.FramesPerTrigger = 2;
 
triggerconfig(vid, 'manual');
%%
src.Exposure = 1;
start(vid);
t = ones(1000,1);
for k = 1:numel(t)
    tic;trigger(vid);
    [ims,time] = getdata(vid,2);
    t(k) = toc;
end
stop(vid);

disp(1/mean(t));
disp(mean(t));