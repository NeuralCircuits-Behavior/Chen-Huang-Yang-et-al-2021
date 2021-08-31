  
filePath = 'E:\Data\CH\20190530_F183_S\1st';

sortDir = 'ascend';% 16x is 'descend';
pixelSize = 0.27361;% 40x:0.27361; 16x:0.75576; % um per pixel
%center = [37.5,19]; %m.stageMObj.manualSampleCenter
%resizeFactor = 1;
xyOverlap = 0.1;%1 - 3*(1-0.1)*0.27361/0.75576;  %0.1;
closestDist = 0.45;%round(pixelSize * 1200*0.9 /1000 * sqrt(2),2);
zSliceRangeSelected = [];%1:241; % could be []

subFolder = '40X';
fDeleteOrignalData = 0;

%---------------------------------------------------------------
savePath = fullfile(filePath,'TeraStitchFiles_12-15');
warning('off','MATLAB:MKDIR:DirectoryExists');
mkdir(savePath);
filePathSection = dir(fullfile(filePath,'Section_*'));
filePathSection = {filePathSection.name};
%% cluster

f0 = 1:53;%10:13;
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
    end
end

T = cluster_(cat(1,sStack.coordExp),closestDist);
[T,order] = sort(T); % T is group name
sStack = sStack(order);
% fool
for iStack = 1:numel(sStack)
    sStack(iStack).group = T(iStack);
end
scatter3_ = @(c,T)scatter3(c(:,1),c(:,2),c(:,3),...
    30,T,'filled','MarkerFaceAlpha',0.5);
figure;
scatter3_(cat(1,sStack.coordExp),[sStack.group]);
fprintf('Done.\n\n')
%%
fprintf('Processing...')
nchr = 0;
N = nnz([sStack.group]==1); % only combine sStack.group

Miji(0);

for iStack = 1:numel(sStack)
    
    % only combine sStack.group
    if sStack(iStack).group > 1
        continue
    end
    
    nchr = func_printProcess(nchr,iStack,N);
    [rootName1,rootName2,stackName] = getRootNames(sStack(iStack).coordExp);
        
    if isempty(zSliceRangeSelected)
        inputList = sStack(iStack).fileList;
    else
        inputList = sStack(iStack).fileList(zSliceRangeSelected);
    end
    
    saveDir = fullfile(savePath,rootName1,rootName2);
    mkdir(saveDir); % warning already off
    func_combineSessionStackWithPreprocess(inputList,stackName,fDeleteOrignalData,saveDir);
end
fprintf('Done.\n')
MIJ.exit;

function newT = cluster_(coord,closestDist)
T = clusterdata(coord,'cutoff',closestDist,'linkage','single','criterion','distance');
[~,seq] = sort(accumarray(T,1),'descend');
newT = interp1(seq, 1:numel(seq),T);
end

function [rootName1,rootName2,rootName3] = getRootNames(c)
y = num2str(round(c(2)*10000),'%06d'); 
x = num2str(round(c(1)*10000),'%06d'); 
z = num2str(round(c(3)*10000),'%06d'); 

rootName1 = y; %y
rootName2 = sprintf('%s_%s',y,x); %y_x
rootName3 = sprintf('%s_%s_%s.tif',y,x,z); %y_x_z
end