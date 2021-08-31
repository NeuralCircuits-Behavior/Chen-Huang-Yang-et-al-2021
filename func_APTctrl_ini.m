% 2107/5/15,CH 

function f_main= func_APTctrl_ini
global sth piezoh
tic;
fprintf('* APT Control of stages and piezo are initiating ');
t = timer('TimerFcn','fprintf(''.'');', 'Period', 1, 'ExecutionMode', 'fixedSpacing');start(t);

screensz = get(0,'screensize');
screensz = [screensz(3:4),screensz(3:4)];
%% Create ActiveX Controller
fpos = [0 .046 .2 0.92];
f_main = figure('Units','normalized',...
           'Position', fpos,...
           'Menu','None',...
           'Name','APT_Main GUI',...
           'resize','off');
       
fsz = [0.19,0.2]; % [width,heigh] in norm 
st1_sz = [[.005, 0.9-0.2],fsz].*screensz;
st2_sz = [[.005, 0.9-0.2-0.21],fsz].*screensz;
st3_sz = [[.005, 0.9-0.2-0.21*2],fsz].*screensz;
piezo_sz = [[.005, 0.9-0.2-0.21*3],fsz].*screensz;

sthx = actxcontrol('MGMOTOR.MGMotorCtrl.1',st1_sz, f_main);
sthy = actxcontrol('MGMOTOR.MGMotorCtrl.1',st2_sz, f_main);
sthz = actxcontrol('MGMOTOR.MGMotorCtrl.1',st3_sz, f_main);
piezoh = actxcontrol('MGPIEZO.MGPiezoCtrl.1',piezo_sz, f_main);

%% Set the Serial Number
% SN = [90871281,90871282,90871283]; % put in the serial number of the hardware
SN = [90000002,90000003,90000004,44000001];
set(sthx,'HWSerialNum', SN(1));
set(sthy,'HWSerialNum', SN(2));
set(sthz,'HWSerialNum', SN(3));
set(piezoh,'HWSerialNum', SN(4));

%% Start Control
sthx.StartCtrl;
sthy.StartCtrl;
sthz.StartCtrl;
piezoh.StartCtrl;

%% waiting for the GUI to load up;
pause(3); 
%% set 25mm start
sthx.SetAbsMovePos(0,25);
sthx.MoveAbsolute(0,0);

sthy.SetAbsMovePos(0,25);
sthy.MoveAbsolute(0,0);

sthz.SetAbsMovePos(0,1);
sthz.MoveAbsolute(0,1);

while func_IsStMoving(sthx) || func_IsStMoving(sthy) || func_IsStMoving(sthz)
    pause(0.05)
end

sth=[sthx;sthy;sthz];

%% logger
% fpos = [0.21 0.97-0.15 0.4 0.15];
% f_log = figure('Units','normalized',...
%            'Position', fpos,...
%            'Menu','None',...
%            'Name','APT_Logger GUI',...
%            'resize','off');
%        
% logger_sz = [0,0,fpos(3:4)].*screensz; % first 2 is relative to figure inside
% logger = actxcontrol('MG17LOGGER.MG17LoggerCtrl.1',logger_sz, f_log);

%%
stop(t); et=toc; fprintf(' done. Elapsed %.2f seconds.\n', et);
end