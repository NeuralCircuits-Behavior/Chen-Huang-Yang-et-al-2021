fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 650; % figure window size;Width
fpos(4) = 450; % Height

f = figure('Position', fpos,...
    'Menu','None',...
    'Name','APT GUI');
sz = [20 20 600 400 ];
%%
h = actxcontrol('MGPIEZO.MGPiezoCtrl.1',sz, f);
set(h,'HWSerialNum', 44000121);
h.StartCtrl;

%%
range = 5:5:440;
t = zeros(numel(range),2);
for k = range
    tic;
    h.SetPosOutput(0,k); 
    t(k,1) = toc;
    
    while 1
        [~,a] = h.GetPosOutput(0,0);
        if abs( a - k) < 0.5
            break
        end
        pause(0.001);
    end
    
    t(k,2) = toc;
end
h.SetPosOutput(0,0); 

%%
h.StopCtrl();
%%

range = 5:5:440;
t = zeros(numel(range),2);
for k = range
    tic;
    m.piezoMObj.movePiezo(k); 
    t(k,1) = toc;
    m.piezoMObj.waitForPiezoStatic(k);
    t(k,2) = toc;
end
m.piezoMObj.movePiezo(0); 
disp(mean(t));


%% 2019/2/14
range = 0:0.5:400;
N = numel(range); 
[volInClosed, posInOpen] = deal(zeros(N,1));

% in colosed loop
for k = 1:N
    h.SetPosOutput(0,range(k));
    pause(0.1);
    [~,volInClosed(k)] = h.GetVoltOutput(0,0);
end
%%
figure;
plot(range,volInClosed,'.-');
xlabel('Distance');
ylabel('Voltage');
%% in openloop
for k = 1:N
    h.SetVoltOutput(0,volInClosed(k));
    pause(0.1);
    [~,posInOpen(k)] = h.GetPosOutput(0,0);
end

%%
figure;
hold on
plot(range,volInClosed);
plot(posInOpen,volInClosed);
xlabel('Distance');
ylabel('Voltage');