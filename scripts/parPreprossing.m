filePath = 'E:\Data\CH\20190415_H153_S\1st\';
saveSubpath = 'preprocessed';
f0 = 7:9;
timeOutTimes = 1; %times 1min once time

finishList0 = {};
sessionList = dir(fullfile(filePath,'Section_*'));
sessionList = sessionList(f0);
disp({sessionList.name}');

Miji();

if isempty(finishList0)
    finishList0 = repmat({string({})},1,numel(f0));
end
for isession = 1:numel(sessionList)

    finishList = finishList0{isession};
    n = 0;
    fFinishSession = 0;
    fileRoot = fullfile(sessionList(isession).folder,...
            sessionList(isession).name,'40X');
    saveRoot = fullfile(sessionList(isession).folder,...
            sessionList(isession).name,...
            [sessionList(isession).name,'_',saveSubpath]);
    if ~exist(saveRoot,'file')
        mkdir(saveRoot);
    end
    
    fprintf('\nfileRoot: %s\n',fileRoot);
    fprintf('saveRoot: %s\n',saveRoot);
    
    while ~fFinishSession
        
        fileList = dir(fullfile(fileRoot,'stack_*.tif'));
        if numel(fileList)<2
            continue
        end
        
        bytes = fileList(1).bytes;
        validFileListTf = [fileList.bytes]==bytes & ...
            ~contains(string({fileList.name}),finishList);
        N = nnz(validFileListTf);
        validFileList = fileList(validFileListTf);
        
        if ~N
            n = n+1;
            if n<=timeOutTimes
                fprintf('Wait new stack %d/%d\n',n,timeOutTimes);
                pause(60);
                continue
            else
                fprintf('Skip to next session\n');
                fFinishSession = 1;
            end
        end
        
        n = 0;
        for istack = 1:N
            stackName = validFileList(istack).name;
            process(fileRoot,saveRoot,stackName)
            fprintf('Finish %s\n',stackName);
            finishList(end+1) = stackName;
        end
    end
end




function process(fileRoot,saveRoot,stackName)
I = func_preprocessBeforeStitching(fileRoot,stackName);
func_writeTifFast16(I,fullfile(saveRoot,stackName));
end