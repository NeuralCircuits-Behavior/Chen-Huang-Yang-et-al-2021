% AI, NI USB6366
sAI = daq.createSession('ni');
sAO = daq.createSession('ni');
sDIO = daq.createSession('ni');

addAnalogInputChannel(sAI,'Dev1', 7, 'Voltage');
addDigitalChannel(sDIO,'Dev1','Port0/Line0','OutputOnly');

addAnalogOutputChannel(sAO,'Dev1',0,'Voltage');
sAI.Rate = 10000;
sAO.Rate = 10000;

%%
deltaVoltageY = [0.399725,0.499703,0.599679]; % V
deltaVoltageX = [20,25,30]; % um/s

speed = 20; % um/s

volRes = 45; % um/V
deltaVoltage = interp1(deltaVoltageX,deltaVoltageY,speed);
%%
% AI setting
sAI.IsContinuous = 1;
durationInSeconds = 2.5; % ms
sAI.NotifyWhenDataAvailableExceeds = durationInSeconds * sAI.Rate / 1000;
sAI.UserData.sDIO = sDIO;
sAI.UserData.deltaVoltage = deltaVoltage/speed;
sAI.UserData.isStart = 0;
sAI.UserData.lastVoltage = 0;
sAI.UserData.reverseVoltage = 0;

pauseTime = 0; %s

lh = addlistener(sAI,'DataAvailable', @mointorInput); 

%% DIO setting
tic
sDIO.doOutputSingleScan(1)
%outputSingleScan(sDIO,1);
toc
%%
sAI.startBackground();
pause(pauseTime);
%%
% AO setting

distance = [90,0]; % um

wav = linspace(min(distance)/volRes,max(distance)/volRes,...
    abs(diff(distance))/speed*sAO.Rate)';

tfHighToLow = distance(2)<distance(1);
if tfHighToLow
    wav = flip(wav);
end

queueOutputData(sAO,wav);
sAI.UserData.isStart = 1;

sAO.startBackground();


%%
function mointorInput(src,event)
if ~src.UserData.isStart
    return
end

if ~src.ScansAcquired
    %outputSingleScan(src.UserData.sDIO,0); % falling edge trigger camera
    src.UserData.sDIO.doOutputSingleScan(0);
    src.UserData.lastVoltage = mean(event.Data(1:5));
else
    tmpVoltage = mean(event.Data(end-4:end));
    if abs(tmpVoltage - src.UserData.lastVoltage) ...
            > src.UserData.deltaVoltage
       %outputSingleScan(src.UserData.sDIO,0); % falling edge trigger camera
       src.UserData.sDIO.doOutputSingleScan(0);
       src.UserData.lastVoltage = tmpVoltage;
       src.UserData.reverseVoltage = 1;
    else
        if src.UserData.reverseVoltage
            %outputSingleScan(src.UserData.sDIO,1);
            src.UserData.sDIO.doOutputSingleScan(1);
            src.UserData.reverseVoltage = 0;
        end
    end
end
end


