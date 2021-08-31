% 2017/7/21, CH, test stage profile
% tharlabs LNR50SE
% already complete calibration and set default setting

global h;
%% Create Matlab Figure Container
fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 650; % figure window size;Width
fpos(4) = 450; % Height

f = figure('Position', fpos,...
    'Menu','None',...
    'Name','APT GUI');

h = actxcontrol('MGMOTOR.MGMotorCtrl.1',[20 20 600 400 ], f);

%% Initialize
% Start Control
SN = 90871281; % put in the serial number of the hardware
set(h,'HWSerialNum', SN);

h.StartCtrl;


% Indentify the device
h.LoadParamSet('default');
if ~isprop(h,'fMoveComplete')
    h.addproperty('fMoveComplete');
end

h.fMoveComplete = 0;
 
pause(2); % waiting for the GUI to load up;
% Controlling the Hardware
h.MoveHome(0,0); % Home the stage. First 0 is the channel ID (channel 1)
                 % second 0 is to move immediately
% Event Handling
h.registerevent({'MoveComplete' 'callback_stageMoveComplete'});
h.registerevent({'HomeComplete' 'callback_stageHomeComplete'});

while ~h.fMoveComplete; pause(0.001);end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. microstep time test, 20mm/s vel, 20mm/s/s accn, one dirction 0->50
h.SetEncPosControlParams(0,1,1,0); % set mirostep mode
inter = 5;
posArray = (0.25:0.25:49.75)'; % each step 250 um
moveTime1 = zeros(numel(posArray),inter);

for j = 1:inter
    fprintf('%d ',j);
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k));
        h.MoveAbsolute(0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime1(k,j) = toc;
        
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    
    while ~h.fMoveComplete;pause(0.001);end  
    
end
 fprintf('done\n');
 figure; % step time(include command transmission) vs absolute position
 plot(repmat(posArray(2:end),1,inter),moveTime1(2:end,:));hold on; plot(posArray(2:end),mean(moveTime1(2:end,:),2),'r','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')

%% 2. microstep time test, 20mm/s vel, 20mm/s/s accn, one dirction 50->0
h.SetEncPosControlParams(0,1,1,0); % set mirostep mode
inter = 5;
posArray = (49.75:-0.25:0.25)'; % each step 250 um
moveTime2 = zeros(numel(posArray),inter);

for j = 1:inter
    fprintf('%d ',j);
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k));
        h.MoveAbsolute(0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime2(k,j) = toc;
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end  
end
 fprintf('done\n');
 figure; % step time(include command transmission) vs absolute position
 plot(repmat(posArray(2:end),1,inter),moveTime2(2:end,:));hold on; plot(posArray(2:end),mean(moveTime2(2:end,:),2),'r','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')
 
%% 3. 0->50, forward back forward
h.SetEncPosControlParams(0,1,1,0); % set mirostep mode
inter = 1;
posArray = (0:0.25:50)'; % each step 250 um
moveTime3 = zeros(numel(posArray)-1,3,inter);

h.fMoveComplete = 0;
h.SetAbsMovePos(0,0);
h.MoveAbsolute(0,0);
while ~h.fMoveComplete;pause(0.001);end

for j = 1:inter
    fprintf('%d ',j);
    for k = 1:size(moveTime3,1)
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k+1));
        h.MoveAbsolute(0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime3(k,1,j) = toc;
        
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k));
        h.MoveAbsolute(0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime3(k,2,j) = toc;
        
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k+1));
        h.MoveAbsolute(0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime3(k,3,j) = toc;
        
        
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end  
end
 fprintf('done\n');
 
 figure; % step time(include command transmission) vs absolute position
 plot(repmat(posArray(2:end),1,inter),squeeze(moveTime3(:,1,:)));hold on; plot(posArray(2:end),mean(squeeze(moveTime3(:,1,:)),2),'r','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')

 %% 4. encoder time test, 20mm/s vel, 20mm/s/s accn, one dirction 0->50
h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
inter = 1;
posArray = (0.25:0.25:50-0.25)'; % each step 250 um
moveTime4 = zeros(numel(posArray),inter);

for j = 1:inter
    fprintf('%d ',j);
%     keyboard;
    
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        pos = posArray(k);
        h.MoveAbsoluteEnc(0,pos,0,0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime4(k,j) = toc;
        
    end
    
    fprintf('%.4f ',h.GetPosition_Position(0));
    
%     keyboard;
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    
    while ~h.fMoveComplete;pause(0.001);end  

end
 fprintf('done\n');
 figure; % step time(include command transmission) vs absolute position
 plot(repmat(posArray,1,inter),moveTime4(:,:));hold on; plot(posArray,mean(moveTime4(:,:),2),'r','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')
 
%% 5. encoder time test, correct& stop, 20mm/s vel, 20mm/s/s accn, one dirction 0->50
h.SetEncPosControlParams(0,2,3,1); % set encoder mode, correct& stop
inter = 3;
posArray = (0.25:0.25:50-0.25)'; % each step 250 um
moveTime5 = zeros(numel(posArray),inter);

for j = 1:inter
    fprintf('%d ',j);
%     keyboard;
    
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        pos = posArray(k);
        h.MoveAbsoluteEnc(0,pos,0,0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime5(k,j) = toc;
        
    end
    
    fprintf('%.4f ',h.GetPosition_Position(0));
    
%     keyboard;
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    
    while ~h.fMoveComplete;pause(0.001);end  

end
 fprintf('done\n');
 figure; % step time(include command transmission) vs absolute position
 plot(repmat(posArray,1,inter),moveTime5(:,:));hold on; plot(posArray,mean(moveTime5(:,:),2),'r','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')
 
 %% 6. 0->50, encoder, forward back forward
h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
inter = 1;
posArray = (0.25:0.25:49.75)'; % each step 250 um
moveTime6 = zeros(numel(posArray)-1,3,inter);

h.fMoveComplete = 0;
h.SetAbsMovePos(0,0);
h.MoveAbsolute(0,0);
while ~h.fMoveComplete;pause(0.001);end

for j = 1:inter
    fprintf('%d ',j);
    for k = 1:numel(posArray)-1
        h.fMoveComplete = 0;
        h.MoveAbsoluteEnc(0,posArray(k+1),0,0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime6(k,1,j) = toc;
        
        h.fMoveComplete = 0;
        h.MoveAbsoluteEnc(0,posArray(k),0,0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime6(k,2,j) = toc;
        
        h.fMoveComplete = 0;
        h.MoveAbsoluteEnc(0,posArray(k+1),0,0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        moveTime6(k,3,j) = toc;
        
        
    end
    fprintf('%.4f; ',h.GetPosition_Position(0));
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end  
    
    
end
 fprintf('done\n');
 
 figure; % step time(include command transmission) vs absolute position
 subplot(2,2,1)
 plot(repmat(posArray(2:end),1,inter),squeeze(moveTime6(:,1,:)));hold on; plot(posArray(2:end),mean(squeeze(moveTime6(:,1,:)),2),'r','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')
 
 subplot(2,2,2)
 plot(repmat(posArray(2:end),1,inter),squeeze(moveTime6(:,3,:)));hold on; plot(posArray(2:end),mean(squeeze(moveTime6(:,3,:)),2),'b','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')
 
 subplot(2,2,3)
 plot(repmat(posArray(1:end-1),1,inter),squeeze(moveTime6(:,2,:)));hold on; plot(posArray(1:end-1),mean(squeeze(moveTime6(:,2,:)),2),'g','linewidth',3);
 xlabel('Absolute Position, mm');ylabel('Time, s')
 
 subplot(2,2,4)
 plot(posArray(2:end),mean(squeeze(moveTime6(:,1,:)),2),'r.','linewidth',3);hold on
 [p,S,mu] = polyfit(posArray(2:end),mean(squeeze(moveTime6(:,1,:)),2),15);
 p1 = plot(posArray(2:end),polyval(p,posArray(2:end),S,mu),'r','linewidth',3);hold on
 
 plot(posArray(1:end-1),mean(squeeze(moveTime6(:,2,:)),2),'g.','linewidth',3);hold on
 [p,S,mu] = polyfit(posArray(1:end-1),mean(squeeze(moveTime6(:,2,:)),2),15);
 p2 = plot(posArray(1:end-1),polyval(p,posArray(1:end-1),S,mu),'g','linewidth',3);hold on
 
 plot(posArray(2:end),mean(squeeze(moveTime6(:,3,:)),2),'b.','linewidth',3);hold on
  [p,S,mu] = polyfit(posArray(2:end),mean(squeeze(moveTime6(:,3,:)),2),15);
 p3 = plot(posArray(2:end),polyval(p,posArray(2:end),S,mu),'b','linewidth',3);
  xlabel('Absolute Position, mm');ylabel('Time, s')
  legend([p1,p2,p3],{'1st forward','back','2nd forward'})
  
%% 7. position calibration, abs move

h.SetEncPosControlParams(0,1,1,0); % set mirocstep mode, correct
posArray = [0.25:0.25:49.75,49.75:-0.25:0.25]';
inter = 3;

posGet1 = zeros(numel(posArray),inter); % microstep

h.fMoveComplete = 0;
h.MoveHome(0,0);
while ~h.fMoveComplete;pause(0.001);end

for j = 1:inter
    % use microstep mode but use microstep command, get stage position
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k));
        h.MoveAbsolute(0,0);
        while ~h.fMoveComplete;pause(0.001);end
        h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
        pause(0.002);
        posGet1(k,j) = h.GetPosition_Position(0);
        h.SetEncPosControlParams(0,1,1,0); % set microstep mode
        pause(0.002);

    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

fprintf('mircostep done.');

inter = 3;
posGet2 = zeros(numel(posArray),inter); % encoder


% use encoder mode but use encoder command, get stage position
h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
for j =1:inter
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.MoveAbsoluteEnc(0,posArray(k),0,0,0);
        while ~h.fMoveComplete;pause(0.001);end
        posGet2(k,j) = h.GetPosition_Position(0);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

fprintf('encoder correct done.');

% disable correct
h.SetEncPosControlParams(0,2,1,1); % set encoder mode, correct
inter = 3;
posGet3 = zeros(numel(posArray),inter); % encoder

for j =1:inter
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.MoveAbsoluteEnc(0,posArray(k),0,0,0);
        while ~h.fMoveComplete;pause(0.001);end
        posGet3(k,j) = h.GetPosition_Position(0);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

fprintf('encoder disabled done.');

figure;
diffposGet1 = (repmat(posArray,1,3)-posGet1)*1000; % um
diffposGet2 = (repmat(posArray,1,3)-posGet2)*1000; % um
diffposGet3 = (repmat(posArray,1,3)-posGet3)*1000; % um

sz = size(diffposGet1,1);

subplot(2,2,1)
plot(repmat(posArray(1:sz/2),1,3),diffposGet1(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet1(sz/2+1:end,:),'.:');hold on; 

diffposGet1 = (posArray-mean(posGet1,2))*1000; % um
plot(posArray(1:sz/2),diffposGet1(1:sz/2),'r-','LineWidth',2);hold on;
plot(posArray(sz/2+1:end),diffposGet1(sz/2+1:end),'r:','LineWidth',2);

subplot(2,2,4)
p1 = plot(posArray(1:sz/2),diffposGet1(1:sz/2),'r.-','LineWidth',1);hold on;
p2 = plot(posArray(sz/2+1:end),diffposGet1(sz/2+1:end),'r.:','LineWidth',1);hold on
% :---------------------------
subplot(2,2,2)
plot(repmat(posArray(1:sz/2),1,3),diffposGet2(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet2(sz/2+1:end,:),'.:');hold on; 

diffposGet2 = (posArray-mean(posGet2,2))*1000; % um
plot(posArray(1:sz/2),diffposGet2(1:sz/2),'g-','LineWidth',2);hold on;
plot(posArray(sz/2+1:end),diffposGet2(sz/2+1:end),'g:','LineWidth',2);

subplot(2,2,4)
p3 = plot(posArray(1:sz/2),diffposGet2(1:sz/2),'g.-','LineWidth',1);hold on;
p4 = plot(posArray(sz/2+1:end),diffposGet2(sz/2+1:end),'g*:','LineWidth',1);hold on
% -----------------------------
subplot(2,2,3)
plot(repmat(posArray(1:sz/2),1,3),diffposGet3(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet3(sz/2+1:end,:),'.:');hold on; 

diffposGet3 = (posArray-mean(posGet3,2))*1000; % um
plot(posArray(1:sz/2),diffposGet3(1:sz/2),'b-','LineWidth',2);hold on;
plot(posArray(sz/2+1:end),diffposGet3(sz/2+1:end),'b:','LineWidth',2);

subplot(2,2,4)
p5 = plot(posArray(1:sz/2),diffposGet3(1:sz/2),'b.-','LineWidth',1);hold on;
p6 = plot(posArray(sz/2+1:end),diffposGet3(sz/2+1:end),'b.:','LineWidth',1);hold on

xlabel('Expected Position, mm');ylabel('delta Position, micro')
legend([p1,p2,p3,p4,p5,p6],...
    {'forward, mircostep','back, mircostep','forward,encoder,correct','back,encoder,correct','forward,encoder,disabled','back,encoder,disabled'},...
    'Location','northwest');

figure; % step size
plot(diff(mean(posGet1,2)),'r.-');hold on;plot(diff(mean(posGet2,2)),'g.-');hold on;plot(diff(mean(posGet3,2)),'b.-');
 
% posGet1_abs = posGet1;posGet2_abs = posGet2;posGet3_abs = posGet3;

%% 8. position calibration, rel move

h.SetEncPosControlParams(0,1,1,0); % set microstep mode, correct
posArray = [0.25:0.25:49.75,49.75:-0.25:0.25]';
posArray_diff = diff([0;posArray]);
inter = 3;

posGet1 = zeros(numel(posArray),inter); % microstep

h.fMoveComplete = 0;
h.MoveHome(0,0);
while ~h.fMoveComplete;pause(0.001);end

for j = 1:inter
    % use microstep mode but use microstep command, get stage position
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.SetRelMoveDist(0,posArray_diff(k));
        h.MoveRelative(0,0);
        while ~h.fMoveComplete;pause(0.001);end
        h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
        pause(0.002);
        posGet1(k,j) = h.GetPosition_Position(0);
        h.SetEncPosControlParams(0,1,1,0); % set encoder mode, correct
        pause(0.002);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

inter = 3;
posGet2 = zeros(numel(posArray),inter); % encoder


% use encoder mode but use encoder command, get stage position
h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
for j =1:inter
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.MoveRelativeEnc(0,posArray_diff(k),0,0,0);
        while ~h.fMoveComplete;pause(0.001);end
        pause(0.002);
        posGet2(k,j) = h.GetPosition_Position(0);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

% disable correct
h.SetEncPosControlParams(0,2,1,1); % set encoder mode, correct, disabled
inter = 3;
posGet3 = zeros(numel(posArray),inter); % encoder

for j =1:inter
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.MoveRelativeEnc(0,posArray_diff(k),0,0,0);
        while ~h.fMoveComplete;pause(0.001);end
        pause(0.03)
        posGet3(k,j) = h.GetPosition_Position(0);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

figure;
diffposGet1 = (repmat(posArray,1,3)-posGet1)*1000; % um
diffposGet2 = (repmat(posArray,1,3)-posGet2)*1000; % um
diffposGet3 = (repmat(posArray,1,3)-posGet3)*1000; % um

sz = size(diffposGet1,1);

subplot(2,2,1)
plot(repmat(posArray(1:sz/2),1,3),diffposGet1(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet1(sz/2+1:end,:),'.:');hold on; 

diffposGet1 = (posArray-mean(posGet1,2))*1000; % um
plot(posArray(1:sz/2),diffposGet1(1:sz/2),'r-','LineWidth',2.5);hold on;
plot(posArray(sz/2+1:end),diffposGet1(sz/2+1:end),'r:','LineWidth',2.5);

subplot(2,2,4)
p1 = plot(posArray(1:sz/2),diffposGet1(1:sz/2),'r.-','LineWidth',1);hold on;
p2 = plot(posArray(sz/2+1:end),diffposGet1(sz/2+1:end),'r.:','LineWidth',1);hold on
% :---------------------------
subplot(2,2,2)
plot(repmat(posArray(1:sz/2),1,3),diffposGet2(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet2(sz/2+1:end,:),'.:');hold on; 

diffposGet2 = (posArray-mean(posGet2,2))*1000; % um
plot(posArray(1:sz/2),diffposGet2(1:sz/2),'g-','LineWidth',2.5);hold on;
plot(posArray(sz/2+1:end),diffposGet2(sz/2+1:end),'g:','LineWidth',2.5);

subplot(2,2,4)
p3 = plot(posArray(1:sz/2),diffposGet2(1:sz/2),'g.-','LineWidth',1);hold on;
p4 = plot(posArray(sz/2+1:end),diffposGet2(sz/2+1:end),'g*:','LineWidth',1);hold on
% -----------------------------
subplot(2,2,3)
plot(repmat(posArray(1:sz/2),1,3),diffposGet3(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet3(sz/2+1:end,:),'.:');hold on; 

diffposGet3 = (posArray-mean(posGet3,2))*1000; % um
plot(posArray(1:sz/2),diffposGet3(1:sz/2),'b-','LineWidth',2.5);hold on;
plot(posArray(sz/2+1:end),diffposGet3(sz/2+1:end),'b:','LineWidth',2.5);

subplot(2,2,4)
p5 = plot(posArray(1:sz/2),diffposGet3(1:sz/2),'b.-','LineWidth',1);hold on;
p6 = plot(posArray(sz/2+1:end),diffposGet3(sz/2+1:end),'b.:','LineWidth',1);hold on

xlabel('Expected Position, mm');ylabel('delta Position, micro')
legend([p1,p2,p3,p4,p5,p6],...
    {'forward, mircostep','back, mircostep','forward,encoder,correct','back,encoder,correct','forward,encoder,disabled','back,encoder,disabled'},...
    'Location','northwest');

figure; % step size
plot(diff(mean(posGet1,2)),'r.-');hold on;plot(diff(mean(posGet2,2)),'g.-');hold on;plot(diff(mean(posGet3,2)),'b.-');

%% 9. self correct mircosetp
h.SetEncPosControlParams(0,1,1,0); % set mirocstep mode, correct
posArray = [0.25:0.25:49.75,49.75:-0.25:0.25]';
inter = 3;

posGet4 = zeros(numel(posArray),inter); % microstep
moveTime9  = zeros(numel(posArray),inter);

h.fMoveComplete = 0;
h.MoveHome(0,0);
while ~h.fMoveComplete;pause(0.001);end

for j = 1:inter
    % use microstep mode but use microstep command, get stage position
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        h.SetAbsMovePos(0,posArray(k));
        h.MoveAbsolute(0,0);
        tic;
        while ~h.fMoveComplete;pause(0.001);end
        
        h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
        pos_rel = posArray(k) - h.GetPosition_Position(0);
        h.SetEncPosControlParams(0,1,1,0); % set encoder mode, correct        
        h.fMoveComplete = 0;
        h.SetRelMoveDist(0,pos_rel);
        h.MoveRelative(0,0);
        while ~h.fMoveComplete;pause(0.001);end
        
%         h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct        
%         pos_rel = posArray(k) - h.GetPosition_Position(0);
%         h.SetEncPosControlParams(0,1,1,0); % set encoder mode, correct
%         h.fMoveComplete = 0;
%         h.SetRelMoveDist(0,pos_rel);
%         h.MoveRelative(0,0);
%         while ~h.fMoveComplete;pause(0.001);end
        
        moveTime9(k,j) = toc;
        h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
        pause(0.002);
        posGet4(k,j) = h.GetPosition_Position(0);
        h.SetEncPosControlParams(0,1,1,0); % set encoder mode, correct
        pause(0.002);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

figure;
diffposGet4 = (repmat(posArray,1,3)-posGet4)*1000; % um
sz = size(diffposGet4,1);

plot(repmat(posArray(1:sz/2),1,3),diffposGet4(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet4(sz/2+1:end,:),'.:');hold on; 

diffposGet4 = (posArray-mean(posGet4,2))*1000; % um
plot(posArray(1:sz/2),diffposGet4(1:sz/2),'r-','LineWidth',2.5);hold on;
plot(posArray(sz/2+1:end),diffposGet4(sz/2+1:end),'r:','LineWidth',2.5);

%% 10. fit correct
h.SetEncPosControlParams(0,1,1,0); % set mirocstep mode, correct
posArray = [0.25:0.25:49.75,49.75:-0.25:0.25]';
inter = 3;

posGet5 = zeros(numel(posArray),inter); % microstep

h.fMoveComplete = 0;
h.MoveHome(0,0);
while ~h.fMoveComplete;pause(0.001);end

for j = 1:inter
    % use microstep mode but use microstep command, get stage position
    for k = 1:numel(posArray)
        h.fMoveComplete = 0;
        if k<=numel(posArray)/2
            abspos = polyval(Sx.pf,posArray(k),Sx.Sf,Sx.muf);
        else
            abspos = polyval(Sx.pr,posArray(k),Sx.Sr,Sx.mur);
        end
        
        h.SetAbsMovePos(0,abspos);
        h.MoveAbsolute(0,0);
        while ~h.fMoveComplete;pause(0.001);end
        
        h.SetEncPosControlParams(0,2,2,1); % set encoder mode, correct
        pause(0.002);
        posGet5(k,j) = h.GetPosition_Position(0);
        h.SetEncPosControlParams(0,1,1,0); % set encoder mode, correct
        pause(0.002);
    end
    
    h.fMoveComplete = 0;
    h.MoveHome(0,0);
    while ~h.fMoveComplete;pause(0.001);end
end

figure;
diffposGet5 = (repmat(posArray,1,3)-posGet5)*1000; % um
sz = size(diffposGet5,1);

plot(repmat(posArray(1:sz/2),1,3),diffposGet5(1:sz/2,:),'.-');hold on;
plot(repmat(posArray(sz/2+1:end),1,3),diffposGet5(sz/2+1:end,:),'.:');hold on; 

diffposGet5 = (posArray-mean(posGet5,2))*1000; % um
plot(posArray(1:sz/2),diffposGet5(1:sz/2),'r-','LineWidth',2.5);hold on;
plot(posArray(sz/2+1:end),diffposGet5(sz/2+1:end),'r:','LineWidth',2.5);


%%
h.StopCtrl;