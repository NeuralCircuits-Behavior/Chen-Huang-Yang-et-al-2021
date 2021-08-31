anmName = {'E:\Data\CH\20200114_Y18-2\1st'};

magFolder = '16X';

saveFolder = '16XDetectorTest1_thre6';

f = figure('Visible','off');
for ianm = 1:numel(anmName)
    fprintf('%s\n',anmName{ianm});
    sections = dir(fullfile(anmName{ianm},'Section_*'));
    for isession = 1:numel(sections)
        fprintf('  %s\n',sections(isession).name);
        filePathSection_ = fullfile(sections(isession).folder,sections(isession).name,magFolder);
        [xyzExp,~,ims] = func_getStagePositionsFromFilenames(filePathSection_);
        %ims = dir(fullfile(sections(isession).folder,sections(isession).name,magFolder,'*_.tif'));
        [~,~,ic] = unique(xyzExp(:,1:2),'rows','stable');
        imName = string({ims.folder})+'\'+string({ims.name});
        mkdir(fullfile(sections(isession).folder,sections(isession).name,saveFolder));
        for k = unique(ic,'stable')'%1:numel(imName)
            %fprintf('    %s\n',ims(k).name);
            
            %[im,result] = singleProcess(char(imName(k)));
            imNames = imName(ic==k);
            [im,result] = stackProcess(imNames);
            
            clf;
            
            montage(repmat(reshape(imSegment(im),512,512,1,9),1,1,3,1));
            
            strPrint = sprintf('%s %s %s',...
                num2str(result(1:3),'%d'),...
                num2str(result(4:6),'%d'),...
                num2str(result(7:9),'%d'));
            text(100,100,strPrint,'Color','r','FontWeight','bold');
            
            [rootPath,imName1] = fileparts(imNames(1));
            [~,imName2] = fileparts(imNames(end));
            rootPath = strrep(rootPath,magFolder,saveFolder);
            saveName = fullfile(char(rootPath),char(regexp_(imName1)+'_'+regexp_(imName2)+'.jpg'));
            
            %{
            saveName = strrep(imName(k),magFolder,saveFolder);
            saveName = strrep(saveName,'.tif','.jpg');
            %}
            saveas(f,saveName);
        end
    end
end
disp('Done.')

%%
function [im,result] = singleProcess(name)
im = imread(name);
result = func_sigDetctor16(im);
end

function [im,result] = stackProcess(names)
im = zeros(1200,1200,'uint16');
for k = 1:numel(names)
    im = max(im,imread(char(names(k))));
end
result = func_sigDetctor16(im);
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