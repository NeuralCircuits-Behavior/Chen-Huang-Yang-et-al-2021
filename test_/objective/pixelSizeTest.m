% 2018/3/13, CH
% need run XDemo.m to create mainMObj and mainVObj first
% used to get serial images blew and upper focus plane 
% futher use pixelSizeTestAnalysis to calculte pixelSize

%% 40x
zStepRange = 8.037:0.001:8.0540; % test first

port = 'COM1';
    % infoO = instrhwinfo('serial');
    % will create a info object which could be used to
    % check which port is availabel.
    
    % fclose(instrfind('type','serial'));
    % could close all serial port
    
targetPosition = [nan,nan]; % 40x is at [1,117762], [X,Z],nan means static
%------------------------------------------------------------------------

imStack40 = main(mainMObj,zStepRange,port,targetPosition);

%% 16x
zStepRange = 11.468:0.001:11.575; % test first

port = 'COM1';
    % infoO = instrhwinfo('serial');
    % will create a info object which could be used to
    % check which port is availabel.
    
    % fclose(instrfind('type','serial'));
    % could close all serial port
    
targetPosition = [nan,nan]; % 16x is at [+144000,+117762],[X,Z],nan means static
% --------------------------------------------------------------------------

imStack16 = main(mainMObj,zStepRange,port,targetPosition);

%%
function imStack = main(mainMObj,zStepRange,port,targetPosition)

objectiveMove(port,targetPosition);

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

