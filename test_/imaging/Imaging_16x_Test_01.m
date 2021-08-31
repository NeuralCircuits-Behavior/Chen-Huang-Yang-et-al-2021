% 2018/3/13, CH
% need run XDemo.m to create mainMObj and mainVObj first
% used to get serial images blew and upper focus plane 
% futher use pixelSizeTestAnalysis to calculte pixelSize

%% 40x
zStepRange = 6.086:0.001:6.185; % test first

port = 'COM2';
    % infoO = instrhwinfo('serial');
    % will create a info object which could be used to
    % check which port is availabel.
    
    % fclose(instrfind('type','serial'));
    % could close all serial port
    
targetPosition = [nan,nan]; % 40x is at [1,117762], [X,Z],nan means static
%------------------------------------------------------------------------

mainMObj = m;
imStack = mainFunc(mainMObj,zStepRange,port,targetPosition);

%%
function imStack = mainFunc(mainMObj,zStepRange,port,targetPosition)

objectiveStageOperate(port,targetPosition);

imStack = zeros(1200,1200,numel(zStepRange),'uint16');
n = 0;
for zPos = zStepRange
    n = n+1;
    fprintf('%-4d%.4f ',n,zPos);
    zStep(mainMObj,zPos);
    pause(1);
    imStack(:,:,n) = captureIm(mainMObj);
    fprintf('done\n ');
end
end

function zStep(mainMObj,zPos)
mainMObj.stageMObj.moveAbsolute('Z',zPos);
mainMObj.stageMObj.waitForStageStatic();
end

function im = captureIm(mainMObj)
im = mainMObj.cameraMObj.captureImage();
end


