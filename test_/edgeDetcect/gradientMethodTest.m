list = dir('D:\Data\confocalRelated\testData\imaging\serialImaging2\*_.tif');

oldPath = cd(list(1).folder);
tpi = imread('22.3415_14.9923_.tif');

dirObj = DetectedDir3(tpi,[0.1,0.1]);

for f = 1:numel(list)
im = imread(list(f).name);
dirObj.getDetectedDir(im);
figure;
imshowpair(imadjust(im),imgradientxy(im,'prewitt'),'montage');
suptitle(sprintf('%s, %d',num2str(dirObj.ft,'%d'),dirObj.dir_detected));
end