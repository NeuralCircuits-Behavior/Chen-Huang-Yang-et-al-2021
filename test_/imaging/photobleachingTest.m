[t0,t1] = deal(clock);
timeLimtBase = 30*60; %s
captureEvery = 60; %s
expTime = 2;% s
imStack = zeros(1200,1200,...
    ceil(timeLimt/captureEvery),'uint16');

fContinue = 1;
n = 0;
timeLimt = timeLimtBase + ...
    ceil(timeLimt/captureEvery)*3*expTime;

while fContinue
    eT = etime(clock,t1);
    if eT >= captureEvery
        n = n + 1;
        fprintf('NO.%d image, finish %.1f%%. '...
            , n , etime(clock,t0)/timeLimt*100);
        temp = zeros(1200,1200,3,'uint16');
        for k = 1:3
            tic;
            temp(:,:,k) = mainMObj.cameraMObj.captureImage();
            t = toc;
            fprintf('Sub.%d took %.1fs.',k,t);
        end
        fprintf('\n');
        imName = sprintf('%s%03d.tif',...
            'D:\Data\confocalRelated\testData\bleaching\',...
            n+150);
        
        imStack(:,:,n) = mean(temp(:,:,2:3),3);
        writeTifFast(imName,imStack(:,:,n),16);
        t1 = clock;
    else
        pause(0.002);
    end
    
    
    if etime(clock,t0) >= timeLimt
        fContinue = 0;
        disp('Finish all.')
    end
end

imStack(:,:,n+1:end) = [];

