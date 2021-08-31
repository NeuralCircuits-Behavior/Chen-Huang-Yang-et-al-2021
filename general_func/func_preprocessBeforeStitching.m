function I = func_preprocessBeforeStitching(filePath,name,stack)
if nargin < 3
    MIJ.run('Open...', ...
        sprintf('path=[%s]',strrep(fullfile(filePath,name),'\','\\')));
else
    MIJ.createImage('stack',stack, true);
end
MIJ.run("Median...", "radius=2 stack");
MIJ.run("Subtract Background...", "rolling=50 stack");
MIJ.run("Unsharp Mask...", "radius=1 mask=0.60 stack");
I = uint8(MIJ.getCurrentImage);
MIJ.run('Close All');
end