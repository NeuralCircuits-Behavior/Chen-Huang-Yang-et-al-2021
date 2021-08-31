function buildUI(obj)
L0 = uiextras.HBox('Parent',obj.hfigUser,'Padding',5,'Spacing',10);

L0_1 = uiextras.VBox('Parent',L0,'Spacing',10);
L0_2 = uiextras.VBox('Parent',L0,'Spacing',10);

%% leftLayout, APT Configuration Interface
L0_1_1 = uiextras.HBox('Parent',L0_1);
L0_1_1_1 = uipanel('Parent',L0_1_1,...
    'Title','APT Configuration',...
    'FontSize',10,'fontweight','bold');
L0_1_1_1_1 = uiextras.VBox('Parent',L0_1_1_1);
L0_1_1_1_1_0 = uiextras.HBox('Parent',L0_1_1_1_1);
% stage interface
L0_1_1_1_1_1 = uipanel('Parent',L0_1_1_1_1_0,...
    'Title','Stages',...
    'FontSize',9,'fontweight','bold');
L0_1_1_1_1_1_1 = uiextras.Grid('Parent',L0_1_1_1_1_1);
col1 = @(t)uicontrol('Parent',L0_1_1_1_1_1_1,...
    'style','text','string',t,...
    'horizontalalignment','right','fontweight','bold');
col1('X Start from');
col1('Y Start from');
col1('Z Start from');

col2 = @(p)uicontrol('parent',L0_1_1_1_1_1_1,...
    'style','edit','string',p,...
    'horizontalalignment','left');
obj.stageVObj.stageXStartEdit = col2('15');
obj.stageVObj.stageYStartEdit = col2('0');
obj.stageVObj.stageZStartEdit = col2('2');

col3 = col1;
col3('X Pos. Mode');
col3('Y Pos. Mode');
col3('Z Pos. Mode');

col4 = @()uicontrol('parent',L0_1_1_1_1_1_1,...
    'style','popupmenu','string','Microstep2|Microstep3|Microstep|Encoder',...
    'horizontalalignment','left');
obj.stageVObj.positioningModePopupX = col4();
obj.stageVObj.positioningModePopupY = col4();
obj.stageVObj.positioningModePopupZ = col4();

set(L0_1_1_1_1_1_1,'rowsizes',[-1,-1,-1],...
    'columnsizes',[-0.31,-0.25,-0.32,-0.6],...
    'spacing',15,'padding',10);

% piezo interface
L0_1_1_1_1_2 = uipanel('Parent',L0_1_1_1_1_0,...
    'Title','Piezo','FontSize',9,'fontweight','bold');
L0_1_1_1_1_2_1 = uiextras.Grid('Parent',L0_1_1_1_1_2);
empCol = @()uiextras.Empty('Parent',L0_1_1_1_1_2_1);
uicontrol('Parent',L0_1_1_1_1_2_1,...
    'style','text','string','Start from',...
    'horizontalalignment','right','fontweight','bold');
empCol();
empCol();
obj.piezoVObj.piezoStartEdit = uicontrol('parent',L0_1_1_1_1_2_1,...
    'style','edit','string','0',...
    'horizontalalignment','left');
empCol();
empCol();

set(L0_1_1_1_1_2_1,'rowsizes',[-1,-1,-1],...
    'columnsizes',[-0.31,-0.18],...
    'spacing',15,'padding',10);

set(L0_1_1_1_1_0,'sizes',[-2,-1],'spacing',15,'padding',7);
% option interface
L0_1_1_1_1_3 = uiextras.HBox('Parent',L0_1_1_1_1);
button_ = @(s)uicontrol('parent',L0_1_1_1_1_3,...
    'style','pushbutton','string',s,'fontweight','bold');
obj.stageVObj.centerButton = button_('Set here as sample center');
uiextras.Empty('Parent',L0_1_1_1_1_3);
obj.stageVObj.initiateButton = button_('Initiate stages');
obj.piezoVObj.initiateButton= button_('Initiate piezo');
set(L0_1_1_1_1_3,'sizes',[-1.65,-0.2,-1,-1],'spacing',10,'padding',2);

L0_1_1_1_1_4 = uiextras.HBox('Parent',L0_1_1_1_1);
button_ = @(s)uicontrol('parent',L0_1_1_1_1_4,...
    'style','pushbutton','string',s,'fontweight','bold');
obj.stageVObj.move2bladePlaneButton = button_('To bladePlane');
obj.stageVObj.moveObjDeltaButton = button_('Move Obj_Delta');
uiextras.Empty('Parent',L0_1_1_1_1_4);
uiextras.Empty('Parent',L0_1_1_1_1_4);
set(L0_1_1_1_1_4,'sizes',[-1,-1,-1,-1],'spacing',10,'padding',2);

% setting of APT Configuration Interface
set(L0_1_1_1_1,'sizes',[-4.5,-0.65,-0.65],'spacing',4,'padding',4);
%% CSU and Laser
L0_1_4 = uipanel('Parent',L0_1,...
    'Title','CSU and Lasers','FontSize',10,'fontweight','bold');
obj.userVObj.shutterButton = uicontrol('parent',L0_1_4,...
    'style','togglebutton','string','Open SH',...
    'fontweight','bold','Position',[20 10 60 20]);
createbutton = @(s,pos)uicontrol('parent',L0_1_4,...
    'style','pushbutton','string',s,...
    'fontweight','bold','Position',pos);
obj.userVObj.laserHighButton = createbutton('laser High',[140 10 100.25 20]);
obj.userVObj.laserLowButton = createbutton('laser low',[260 10 100.25 20]);

%% leftLayout, State Interface
L0_1_2 = uiextras.HBox('Parent',L0_1);
L0_1_2_1 = uipanel('Parent',L0_1_2,...
    'Title','State','FontSize',10,'fontweight','bold');
obj.userVObj.axDisplay = axes('Parent',L0_1_2_1,'Position',[0.1,0.1,0.85,0.85]);
obj.userVObj.axDisplay.NextPlot = 'add';
%% leftLayout, Log Interface
L0_1_3 = uiextras.HBox('Parent',L0_1);
L0_1_3_1 = uipanel('Parent',L0_1_3,'Title','Log',...
    'FontSize',10,'fontweight','bold');
%{
obj.userVObj.hLog = uicontrol('Parent',hPanel2,'style','edit','tag','log',...
    'max',2,'horizontalalignment','left','enable','inactive',...
    'FontSize',10,'Units','normalized','Position',[0.04,0.04,0.92,0.92]);
%}
L0_1_3_1_1 = uiextras.VBox('Parent',L0_1_3_1);
obj.userVObj.hLog = uicontrol('Parent',L0_1_3_1_1,...
    'style','edit','tag','log','max',2,...
    'horizontalalignment','left','enable','inactive','FontSize',10);
L0_1_3_1_1_1 = uiextras.HBox('Parent',L0_1_3_1_1);
uiextras.Empty('Parent',L0_1_3_1_1_1);
obj.userVObj.saveLogButton = uicontrol('Parent',L0_1_3_1_1_1,...
    'style','pushbutton','string','Save Log','fontweight','bold');
set(L0_1_3_1_1_1,'sizes',[-0.75,-0.25],'spacing',10);
set(L0_1_3_1_1,'sizes',[-1,-0.2],'spacing',4,'padding',8);
%% leftLayout, setting
set(L0_1,'sizes',[-0.3,-0.07,-0.48,-0.19],'spacing',10,'padding',5);
%% rightLayout, camera
L0_2_1 = uipanel('Parent',L0_2,...
    'Title','Camera','FontSize',10,'fontweight','bold');
L0_2_1_1 = uiextras.VBox('Parent',L0_2_1);
obj.cameraVObj.axCamera = axes('Parent',L0_2_1_1,...
    'XTickLabel','','YTickLabel','','box','on','Visible','off');

L0_2_1_1_1 =  uiextras.HBox('Parent',L0_2_1_1);
uiextras.Empty('Parent',L0_2_1_1_1);
obj.cameraVObj.cameraConnectText = uicontrol('parent',L0_2_1_1_1,...
    'style','togglebutton','string','Acquiring stopped',...
    'fontweight','bold','BackgroundColor',[0.64,0.08,0.18],...
    'ForegroundColor','w','enable','inactive');
button_ = @(s)uicontrol('parent',L0_2_1_1_1,...
    'style','pushbutton','string',s,'fontweight','bold');
obj.cameraVObj.cameraConnectButton = button_('Start acquiring');
obj.cameraVObj.cameraDisconnectButton = button_('Stop acquiring');
uiextras.Empty('Parent',L0_2_1_1_1);
set(L0_2_1_1_1,'sizes',[-0.2,-0.2,-0.2,-0.2,-0.2],'spacing',10,'padding',5);

L0_2_1_1_2 = uiextras.HBox('Parent',L0_2_1_1);
L0_2_1_1_2_1 = uipanel('Parent',L0_2_1_1_2,...
    'Title','Configuration','FontSize',9,'fontweight','bold');
L0_2_1_1_2_1_1 = uiextras.HBox('Parent',L0_2_1_1_2_1);
button_ = @(s)uicontrol('parent',L0_2_1_1_2_1_1,...
    'style','pushbutton','string',s,'fontweight','bold');
obj.cameraVObj.setButton = button_('Set');
obj.cameraVObj.loadButton = button_('Load');
obj.cameraVObj.saveButton = button_('Save');
set(L0_2_1_1_2_1_1,'spacing',10,'padding',5);
L0_2_1_1_2_2 = uipanel('Parent',L0_2_1_1_2,...
    'Title','Operation','FontSize',9,'fontweight','bold');
L0_2_1_1_2_2_1 = uiextras.HBox('Parent',L0_2_1_1_2_2);
button_ = @(s,k)uicontrol('parent',L0_2_1_1_2_2_1,...
    'style','pushbutton','string',s,'fontweight','bold','enable',k);
obj.cameraVObj.startPreButton = button_('Start preview','on');
obj.cameraVObj.stopPreButton = button_('Stop preview','on');
obj.cameraVObj.captureTpiButton = button_('Capture tpi','off');
obj.cameraVObj.captureButton = button_('Capture','off');

set(L0_2_1_1_2_2_1,'spacing',10,'padding',5);
set(L0_2_1_1_2,'sizes',[-3,-4],'spacing',10,'padding',5);
set(L0_2_1_1,'sizes',[-0.84,-0.06,-0.1]);
%% rLowLayout
L0_2_2 = uiextras.HBox('Parent',L0_2);
L0_2_2_1 = uiextras.VBox('Parent',L0_2_2);
% section
L0_2_2_1_1 = uipanel('Parent',L0_2_2_1,...
    'Title','Section','FontSize',10,'fontweight','bold');
L0_2_2_1_1_1 = uiextras.VBox('Parent',L0_2_2_1_1);
uiextras.Empty('Parent',L0_2_2_1_1_1);
L0_2_2_1_1_1_1 = uiextras.Grid('Parent',L0_2_2_1_1_1);
% column 1
col1_3 = @(t)uicontrol('Parent',L0_2_2_1_1_1_1,...
    'style','text','string',t,...
    'horizontalalignment','right','fontweight','bold');
col1_3('Arduino Pin#');
col1_3('Speed');
col1_3('Start Pos.');
% column 2
col2_4 = @(p)uicontrol('parent',L0_2_2_1_1_1_1,...
    'style','edit','string',p,...
    'horizontalalignment','left');
obj.vtVObj.pinEdit = col2_4('D8');
obj.vtVObj.sampleSpeedEdit = col2_4('0.15');
obj.vtVObj.startCutPositionEdit = col2_4('26');
% column 3
col_em = @()uiextras.Empty('Parent',L0_2_2_1_1_1_1);
col_em();
col1_3('Step size');
col1_3('Stop Pos.');
% column 4
col_em();
obj.vtVObj.stepSizeEdit = col2_4('100');
obj.vtVObj.stopCutPositionEdit = col2_4('49');
set(L0_2_2_1_1_1_1,'rowsizes',[-1,-1,-1],...
    'columnsizes',[-0.75,-0.48,-0.75,-0.48],'spacing',10,'padding',5);

L0_2_2_1_1_1_2 = uiextras.HBox('Parent',L0_2_2_1_1_1);
button_ = @(s)uicontrol('parent',L0_2_2_1_1_1_2,...
    'style','pushbutton','string',s,'fontweight','bold');
obj.vtVObj.stateText = uicontrol('parent',L0_2_2_1_1_1_2,...
    'style','togglebutton','string','OFF',...
    'fontweight','bold','BackgroundColor',[0.64,0.08,0.18],...
    'ForegroundColor','w','enable','inactive');
obj.vtVObj.switchButton = button_('Switch');
obj.vtVObj.sectionButton = button_('Section');
set(L0_2_2_1_1_1_2,'sizes',[-0.6,-1,-1],'spacing',5,'padding',5);

uiextras.Empty('Parent',L0_2_2_1_1_1);
% section plane setting
set(L0_2_2_1_1_1,'sizes',[-0.18,-3.8,-1.2,-0.18],'spacing',5,'padding',0);
%--------------------------------------------------------------------------

% objective
L0_2_2_1_2 = uipanel('Parent',L0_2_2_1,...
    'Title','Objective','FontSize',10,'fontweight','bold');
obm = obj.mainMObj.objectiveMObj;
obv = obj.objectiveVObj;
L0_2_2_1_2_1 = uiextras.VBox('Parent',L0_2_2_1_2);
L0_2_2_1_2_1_1 = uiextras.Grid('Parent',L0_2_2_1_2_1);
% column 1
col1 = @(s,c)uicontrol('parent',L0_2_2_1_2_1_1,...
    'style','togglebutton','string',s,...
    'fontweight','bold','BackgroundColor',c,...
    'ForegroundColor','w','enable','inactive');
try
    obv.xStateText = col1(obm.xState,...
        obv.xColor(ismember(obv.xPair,obm.xState),:));
    obv.zStateText = col1(obm.zState,...
        obv.zColor(ismember(obv.zPair,obm.zState),:));
catch
    obv.xStateText = col1(obm.xState,[0.5,0.5,0.5]);
    obv.zStateText = col1(obm.zState,[0.5,0.5,0.5]);
end
% column 2
col2_3 = @(s)uicontrol('parent',L0_2_2_1_2_1_1,...
    'style','pushbutton','string',s,'fontweight','bold');
obv.to16XButton = col2_3('16X');
obv.raiseButton = col2_3('Rasie');
obv.to40XButton = col2_3('40X');
obv.pulldownButton = col2_3('Pulldown');
set(L0_2_2_1_2_1_1,'rowsizes',[-1,-1],...
    'columnsizes',[-0.8,-1,-1],'spacing',8,'padding',5);

L0_2_2_1_2_1_2 = uiextras.HBox('Parent',L0_2_2_1_2_1);
button_ = @(s)uicontrol('parent',L0_2_2_1_2_1_2,...
    'style','pushbutton','string',s,'fontweight','bold');
obv.setFocusPlaneButton = button_('Set here FP');
obv.alignButton = button_('Align BP and FP');
set(L0_2_2_1_2_1_2,'sizes',[-1,-1],'spacing',5,'padding',1);
% objective plane setting
set(L0_2_2_1_2_1,'sizes',[-2,-0.8],'spacing',5,'padding',5);
%--------------------------------------------------------------------

% section and objective planes setting
set(L0_2_2_1,'sizes',[-1.45,-1],'spacing',7,'padding',0);
%--------------------------------------------------------------------

% imaging
L0_2_2_2 = uipanel('Parent',L0_2_2,...
    'Title','Imaging','FontSize',10,'fontweight','bold');
L0_2_2_2_1 = uiextras.HBox('Parent',L0_2_2_2);
L0_2_2_2_1_1 = uiextras.VBox('Parent',L0_2_2_2_1);
L0_2_2_2_1_1_1 = uiextras.HBox('Parent',L0_2_2_2_1_1);
uicontrol('Parent',L0_2_2_2_1_1_1,...
    'style','text','string','Pipeline',...
    'horizontalalignment','left','fontweight','bold');
obj.userVObj.pipelinePopup = uicontrol('parent',L0_2_2_2_1_1_1,...
    'style','popupmenu','string','General|Smart',...
    'horizontalalignment','left','Value',2);
uiextras.Empty('Parent',L0_2_2_2_1_1_1);
uiextras.Empty('Parent',L0_2_2_2_1_1_1);
set(L0_2_2_2_1_1_1,'sizes',[-0.2,-0.3,-0.2,-0.2],'spacing',0,'padding',0);

L0_2_2_2_1_1_2 = uiextras.VBox('Parent',L0_2_2_2_1_1);
uicontrol('Parent',L0_2_2_2_1_1_2,...
    'style','text','string','Save images to',...
    'horizontalalignment','left','fontweight','bold');
L0_2_2_2_1_1_2_1 = uiextras.HBox('Parent',L0_2_2_2_1_1_2);
obj.userVObj.imSavePathEdit = uicontrol('Parent',L0_2_2_2_1_1_2_1,...
    'style','edit','horizontalalignment','left','tag',obj.imParameterTag);
obj.userVObj.browseButton = uicontrol('parent',L0_2_2_2_1_1_2_1,...
    'style','pushbutton','string','Browse','fontweight','bold');
set(L0_2_2_2_1_1_2_1,'sizes',[-3,-1],'spacing',5,'padding',0);
set(L0_2_2_2_1_1_2,'sizes',[-0.2,-0.24],'spacing',0,'padding',0);

L0_2_2_2_1_1_3 = uiextras.Grid('Parent',L0_2_2_2_1_1);
% column 1
col_em = @()uiextras.Empty('Parent',L0_2_2_2_1_1_3);
col1_3 = @(s,tip)uicontrol('Parent',L0_2_2_2_1_1_3,...
    'style','text','string',s,'TooltipString',tip,...
    'horizontalalignment','right','fontweight','bold');
col1_3('Objective','');
col1_3('Scan Freq.','Z Scan Frequency');
col1_3('ROIs Freq.','ROIs Determine Frequency');
col1_3('Sec. Freq.','Section Frequency');
col_em(); % reserved

% column 2
col2_4 = @(tip,p)uicontrol('Parent',L0_2_2_2_1_1_3,...
    'style','edit','TooltipString',tip,'Tag',obj.imParameterTag,...
    'horizontalalignment','left','string',p);
obj.userVObj.objectivePopup = uicontrol('parent',L0_2_2_2_1_1_3,...
    'style','popupmenu','string','16X|40X','enable','off',...
    'horizontalalignment','left');
obj.userVObj.zScanRateEdit = col2_4('Image every ? microns along z axis','30');
obj.userVObj.ROIsDetermineRateEdit = ...
    col2_4(sprintf('%s\n%s',...
    'Determine ROIs of a slice every ? microns along z axis,',...
    'need be a multiple of Z Scan Freq.'),'1350');
obj.userVObj.sectionRateEdit = col2_4(sprintf('%s\n%s\n%s',...
    'Section every ? microns along z axis,',...
    'need be a multiple of ROIs Deter. Freq.,',...
    'need be bigger than 70 microns for good section'),'270');
col_em(); % reserved

% column 3
col_em();
col1_3('Z Max.','Z Max. Limt');
col1_3('Sec. Overlap','Section overlap');
col1_3('Obj. delta','Objective delta between 16x and 40x');
col_em(); % reserved

% column 4
col_em();
obj.userVObj.zMaxLimtEdit = col2_4('Image ? mm thickness of sample.','10');
obj.userVObj.zSectionOverlapEdit = col2_4('Overlap ? microns of twice section.','75');
obj.userVObj.objDeltaEdit = col2_4('40x need stage up ? mm.',...
    num2str(-obj.mainMObj.objectiveMObj.deltaFocusStageZMove));
col_em(); % reserved
set(L0_2_2_2_1_1_3,'rowsizes',[-0.1,-0.1,-0.1,-0.1,0],...
    'columnsizes',[-0.3,-0.2,-0.35,-0.2],'spacing',4,'padding',0);

L0_2_2_2_1_1_4 = uipanel('Parent',L0_2_2_2_1_1,...
    'Title','Tissue Dect. Method','fontweight','bold');
L0_2_2_2_1_1_4_1 = uiextras.HBox('Parent',L0_2_2_2_1_1_4);
L0_2_2_2_1_1_4_1_1 = uiextras.HBox('Parent',L0_2_2_2_1_1_4_1);
obj.userVObj.edMethodUibuttongroup = uibuttongroup(L0_2_2_2_1_1_4_1_1);
bg = obj.userVObj.edMethodUibuttongroup;
uiradiobutton_ = @(s,pos)uicontrol(bg,'Style','radiobutton',...
                  'String',s,...
                  'Position',pos,...
                  'HandleVisibility','off');
uiradiobutton_('Auto',[6,26,70,20]); % pos need change eveytime
uiradiobutton_('Rectangle',[6 4 70 20]);

L0_2_2_2_1_1_4_2 = uiextras.Grid('Parent',L0_2_2_2_1_1_4_1);
col1 = @(s,tip)uicontrol('Parent',L0_2_2_2_1_1_4_2,...
    'style','text','string',s,'TooltipString',tip,...
    'horizontalalignment','right','fontweight','bold');
col2 = @(tip,p)uicontrol('Parent',L0_2_2_2_1_1_4_2,...
    'style','edit','TooltipString',tip,'Tag',obj.imParameterTag,...
    'horizontalalignment','left','string',p);
col1('BGT','Background Threshold');
col1('DFC','Distance from manual center.');

obj.userVObj.detectBgThresholdEdit = col2(sprintf('%s\n%s\n%s',...
    'Used for dertemine background ROIs,tipical is 0.7.',...
    '0.7 means 0.7 quantiles of the values in captured im is',...
    'bigger than 0.7 quantiles of the values in background.'),'0.98');
obj.userVObj.distanceFromCenterEdit = col2('up,down,left,right','');
obj.userVObj.distanceFromCenterEdit.Enable = 'off';
obj.userVObj.distanceFromCenterEdit.Tag = 'DFC';
set(L0_2_2_2_1_1_4_2,'rowsizes',[-0.1,-0.1],...
    'columnsizes',[-0.2,-0.8],'spacing',4,'padding',3);


set(L0_2_2_2_1_1_4_1,'sizes',[-1,-2],'spacing',0,'padding',2);

uiextras.Empty('Parent',L0_2_2_2_1_1);
set(L0_2_2_2_1_1,'sizes',[-0.1,-0.16,-0.48,-0.32,-0.1],'spacing',7,'padding',8)
%---------------------------------------------------------------------------

L0_2_2_2_1_2 = uiextras.VBox('Parent',L0_2_2_2_1);
col_em = @()uiextras.Empty('Parent',L0_2_2_2_1_2);
button_ = @(s,e)uicontrol('parent',L0_2_2_2_1_2,...
    'style','pushbutton','string',s,'fontweight','bold',...
    'enable',e);

obj.userVObj.recordPosButton = button_('Rec. Pos.','on');
obj.userVObj.move2RecPosButton = button_('Move Pos.','on');
col_em();
obj.userVObj.tryDetectButton = button_('Try ROIs','on');
col_em();
obj.userVObj.runButton = button_('Run','on');
obj.userVObj.pauseButton = uicontrol('parent',L0_2_2_2_1_2,...
    'style','togglebutton','string','Pause',...
    'fontweight','bold','enable','off');
obj.userVObj.stopButton = button_('Stop','off');
set(L0_2_2_2_1_2,'sizes',[-0.1,-0.1,-0.3,-0.1,-0.1,-0.1,-0.1,-0.1],...
    'spacing',5,'padding',10)

set(L0_2_2_2_1,'sizes',[-0.75,-0.25],'spacing',5,'padding',0);
%--------------------------------------------------------------------
uiextras.Empty('Parent',L0_2_2);
set(L0_2_2,'sizes',[-0.273,-0.42,-0.307],'spacing',15,'padding',0);
%% rightLayout, setting
set(L0_2,'sizes',[-2,-1],'spacing',10,'padding',5);
%% mainLayout, setting
set(L0,'sizes',[-1,-2],'spacing',10);
%% change camera axes size
pause(1);
set(obj.cameraVObj.axCamera,'Units','Normalized',...
    'Position',[0.198,0.12,0.5978,0.8587],'Visible','on'); % 0.6962 times
end