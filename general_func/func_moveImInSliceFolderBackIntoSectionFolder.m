function func_moveImInSliceFolderBackIntoSectionFolder(p1)
% 'E:\Data\CH\20190315_H142_S\2nd\Section_002\40X'
filelist = dir(fullfile(p1,'Slice_*'));
N = numel(filelist);
ns = 1;
fprintf('\n');
for k = 1:N
    fprintf(repmat('\b',1,ns));
    ns = fprintf('%d/%d',k,N);
    list = dir(fullfile(p1,filelist(k).name,'*_.tif'));
    arrayfun(@(i)movefile(fullfile(i.folder,i.name),p1),list);
end
fprintf('\n');
end