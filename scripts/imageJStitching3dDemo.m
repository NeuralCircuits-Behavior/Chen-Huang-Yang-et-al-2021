  
filePath = 'E:\Data\CH\20190517_HN169_S\1st';
sortDir = 'ascend';% 16x is 'descend';
pixelSize = 0.27361;% 40x:0.27361; 16x:0.75576; % um per pixel
%center = [37.5,19]; %m.stageMObj.manualSampleCenter
%resizeFactor = 1;
xyOverlap = 0.1;%1 - 3*(1-0.1)*0.27361/0.75576;  %0.1;
closestDist = 0.45;%round(pixelSize * 1200*0.9 /1000 * sqrt(2),2);
zSliceRangeSelected = [];%1:241; % could be []

subFolder = '40X';
fDeleteOrignalData = 0;

stitchingP.regression_threshold = 0;
stitchingP.max_avg_displacement_threshold = 2.50;
stitchingP.absolute_displacement_threshold = 3.50;
stitchingP.compute_overlap = 'compute_overlap '; % ''
stitchingP.subpixel_accuracy = 'subpixel_accuracy ';
stitchingP.image_output = 'image_output=[Fuse and display] ';
stitchingP.computation_parameters = '[Save memory (but be slower)]';
%---------------------------------------------------------------
filePathSection = dir(fullfile(filePath,'Section_*'));
filePathSection = {filePathSection.name};
%%
%for f0 = 1:3

f0 = 10:11;
%{
[minXY,maxXY] = deal(center);
for f = f0%3:numel(filePathSection)
    filePathSection_ = fullfile(filePath,filePathSection{f},subFolder);
    [xyzExp,xyzExa,list] = func_getStagePositionsFromFilenames(filePathSection_);
    minXY = min([xyzExa(:,1:2);minXY]);
    maxXY = max([xyzExa(:,1:2);maxXY]);
end
szFull = fliplr(round((maxXY - minXY)*1000/pixelSize)+1200+120); 
% +1200 because stage position is center position,which is half of the whole roi
% size [r c] is flipped
szFull = round(szFull*resizeFactor);
%}
%%
%Miji(0);

for f = f0%[3:7,8:4:numel(filePathSection)]
    fprintf('\n%04d\n',f-1);
    try
        filePathSection_ = fullfile(filePath,filePathSection{f},subFolder);
        [xyzExp,xyzExa,list] = func_getStagePositionsFromFilenames(filePathSection_);
        
        [xyzExpSorted,idx] = sortrows(xyzExp,[2,1,3],sortDir);
        xyzExaSorted = xyzExa(idx,:);
        listSorted = list(idx,:);
        
        [xyzExpUniquexy,~,idx] = unique(xyzExpSorted(:,1:2),'rows','stable');
        
        %coord = zeros(4,3);
        %[coordExp,coord] = deal(zeros(size(xyzExpUniquexy,1),3));
        
        sStack = struct();
        for iStack = 1:size(xyzExpUniquexy,1) 
            idxs = find(idx == iStack);
            sStack(iStack).coordExa = xyzExaSorted(idxs(1),1:2);
            sStack(iStack).coordExp = xyzExpSorted(idxs(1),1:2);
            sStack(iStack).fileList = listSorted(idxs);
        end
        
        T = cluster_(cat(1,sStack.coordExp),closestDist);
        [T,order] = sort(T); % T is group name
        sStack = sStack(order);
        % fool
        for iStack = 1:numel(sStack)
            sStack(iStack).group = T(iStack);
        end
        
        figure;
        tmp = cat(1,sStack.coordExp);
        scatter(tmp(:,1),tmp(:,2),30,T,'filled')        
        set(gca,'YDir','reverse')
        title(sprintf('%04d',f-1));
        savefig(gcf,fullfile(filePathSection_,'positions.fig'));
        clear tmp
        
        
        stackList = dir('');
        nchr = 0;
        for iStack = 1:numel(sStack)
            nchr = func_printProcess(nchr,iStack,numel(sStack));
            stackName = sprintf('stack_%03d_%03d.tif',...
                iStack,sStack(iStack).group);

            if isempty(zSliceRangeSelected)
                inputList = sStack(iStack).fileList;
            else
                inputList = sStack(iStack).fileList(zSliceRangeSelected);
            end
            func_combineSessionStack(inputList,stackName,fDeleteOrignalData);

            stackList(iStack) = dir(stackName);
        end
        
        tileConfigTxtSavePath = [];
        coord = zeros(numel(sStack),3);
        coord(:,1:2) = cat(1,sStack.coordExa);
        fName = func_createTileConfiguration(stackList,...
                coord,pixelSize,[],tileConfigTxtSavePath);
        filePathSection__ = filePathSection_;
        
        sectionName = regexp(filePathSection_,'Section_\d+','match');
        
        stitchingP.fileName = fullfile(filePathSection__,...
            [sectionName{1},'_stitched_all_stacks.tif']);
        %func_stitchingByFiji(filePathSection__,fName,0,stitchingP);

    catch ME
        disp(ME.message);
    end
    %{
    clearvars  -except ...
        filePath sortDir pixelSize center resizeFactor ...
        xyOverlap seprateSlices subFolder filePathSection szFull minXY
    %}
end
%MIJ.exit;
%end

function newT = cluster_(coord,closestDist)
T = clusterdata(coord,'cutoff',closestDist,'linkage','single','criterion','distance');
[~,seq] = sort(accumarray(T,1),'descend');
newT = interp1(seq, 1:numel(seq),T);
end