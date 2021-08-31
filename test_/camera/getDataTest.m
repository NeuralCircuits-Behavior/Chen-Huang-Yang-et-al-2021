inters = 1;
savePath = 'E:\Data\CH\20190917\psf\11.tif';% 'xx.tif'
piezo0 = 72; % p.dStartPiezoPosition(1)

if m.piezoMObj.ctrlMode=='I'
    m.piezoMObj.changeCtrl('E');
end
if isequal(m.tcpW.tcpObj2.Status,'closed')
    fopen(m.tcpW.tcpObj2);
end
if ~exist('iall','var')
    iall = 0;
end
if m.cameraMObj.exp40~=20
    m.cameraMObj.changeExposureTime(20);
end
m.cameraMObj.switch2HardwareTrigger();
m.csuObj.openShutter();

n = 0;
I = zeros(1200,1200,251,'uint16');
for i = 1:inters
    fprintf('%05d',i);
    tmp = p.zScanRange40([1,end]);
    iall = iall+1;
    if ~isodd(iall)
        tmp = flip(tmp);
    end
    piezoPar = func_structPiezoPars(tmp(1),tmp(2),p.speed,...
        piezo0);
    p.captureImage(m,piezoPar);
    
    %pause(2);
    
    %func_writeTifFast16(I,num2str(1,'test%03d.tif'));
    
    % either java thread or parfeval will lost 2 frames
    %func_writeStackJava(I,num2str(i,'test%03d.tif'));
    %parfeval(parp,@func_writeTifFast16,0,I,num2str(i,'test%03d.tif'));
    
    [ims,fError] = p.collectStackImagesMultiByMulti(m,2);

    n = n + fError;
    if fError
        fprintf('No.%d Error. Lost %d frames\n',n,nnz(ims(1,1,1,:)==0));
    else
        fprintf('\b\b\b\b\b');
    end
    
end

m.csuObj.closeShutter();
m.piezoMObj.changeCtrl('I');

if inters<2
    func_writeTifFast16(squeeze(ims),savePath);
end


