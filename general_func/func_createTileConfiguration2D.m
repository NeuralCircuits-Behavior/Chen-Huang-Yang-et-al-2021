function fName = func_createTileConfiguration2D(list,coord,pixelSize,sliceNo)

oldpath = cd(list(1).folder);
pixelxyz = coord./pixelSize * 1000;
fName = sprintf('TileConfiguration_Slice_%04d.txt',sliceNo);
f = fopen(fName,'w');
fprintf(f,sprintf('dim = 2\r\n\r\n')); % head
n = 0;
for k =  1:numel(list)
    n = n + 1;
    fprintf(f,...
        sprintf('%s; ; (%.4f, %.4f)\r\n',list(k).name,...
        pixelxyz(k,1),pixelxyz(k,2)));
end
fclose(f);
cd(oldpath);
end