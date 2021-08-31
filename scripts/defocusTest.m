filePath = 'E:\Data\CH\20200702_H280\1st\Section_008\40X\*.tif';

fileList = dir(filePath);
N = numel(fileList);

figure('position',[382         476        1333         420]);
res = zeros(N,1);
for ii = 1:N
im = loadTifFast(fullfile(fileList(ii).folder,fileList(ii).name));


subplot(2,1,1);
imshow(squeeze(median(im,1))',[]);
subplot(2,1,2);
imshow(squeeze(mean(im,1))',[100,105]);

[~,res(ii)] = ginput(1);

clf;
end

[xyzExp,xyzExa,~] = func_getStagePositionsFromFilenames(fileparts(filePath));

figure;

scatter(xyzExp(:,1),xyzExp(:,2),50,res,'filled','Marker','s');

axis equal

%% 

filePath = 'E:\Data\CH\20200702_H280\2nd\Section_001\*.tif';

N = 28*28;
n = 0;
nn = 51;

figure;
res = zeros(N,1);
while n<N
    
    fl = dir(filePath);
    try
        fl_ = fl(nn*n+1:nn*(n+1));
    catch ME
        switch ME.identifier
            case 'MATLAB:badsubscript'
                disp('waiting...');
                pause(60*1);
            otherwise
                disp('unknown error.')
        end
        
        continue
    end
    
    n = n + 1;
    
    im = zeros(1200,1200,nn,'uint16');
    for ii = 1:nn
        im(:,:,ii) = imread(fullfile(fl_(ii).folder,fl_(ii).name));
    end
    
    if ~mod(n,2)
        im = flip(im,3);
    end
    
    beep2;
    subplot(2,1,1);
    imshow(squeeze(median(im,1))',[]);
    title(num2str(n));
    
    subplot(2,1,2);
    imshow(squeeze(mean(im,1))',[]);
    
    [~,res(n)] = ginput(1);
    
    clf;
end

