% 2018/10/7, CH
% 40x slice imaging

clear
clc
m = Context.getInstance().getData('mainMObj');

% setting----------------------
halfSideLenXY = [0,0];
centerPos = m.stageMObj.manualSampleCenter;
% centerPos =[6.8555 12.6308];
zScange = 0:0.5:60; % um
m.cameraMObj.changeExposureTime(400);   % ms
savePath = 'E:\Data\test\20210118_psf_exposure\2nd';
%--------------------------------

if ~exist(savePath,'file')
    mkdir(savePath);
end

stepxy = [m.stageMObj.stepx,m.stageMObj.stepy];
iniZPos = [m.stageMObj.getZCurrentPosition(),m.piezoMObj.getPosition()];
ROIxy = determineROIXY(stepxy,centerPos,halfSideLenXY);

ax = iniFigure(ROIxy);
m.csuObj.openShutter();

% main loop
nxy = 0;
nz = 0;
rpN = 25;
for ixy = 1:size(ROIxy,1)
    nxy = nxy + 1;
    m.stageMObj.moveAbsolute('XY',ROIxy(ixy,:));
    updateFigure(ax,ROIxy(ixy,:));
    m.stageMObj.waitForStageStatic();
    z = getZRange(nxy,zScange);
    for iz = z + iniZPos(2)
        nz = nz + 1;
        m.piezoMObj.movePiezo(iz);
        imName = getImName(savePath,nz,...
            ROIxy(ixy,:),iz,getImAbsPosition(m,iniZPos));
        %m.piezoMObj.waitForPiezoStatic(iz);
        pause(0.1);% piezo typical step time
        im = zeros(1200,1200,rpN,'uint16');
        for rp = 1:rpN
            pause(0.01);% piezo typical step time
            im(:,:,rp) = m.cameraMObj.captureImage();
        end
        m.cameraMObj.saveImage(median(im,3),imName);
    end
end
m.csuObj.closeShutter();
m.cameraMObj.changeExposureTime(80);   % ms
m.piezoMObj.movePiezo(0);

% local functions -----------------------------------------
function ROIxy = determineROIXY(stepxy,centerPos,halfSideLenXY)
x = (centerPos(1) + halfSideLenXY(1)):...
    -stepxy(1):(centerPos(1) - halfSideLenXY(1));
y = (centerPos(2) + halfSideLenXY(2)):...
    -stepxy(2):(centerPos(2) - halfSideLenXY(2));
[ROIx,ROIy] = meshgrid(x,y);
ROIx = flipEven(ROIx)';
ROIy = flipEven(ROIy)';
ROIxy = [ROIx(:),ROIy(:)];

    function array = flipEven(array)
        array(2:2:end,:) = fliplr(array(2:2:end,:));
    end
end

function ax = iniFigure(ROIxy)
f = figure;
ax = axes(f);
ax.NextPlot = 'add';
scatter(ax,ROIxy(:,1),ROIxy(:,2));
axis square
axis equal
xlim([min(ROIxy(:,1)),max(ROIxy(:,1))]+[-0.25,0.25]);
ylim([min(ROIxy(:,2)),max(ROIxy(:,2))]+[-0.25,0.25]);
end

function updateFigure(ax,xy)
plot(ax,xy(1),xy(2),'k+');
end

function z = getZRange(n,z)
if ~mod(n,2)
    z = fliplr(z);
end
end

function imName = getImName(savePath,no,iROIxy,iz,posExa)
imName = fullfile(savePath,...
    sprintf('%06d_exp_%sexa_%s.tif',...
    no,num2str([iROIxy,iz],'%.4f_'),num2str(posExa,'%.4f_')));
end

function pos = getImAbsPosition(m,iniZPos)
% output pos is convert to stage position
xy = m.stageMObj.getXYCurrentPosition();
z = iniZPos(1) - (m.piezoMObj.getPosition() - iniZPos(2))/1000;
pos = [xy,z];
end