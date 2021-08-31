%%
filePath = 'E:\ImageProccessingExamples\H151\H151_Section_016_40X\';
savePath = 'E:\ImageProccessingExamples\H151\H151_Section_016_40X_preProcessed\';
List = dir([filePath,'stack_*.tif']);
%%
Miji();
for stackNum = 1:numel(List)
    %stackNum = 8;
    I = process(filePath,List(stackNum).name);
    writeTifFast(fullfile(savePath,List(stackNum).name), I, 16);
end


function I = process(filePath,name)
MIJ.run('Open...', ...
    sprintf('path=[%s]',strrep(fullfile(filePath,name),'\','\\')));
MIJ.run("Median...", "radius=2 stack");
MIJ.run("Subtract Background...", "rolling=50 stack");
I = uint16(MIJ.getCurrentImage);
%{
path_ = ['save=[E:\\ImageProccessingExamples\\H151\\Section_016_40X_prep\\',name,']']
MIJ.run('Save', path_);
%}
MIJ.run('Close All');
end