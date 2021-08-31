% 2018/3/13, CH
% using R1DS1P from Thorlabs
% prodct info: 
% https://www.thorlabschina.cn/newgrouppage9.cfm?objectgroup_id=4338&pn=R1DS1P#5935
% resolution(line_pair/mm) = 2^(group+(element-1)/6)
% analyze serial images capture form micorscope


path = ...%'D:\Data\confocalRelated\testData\pixelSizeTest\40x_500ms.tif';
    'D:\Data\confocalRelated\testData\pixelSizeTest\16x_100ms.tif';
%removeSize = 2000; % pixels
smoothPixel = 10;  % pixels

group = 2; % see R1DS1P from thorlab website
element = 2; % see R1DS1P from thorlab website

objectMagnification = 16; % *x
fTubeLensInMicroscope = 180; % mm, Olympus	f = 180 mm
fDesignTubeLensForObjective = 200; %mm, Nikon	f = 200 mm
sensorSize = 11; % 11 micorns per pixel

%%
pixelSizeMeasured = main(path,smoothPixel,group,element);
magnificationTheory = objectMagnification* ...
    fTubeLensInMicroscope/fDesignTubeLensForObjective;
pixelSizeTheory = sensorSize/magnificationTheory;
magnificationMeasured = sensorSize/pixelSizeMeasured;

fprintf('\nTheoretical pixel size is %.5f ¦Ìm/pixel, magnification is %.2f',...
    pixelSizeTheory,magnificationTheory);
fprintf('\nMeasured pixel size is %.5f ¦Ìm/pixel,magnification is %.2f\n',...
    pixelSizeMeasured,magnificationMeasured);
fprintf('Delta pixel size is %.5f ¦Ìm/pixel,error is %.2f%%\n',...
    pixelSizeTheory-pixelSizeMeasured,...
    (pixelSizeTheory-pixelSizeMeasured)/pixelSizeTheory*100);

function pixelSize = main(path,smoothPixel,group,element)
imStack = readImStack(path);
indices = decideImages(imStack,smoothPixel);
areas = calculateChosenImsArea(imStack(:,:,indices));
pixelSize = calculatePixelSize(areas,group,element);
end

function imStack = readImStack(path)
    imStack = func_readTifStack(path,'uint16');
end

function indices = decideImages(imStack,smoothPixel)
N = size(imStack,3);
%{
    areaPixels = nan(N,2);
    for ii = 1:N
        [areaPixels(ii,1),areaPixels(ii,2)] = ...
            calculatePixels(imStack(:,:,ii),removeSize);
        if areaPixels(ii,2) > 1
            fprintf('NO.%d image has %d connected areas.\n',...
                ii,areaPixels(ii,2));
        end
    end
%}
blurWidth = nan(N,1);
for ii = 1:N
    blurWidth(ii) = calculateBlurWidth(imStack(:,:,ii),smoothPixel);
end
indices = getMinIndices(blurWidth);
plotResult(blurWidth,indices);

    function [areaPixels,numL] = calculatePixels(im,removeSize)
        imBW = ~imbinarize(im);
        imBW = bwareaopen(imBW,removeSize);
        [~,numL]=bwlabel(imBW);
        if numL > 1
            areaPixels = nan;
            return
        end
        areaPixels = nnz(imBW);
    end

    function blurWidth = calculateBlurWidth(im,smoothPixel)
        meanIm = mean(im(:));
        his = smooth(sum(im)/size(im,1),smoothPixel); 
            % note axis is not considered
        [pks,locs] = findpeaks(his);
        indSmall = locs(find(pks < meanIm,1)-1);
        
        [pks,locs] = findpeaks(-his);
        indBig = locs(find(pks > -meanIm,1));
        
        blurWidth = indBig - indSmall;
    end
    
    function plotResult(blurWidth,indices)
        figure;hold on
        plot(blurWidth);
        plot(indices,blurWidth(indices),'ro');
        title('blur width of edge');
        xlabel('image #');
        ylabel('pixel count');
    end

    function indices = getMinIndices(blurWidth)
        minVal = min(blurWidth);
        indices = find(blurWidth == minVal);
        indices = indices(1):indices(end);
        if range(indices) > 3 
            warning on;
            warning('Maybe choose inappropriate parameters.Please check.');
            warning off;
        end
    end
end

function areas = calculateChosenImsArea(imStackChosen)
N = size(imStackChosen,3);
areas = nan(N,1);
for ii = 1:N
    areas(ii) = calculatePixels(imStackChosen(:,:,ii));
end

    function areaPixels = calculatePixels(im)
        imBW = ~imbinarize(im);
        stats = regionprops(imBW,'Centroid','area');
        [maxArea,maxInd] = max([stats.Area]);
        cropWidth  = round(maxArea^0.5)*1.5;
        imBW = imcrop(imBW,[stats(maxInd).Centroid(2)-0.5*cropWidth,...
            stats(maxInd).Centroid(1)-0.5*cropWidth,cropWidth,cropWidth]);
        areaPixels = bwarea(imBW);
    end
end

function pixelSize = calculatePixelSize(areas,group,element)
umPerlinePair = 2^(-group-(element-1)/6)*1000;
squareWidth = umPerlinePair/2*5;% each linePair = 2 lines
pixelSize = mean(squareWidth./areas.^0.5);
end
