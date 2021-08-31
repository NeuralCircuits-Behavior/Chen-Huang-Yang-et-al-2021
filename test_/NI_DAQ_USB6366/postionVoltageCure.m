% open piezo

fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 650; % figure window size;Width
fpos(4) = 450; % Height

f = figure('Position', fpos,...
    'Menu','None',...
    'Name','APT GUI');
sz = [20 20 600 400 ];

h = actxcontrol('MGPIEZO.MGPiezoCtrl.1',sz, f);
set(h,'HWSerialNum', 44000121);
h.StartCtrl;

%% AO set
sO = daq.createSession('ni');
addAnalogOutputChannel(sO,'Dev1',0,'Voltage');

%% 
testVols = [0:0.01:7];
refPositions = test(testVols,h,sO);
%%
s = struct();
s(1).zeroVPosition = 0;
s(1).voltPos = [testVols;refPositions]';
%%
% h.SetPPCIOSettings(0,0,3,1,2) or h.SetPPCIOSettings(0,1,3,1,2)
figure;hold on;
plot(s(1).voltPos(:,2),s(1).voltPos(:,1));
testZeros = 10:10:100;
testVols = [0:0.01:7];
for k = 1:numel(testZeros)
    h.SetPPCIOSettings(0,0,3,1,2);
    h.SetPosOutput(0,testZeros(k));
    pause(5);
    h.SetPPCIOSettings(0,1,3,1,2);
    [~,s(k+1).zeroVPosition] = h.GetPosOutput(0,0);
    disp(s(k+1).zeroVPosition);
    
    s(k+1).voltPos = [testVols;test(testVols,h,sO)]';
    plot(s(k+1).voltPos(:,2)-s(k+1).zeroVPosition,s(k+1).voltPos(:,1));
end

%%
function refPositions = test(testVols,h,sO)

refPositions = zeros(size(testVols));


for k = 1:numel(testVols)
    outputSingleScan(sO,testVols(k));
    pause(0.1);
    
    [~,refPositions(k)] = h.GetPosOutput(0,0);
    %disp(refPositions(k));
end
end