% 2018/4/1, CH

% use piezo to scan z 
% need mainMObj first

zScanRange = 1:150; % 100 um
savePath = 'D:\Data\confocalRelated\testData\imaging\40x_text_2_1A2S\600ms\';
%%
for z = 1:numel(zScanRange)

    % note piezo not confirm static
    tic
    m.piezoMObj.movePiezo(zScanRange(z)); 
    t1 = toc;
    tic;
    imName = sprintf('%s%03d.tif',savePath,zScanRange(z));
     writeTifFast(imName,m.cameraMObj.captureImage(),16);
    t2 = toc;
    fprintf('%03d image finished. Piezo move took %.2f ms, Imaging took %.2f ms.\n',...
        z,t1*1000,t2*1000);
end