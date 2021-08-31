function func_writeStackJava(im,name)
% create an independent thread in jvm to save im stack

% put E:\Program Files\MATLAB\R2017b\java\patch\ij-1.52n.jar
%     E:\Program Files\MATLAB\R2017b\java\patch\ij1-patcher-0.12.9.jar
%     E:\LAB_CH\Guo_LAB\java_workspace\MATLAB\bin\StackSaver.class
% into classpath.txt
% run Miji(0); first

% not very fast, ~10 s per 251 frame stack

% 2019/7/10,CH

StackSaver(func_imjavawrap(im),name).start();
end

function imgPlus = func_imjavawrap(im)
im = permute(im,[2,1,3]);
img = net.imglib2.img.array.ArrayImgs.unsignedShorts(im(:), size(im));
imgPlus = net.imglib2.img.display.imagej.ImageJFunctions.wrap(img, 'stack' );
end