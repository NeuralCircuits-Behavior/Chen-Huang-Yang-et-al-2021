% AI, NI USB6366
sI = daq.createSession('ni');
sO = daq.createSession('ni');
addAnalogInputChannel(sI,'Dev1', 7, 'Voltage');
% to see whether piezo output represent whole distance
addAnalogInputChannel(sI,'Dev1', 6, 'Voltage');

addAnalogOutputChannel(sO,'Dev1',0,'Voltage');
sI.Rate = 500;
sO.Rate = 10000;
%%
% AI setting
sI.DurationInSeconds = 5; % 30 s is enough
sI.NotifyWhenDataAvailableExceeds = sI.DurationInSeconds * sI.Rate;
pauseTime = 2; %s

lh = addlistener(sI,'DataAvailable', @collectData); 
sI.startBackground();
pause(pauseTime);

% AO setting
speed = 20; % um/s
distance = [0,1]; % um
volRes = 45; % um/V

AO = [0,0.33; 1,45.30; 2,90.25; ...
          3,135.20; 4,180.15; 5,225.11; ...
          6,270.06; 7,315.08; 8,360.12; ...
          9,405.18]; 
      
wav = interp1(AO(:,2),AO(:,1),linspace(min(distance),max(distance),...
    abs(diff(distance))/speed*sO.Rate)','pchip');

%{
wav = linspace(min(distance)/volRes,max(distance)/volRes,...
    abs(diff(distance))/speed*sO.Rate)';
%}
    
tfHighToLow = distance(2)<distance(1);
if tfHighToLow
    wav = flip(wav);
end

queueOutputData(sO,wav);
sO.startBackground();

wait(sI);

tf = sI.UserData.TimeStamps < pauseTime;
thstd = 10;
th0 = mean(sI.UserData.Data(tf,1)) + ...
    thstd * std(sI.UserData.Data(tf,1)) * (-1)^tfHighToLow;
th1 = mean(sI.UserData.Data(flip(tf),1)) - ...
    thstd * std(sI.UserData.Data(flip(tf,1))) * (-1)^tfHighToLow;

slopTf = sI.UserData.Data(:,1) > min(th0,th1) & ...
    sI.UserData.Data(:,1) < max(th0,th1);

x = sI.UserData.TimeStamps(slopTf);
y = sI.UserData.Data(slopTf,1);
f = fit(x,y,'poly1');
disp(f);

% to see whether piezo output represent whole distance
figure;hold on;

subplot(1,2,1);
hold on
plot(sI.UserData.TimeStamps.*[1,1],sI.UserData.Data);
plot(f,x,y);
legend({'piezo output','piezo input'})
xlabel('Time (secs)');
ylabel('Voltage')

subplot(1,2,2)
plot(sI.UserData.TimeStamps,diff(sI.UserData.Data,1,2))
xlabel('Time (secs)');
ylabel('delta Voltage')

suptitle(sprintf('Speed: %d um/s;  AI Sample Rate: %d\nSlop: %.6f',...
    speed,sI.Rate,f.p1));

%%
distance = [0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,150,200,250,300,350]; % um

AO = [0,0.33; 1,45.30; 2,90.25; ...
          3,135.20; 4,180.15; 5,225.11; ...
          6,270.06; 7,315.08; 8,360.12; ...
          9,405.18]; 

outV = interp1(AO(:,2),AO(:,1),distance,'pchip');

sI.Rate = 500;
sI.DurationInSeconds = 1; % 30 s is enough
sI.NotifyWhenDataAvailableExceeds = sI.DurationInSeconds * sI.Rate;

lh = addlistener(sI,'DataAvailable', @collectData); 
sI.startBackground();

inV = zeros(numel(outV),3);

for k = 1:numel(outV)
    queueOutputData(sO,outV(k));
    sO.startBackground();
    pause(3)
    
    sI.startBackground();
    wait(sI);
    
    inV(k,1) = mean(sI.UserData.Data(:,1));
    inV(k,2) = std(sI.UserData.Data(:,1));
    inV(k,3) = max(sI.UserData.Data(:,1)) - min(sI.UserData.Data(:,1));
end
%%
function collectData(src,event)
src.UserData.TimeStamps = event.TimeStamps;
src.UserData.Data = event.Data;
end