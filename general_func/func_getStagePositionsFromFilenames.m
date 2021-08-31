function [xyzExp,xyzExa,list] = func_getStagePositionsFromFilenames(path)
if ~contains(path,'*_.tif')
    path = strcat(path,'\*_.tif');
end
list = dir(path);
names = {list.name}';
xyzExp = convert_(convert2cell(names,'exp_')); % char
xyzExa = convert_(convert2cell(names,'exa_'));

    function c = convert2cell(names,prefix)
        pattern = sprintf('(?<=%s)([0-9.]+_ *){3}',prefix);
        c = cellfun(@cell2mat,regexp(names,pattern,'match'),'unif',0);
        c = regexp(c,'[0-9.]+','match');
    end
    
    function xyzNum = convert_(xyzCell)
        xyzNum = cell2mat(...
            cellfun(@(f)str2double(f),xyzCell,'unif',0));
    end
end