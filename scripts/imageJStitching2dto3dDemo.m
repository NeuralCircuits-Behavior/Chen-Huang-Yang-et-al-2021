  
filePath = 'E:\Data\LJJ\20201221_20L_27';
sortDir = 'descend';% 16x is 'descend';
pixelSize = 1.1001;% 40x:0.27361; 16x:0.75576; % um per pixel 10x:1.0893, 25x: 0.4651 in air 10x:1.1001 25x:0.4454 in oil
center = [18.5,18.5]; %m.stageMObj.manualSampleCenter
resizeFactor = 0.8;
xyOverlap = 0.0890;%1 - 3*(1-0.1)*0.27361/0.75576;  %0.1;
seprateSlices = 0;
subFolder = '';

%---------------------------------------------------------------
filePathSection = dir(fullfile(filePath,'Section_*'));
filePathSection = {filePathSection.name};



%%
%for f0 = 1:3
f0 = 1:numel(filePathSection);%[8,10,14,16,17,18,27];%1: numel(filePathSection);
[minXY,maxXY] = deal(center);
for f = f0%3:numel(filePathSection)
    filePathSection_ = fullfile(filePath,filePathSection{f},subFolder);
    filePathSection_ = [filePathSection_,'\16X']; % added by LJJ at 2020/11/8
    [xyzExp,xyzExa,list] = func_getStagePositionsFromFilenames(filePathSection_);
    minXY = min([xyzExa(:,1:2);minXY]);
    maxXY = max([xyzExa(:,1:2);maxXY]);
end
szFull = fliplr(round((maxXY - minXY)*1000/pixelSize)+1200+120); 
% +1200 because stage position is center position,which is half of the whole roi
% size [r c] is flipped
szFull = round(szFull*resizeFactor);

%%
Miji(0);
for f = f0%[3:7,8:4:numel(filePathSection)]
    fprintf('%04d\n',f-1);
    %try
        filePathSection_ = fullfile(filePath,filePathSection{f},subFolder);
        filePathSection_ = [filePathSection_,'\16X']; %  added by LJJ at 2020/11/8
        [xyzExp,xyzExa,list] = func_getStagePositionsFromFilenames(filePathSection_);
        [xyzExpSorted,idx] = sortrows(xyzExp,3,sortDir);
        xyzExaSorted = xyzExa(idx,:);
        listSorted = list(idx,:);
        tf = diff(xyzExpSorted(:,3)) ~= 0;
        sliceIdx = repelem((1:nnz(tf)+1)',diff([0;find(tf);size(xyzExpSorted,1)]));
        
        %imStitchedSection = zeros([szFull,max(sliceIdx)],'uint16');
        imStitchedSection = zeros([szFull,1],'uint16');
        for s = 1:max(sliceIdx)
            sliceNo = s;
            
            if seprateSlices
                slicePath = createSliceDir(filePathSection_,sliceNo);
                tileConfigTxtSavePath = slicePath;
            else
                tileConfigTxtSavePath = [];
            end
            
            sliceTf = sliceIdx == sliceNo;
            coord = xyzExpSorted(sliceTf,1:2);% note here
            fName = func_createTileConfiguration(listSorted(sliceTf),...
                coord,pixelSize,sliceNo,tileConfigTxtSavePath);
            
            if seprateSlices
                arrayfun(@(l)movefile(fullfile(l.folder,l.name),slicePath),...
                    listSorted(sliceTf));
                filePathSection__ = slicePath;
            else
                filePathSection__ = filePathSection_;
            end
            
            imStitched = func_stitchingByFiji(filePathSection__,fName,0);
            sz = size(imStitched);
            sz = round(sz*resizeFactor);
            imStitched = imresize(imStitched,sz);
            szDelta = szFull - sz;
            minXY_ = min(coord);
            szPadUL = round((fliplr((minXY_ - minXY)*1000/pixelSize)+60)*resizeFactor); % upper and left
            szPadLR = szDelta - szPadUL; % LOWER and RIGHT\
            %{
            imStitchedSection(:,:,s) = padarray(...
                padarray(imStitched,szPadUL,0,'pre'),szPadLR,0,'post');
            %}
            imStitchedSection = max(imStitchedSection,...
                padarray(...
                padarray(imStitched,szPadUL,0,'pre'),szPadLR,0,'post'));
        end
        func_writeTifFast(...
            fullfile(filePathSection_,strcat(filePathSection{f},...
            '_resolution_max_projection.tif')),...
            max(imStitchedSection,[],3),16);
        %{
    func_writeTifFast(...
        fullfile(filePathSection_,strcat(filePathSection{f},...
        num2str(resizeFactor,'_%.2fds'),'.tif')),...
        imresize3(imStitchedSection,[round(szFull*resizeFactor),s]),16);
            %}
            func_writeTifFast(...
                fullfile(filePathSection_,strcat(filePathSection{f},...
                num2str(resizeFactor,'_%.2fds'),'.tif')),imStitchedSection,16);
            try
                delete(fullfile(filePathSection_,'img_t1_z1_c1'));
            catch
            end
    %catch ME
        %disp(ME.message);
    %end
    clearvars  -except ...
        filePath sortDir pixelSize center resizeFactor ...
        xyOverlap seprateSlices subFolder filePathSection szFull minXY
end
%MIJ.exit;
%end
function slicePath = createSliceDir(filePathSection_,sliceNo)
slicePath = fullfile(filePathSection_,num2str(sliceNo,'Slice_%03d'));
if ~exist(slicePath,'dir')
    mkdir(slicePath);
end
end