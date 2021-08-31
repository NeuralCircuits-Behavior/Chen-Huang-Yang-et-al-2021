% 2018/6/3, CH
% not consider overlap now


filePath = 'D:\Data\confocalRelated\testData\imaging\20180603_opticlearing\1st\';
resizeFactor = 0.5;
imDepth =  'uint16';


sectionFolderNames = 'Section_*';
sectionFolderList = dir(fullfile(filePath,sectionFolderNames));
sectionFolderList = sectionFolderList([sectionFolderList.isdir]);

sectionNames = string({sectionFolderList.name});
sectionStackNames = filePath + "\" + ...
     sectionNames + "\" + sectionNames + sprintf('_%.2fds.tif',resizeFactor);

% initiation
imSize = cellfun(@getStackSize,sectionStackNames,'unif',0);
nSlice = cell2mat(imSize');
nSlice = nSlice(:,3);
imSize = [imSize{1}(1:2),sum(nSlice)];
sRange = cumsum(nSlice);
sRange = [[1;sRange(1:end-1)+1],sRange];

% write
stack = zeros(imSize,imDepth);
fprintf('\nprocessing');
for s = 1:numel(sectionStackNames)
    fprintf('.');
    stack(:,:,sRange(s,1):sRange(s,2)) = ...
        func_readTifStack(char(sectionStackNames(s)),'uint16');
end
fprintf(' done.\n');

% save
func_writeTifFast(sprintf('%s%s-%s.tif',strcat(filePath,filesep),...
    char(sectionNames(1)),char(sectionNames(end))),stack,...
    str2double(regexp(imDepth,'[\d.]+','match')));



function sz = getStackSize(fileName)
    info = imfinfo(fileName);
    sz(3) = numel(info);
    sz(1) = info(1).Height;
    sz(2) = info(1).Width;
end