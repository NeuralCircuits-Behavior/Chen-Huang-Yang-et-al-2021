filePath = 'E:\Data\CH\20190609_H188_S\1st';

sortDir = 'ascend';% 16x is 'descend';
pixelSize = 0.27361;% 40x:0.27361; 16x:0.75576; % um per pixel
%center = [37.5,19]; %m.stageMObj.manualSampleCenter
%resizeFactor = 1;
xyOverlap = 0.1;%1 - 3*(1-0.1)*0.27361/0.75576;  %0.1;
closestDist = 0.45;%round(pixelSize * 1200*0.9 /1000 * sqrt(2),2);
zSliceRangeSelected = 1:(241-9);%1:241; % could be []

subFolder = '40X';
fDeleteOrignalData = 0;

clusterSelected = 1; % could be [], select all

%---------------------------------------------------------------
savePath = fullfile(filePath,'BigStiticherFiles');
warning('off','MATLAB:MKDIR:DirectoryExists');
mkdir(savePath);
filePathSection = dir(fullfile(filePath,'Section_*'));
filePathSection = {filePathSection.name};
%% cluster

f0 = 1:48;%10:13;
sStack = struct([]);
fprintf('Preprocess...\n')
for f = f0%[3:7,8:4:numel(filePathSection)]
    fprintf('Section_%04d\n',f-1);
    
    nStack = numel(sStack);
    filePathSection_ = fullfile(filePath,filePathSection{f},subFolder);
    [xyzExp,xyzExa,list] = func_getStagePositionsFromFilenames(filePathSection_);
    
    [xyzExpSorted,idx] = sortrows(xyzExp,[2,1,3],sortDir);
    xyzExaSorted = xyzExa(idx,:);
    listSorted = list(idx,:);
    
    [xyzExpUniquexy,~,idx] = unique(xyzExpSorted(:,1:2),'rows','stable');
    
    for iStack = 1:size(xyzExpUniquexy,1)
        idxs = find(idx == iStack);
        sStack(nStack+iStack).coordExa = xyzExaSorted(idxs(1),1:3);
        sStack(nStack+iStack).coordExp = [xyzExpSorted(idxs(1),1:2),xyzExaSorted(idxs(1),3)];
        sStack(nStack+iStack).fileList = listSorted(idxs);
        sStack(nStack+iStack).sectionIdx = f;
    end
end

T = cluster_(cat(1,sStack.coordExp),closestDist);
[T,order] = sort(T); % T is group name
sStack = sStack(order);

center = mean(cat(1,sStack.coordExa));
center(3) = sStack(1).coordExa(3);

% fool
for iStack = 1:numel(sStack)
    sStack(iStack).group = T(iStack);
    sStack(iStack).coordExaPixel = (sStack(iStack).coordExa - center)...
        ./[pixelSize,pixelSize,-1].*1000; % z is from big to small
end
scatter3_ = @(c,T)scatter3(c(:,1),c(:,2),c(:,3),...
    30,T,'filled','MarkerFaceAlpha',0.5);
figure;
scatter3_(cat(1,sStack.coordExaPixel),[sStack.group]);
savefig(fullfile(filePath,'coordExaPixel.fig'));
%save(fullfile(filePath,'sStack.mat'),'sStack','-v7.3');
fprintf('Done.\n\n')

%% write stacks to disk

if isempty(clusterSelected)
    clusterSelected = unique(T);
end

if isempty(zSliceRangeSelected)
    zSliceRangeSelected = 1:numel(sStack(1).fileList);
end

for cl = reshape(clusterSelected,1,[])
    savePath_ = fullfile(savePath,num2str(cl,'%03d'));
    mkdir(savePath_);
    fprintf('Processing %s...',savePath_);

    stackIdx = find([sStack.group]==cl);
    
    
    func_createTileConfigurationForBigStitcher(stackIdx,...
        cat(1,sStack(stackIdx).coordExaPixel),savePath_);
    %}
    fileLists = {sStack(stackIdx).fileList};
    for iStack = 1:numel(stackIdx)
        fileName = num2str(iStack-1,'stack_%05d.tif');
        func_combineSessionStack(...
            fileLists{iStack}(zSliceRangeSelected),...
            fileName,0,savePath_,0);
    end
    fprintf('done.\n');
end
%%
function newT = cluster_(coord,closestDist)
T = clusterdata(coord,'cutoff',closestDist,'linkage','single','criterion','distance');
[~,seq] = sort(accumarray(T,1),'descend');
newT = interp1(seq, 1:numel(seq),T);
end