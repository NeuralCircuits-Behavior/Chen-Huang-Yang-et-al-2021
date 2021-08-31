sections = 6:10;
zShift = 210; % um
pathRoot = 'F:\H153';
sectionNameStyle = 'Section_*_preprocessed';
clusters = [1,1,1,1,1];
movePath = 'Section_006-010';

nStack = 0;
nSection = 0;
fid = fopen(fullfile(pathRoot,movePath,'TileConfiguration_Stack.txt'),'w');
fprintf(fid,'dim = 3\r\n');
for isection = sections
    nSection = nSection + 1;
    fprintf(fid,sprintf('\r\n#Section_%03d\r\n',isection));
    sessionName = strrep(sectionNameStyle,'*',num2str(isection,'%03d'));
    txtName = fullfile(pathRoot,sessionName,...
        sprintf('TileConfiguration_Stack_%03d.txt',clusters(nSection)));
    lines = returnString(txtName);
    for iline = 1:2:numel(lines)
        nStack = nStack + 1;
        stackName = char(regexp(lines(iline),'(?<=#).+tif','match'));
        stackNameNew = regexprep(stackName,'_\d+_',num2str(nStack,'_%03d_'));
        fprintf('%s: %s -> %s\n',sessionName, stackName, stackNameNew);
        oldPath = fullfile(pathRoot,sessionName,stackName);
        newPath = fullfile(pathRoot,movePath,stackNameNew);
        copyfile(oldPath,newPath);
        fprintf(fid,sprintf('%s\r\n',char(lines(iline)))); % e.g. #stack_005_001.tif
        str0 = char(regexp(lines(iline+1),';.;.(([\d.]+,.){2}','match'));
        fprintf(fid,sprintf('%d%s%.1f)\r\n',...
            nStack-1,str0,zShift*(nSection-1)));
    end
end
fclose(fid);

function lines = returnString(filePath)
sonnets = string(fileread(filePath));
lines = splitlines(sonnets);
TF = (lines == "");
lines(TF) = [];
lines(1) = [];
end