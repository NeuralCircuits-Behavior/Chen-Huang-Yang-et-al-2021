
sectionName = 'E:\Data\CH\20200114_Y18-2\1st\Section_002';
labelsPath = 'E:\Data\CH\20200704_16X\label_Y18_S2.xlsx';

thres = 1:12;

magFolder = '16X';

saveFolder = '16XDetectorTest1';

f = figure('Visible','off');

fprintf('%s\n',anmName{ianm});
sections = dir([sectionName,'*']);

isession = 1;
fprintf('  %s\n',sections(isession).name);
filePathSection_ = fullfile(sections(isession).folder,sections(isession).name,magFolder);
[xyzExp,~,ims] = func_getStagePositionsFromFilenames(filePathSection_);
%ims = dir(fullfile(sections(isession).folder,sections(isession).name,magFolder,'*_.tif'));
[~,~,ic] = unique(xyzExp(:,1:2),'rows','stable');
imName = string({ims.folder})+'\'+string({ims.name});
K = unique(ic,'stable')';
labels = readtable(labelsPath);
labels = labels.labels; % cell
out = zeros(numel(K),5,numel(thres)); % n_ims x [FN,FP,TN,TP,TOTAL] x n_thres
nt = 0;
for thre = thres
    nt = nt + 1;
    saveFolder_ = [saveFolder,'thre_',num2str(thre)];
    mkdir(fullfile(sections(isession).folder,sections(isession).name,saveFolder_));
    fprintf('    thre_%d\n',thre);
    nk = 0;
    for k = K %1:numel(imName)
        %fprintf('    %s\n',ims(k).name);
        
        %[im,result] = singleProcess(char(imName(k)));
        nk = nk + 1;
        imNames = imName(ic==k);
        [im,result] = stackProcess(imNames,thre);
        
        clf;
        
        montage(repmat(reshape(imSegment(im),512,512,1,9),1,1,3,1));
        
        strPrint = sprintf('%s %s %s',...
            num2str(result(1:3),'%d'),...
            num2str(result(4:6),'%d'),...
            num2str(result(7:9),'%d'));
        text(100,100,[strPrint,' / ',labels{nk}],'Color','r','FontWeight','bold');
        
        [rootPath,imName1] = fileparts(imNames(1));
        [~,imName2] = fileparts(imNames(end));
        rootPath = strrep(rootPath,magFolder,saveFolder_);
        saveName = fullfile(char(rootPath),char(regexp_(imName1)+'_'+regexp_(imName2)+'.jpg'));
        
        %{
            saveName = strrep(imName(k),magFolder,saveFolder);
            saveName = strrep(saveName,'.tif','.jpg');
        %}
        saveas(f,saveName);
        
        if isequal(labels{nk},'-')
            continue
        end
        
        res = num2str(result,'%d');
        out(nk,1,nt) = nnz(res=='0' & labels{nk}=='1'); % FN
        out(nk,2,nt) = nnz(res=='1' & labels{nk}=='0'); % FP
        out(nk,3,nt) = nnz(res=='0' & labels{nk}=='0'); % TN
        out(nk,4,nt) = nnz(res=='1' & labels{nk}=='1'); %TP
        out(nk,5,nt) = sum(out(nk,1:4,nt));
    end
end

disp('Done.')

%%
function [im,result] = singleProcess(name)
im = imread(name);
result = func_sigDetctor16(im);
end

function [im,result] = stackProcess(names,thre)
im = zeros(1200,1200,'uint16');
for k = 1:numel(names)
    im = max(im,imread(char(names(k))));
end
result = func_sigDetctor16(im,thre);
end

function ims = imSegment(img)

z1 = 426;
z0 = 434;
z2 = 43;
ims = zeros(512,512,9,'uint16');
ims(:,:,1) = imresize_(img(1:z1, 1:z1));
ims(:,:,2) = imresize_(img(1:z1, z1-z2:z1-z2+z0));
ims(:,:,3) = imresize_(img(1:z1, end-z1:end));

ims(:,:,4) = imresize_(img(z1-z2:z1-z2+z0, 1:z1));
ims(:,:,5) = imresize_(img(z1-z2:z1-z2+z0, z1-z2:z1-z2+z0));
ims(:,:,6) = imresize_(img(z1-z2:z1-z2+z0, end-z1:end));

ims(:,:,7) = imresize_(img(end-z1:end,1:z1));
ims(:,:,8) = imresize_(img(end-z1:end, z1-z2:z1-z2+z0));
ims(:,:,9) = imresize_(img(end-z1:end, end-z1:end));
end

function im_ = imresize_(im)
im_ = imresize(im,[512,512]);
im_ = imadjust(im_,stretchlim(im_,0));
%im = func_imadjust(im);
end

function name = regexp_(imName1)
name = regexp(imName1,'\d{7}','match');
end