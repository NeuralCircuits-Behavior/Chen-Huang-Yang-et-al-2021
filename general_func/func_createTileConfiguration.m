function fName = func_createTileConfiguration(list,coord,pixelSize,sliceNo,tileConfigTxtSavePath)
% 2018/5/16,Ch
% 2d 3d 

if isempty(tileConfigTxtSavePath)
    tileConfigTxtSavePath = list(1).folder;
end

oldpath = cd(tileConfigTxtSavePath);
pixelxyz = coord./pixelSize * 1000;

dimn = size(coord,2);
if dimn == 2
    T = ones(1,numel(list));
    fName = {sprintf('TileConfiguration_Slice_%04d.txt',sliceNo)};
elseif dimn == 3
    T = cellfun(@str2double,...
        regexp({list.name},'\d+(?=.tif)','match'));
    fName = sprintfc('TileConfiguration_Stack_%03d.txt',1:max(T));
end

for ifname = 1:numel(fName)
    f = fopen(fName{ifname},'w');
    fprintf(f,sprintf('dim = %d\r\n\r\n',dimn)); % head
    n = 0;
    subList = list(T==ifname);
    pixelxyz_ = pixelxyz(T==ifname,:);
    for k =  1:numel(subList)
        n = n + 1;
        str = num2str(pixelxyz_(k,1:2),'%.4f, ');
        if dimn == 3
            str = [str,' 0.0, '];
            fprintf(f,sprintf('#%s\r\n',subList(k).name));
            fprintf(f,sprintf('%s; ; (%s)\r\n',num2str(n-1),str(1:end-2)));
        else
            fprintf(f,sprintf('%s; ; (%s)\r\n',subList(k).name,str(1:end-2)));
        end
    end
    fclose(f);
end
if dimn == 2
    fName = fName{1};
end
cd(oldpath);
end