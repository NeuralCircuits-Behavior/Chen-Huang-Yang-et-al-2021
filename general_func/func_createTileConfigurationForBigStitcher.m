function fName = func_createTileConfigurationForBigStitcher(stackIdx,coord,tileConfigTxtSavePath)
% 2019/6/3,Ch
% 3d 

oldpath = cd(tileConfigTxtSavePath);
pixelxyz = coord;

dimn = 3;

fName = 'TileConfiguration.txt';

f = fopen(fName,'w');
fprintf(f,sprintf('dim = %d\r\n\r\n',dimn)); % head
n = 0;
for k =  1:numel(stackIdx)
    n = n + 1;
    
    str = num2str(pixelxyz(k,1:3),'%.4f, ');
    fprintf(f,sprintf('# %d\r\n',stackIdx(k)));
    fprintf(f,sprintf('%s; ; (%s)\r\n',num2str(n-1),str(1:end-2)));
end
fclose(f);

cd(oldpath);
end