
path = 'D:\Data\confocalRelated\testData\imaging\featureMethodsTest';
%%
% vl_sift
% non-clearing sample
%{
list  = dir(fullfile(path,'1_*.tif'));
func = @SIFT;
fPreprocess = 0;
thresh = 10;%determineThresh(list,n0,@vl_sift_wrapper);
[result,t] = main(list,fPreprocess,func,thresh);
[accuracy,FN,FP] = evaluateResult(func,result,t);
plotError(list,FN,'False Negtive',func,thresh);
plotError(list,FP,'False Positive',func,thresh);
%}
%% 
% matlab detectFASTFeatures
% non-clearing sample
%{
list  = dir(fullfile(path,'1_*.tif'));
func = @FAST;
MinContrast = 0.2;
MinQuality = 0.1;
[result,t] = main(list,func,MinContrast,MinQuality);
[accuracy,FN,FP] = evaluateResult(func,result,t);
plotError(list,FN,'False Negtive',func,MinContrast,MinQuality);
plotError(list,FP,'False Positive',func,MinContrast,MinQuality);
%}
%% 
% matlab detectSURFFeatures
% non-clearing sample

list  = dir(fullfile(path,'1_*.tif'));
func = @SURF;
fPreprocess = 1;
MetricThreshold = determineThresh(list,1000,+100,fPreprocess,@SURF);%1000;
[result,t] = main(list,fPreprocess,func,MetricThreshold);
[accuracy,FN,FP] = evaluateResult(func,result,t);
plotError(list,FN,'False Negtive',func,MetricThreshold);
plotError(list,FP,'False Positive',func,MetricThreshold);
%}

%% 
% matlab detectBRISKFeatures
% non-clearing sample
%{
list  = dir(fullfile(path,'1_*.tif'));
func = @BRISK;
fPreprocess = 1;
MinContrast = 0.3;%determineThresh(list,1000,+100,fPreprocess,@SURF);%1000;
[result,t] = main(list,fPreprocess,func,MinContrast);
[accuracy,FN,FP] = evaluateResult(func,result,t);
plotError(list,FN,'False Negtive',func,MinContrast);
plotError(list,FP,'False Positive',func,MinContrast);
%}
%%
function [result,t] = main(list,fPreprocess,func,varargin)
oldpath = cd(list(1).folder);
result = zeros(numel(list),2);
result(:,1) = getTarget(list);
tic;
for f = 1: size(result,1)
    im = imread(list(f).name);
    if fPreprocess
        im = preprocess(im);
    end
    n = func(im,varargin{:});
    if n > 1 || nnz(edge(im,'approxcanny')) >= 50
        result(f,2) = 1;
    end
end
t = toc;
t = round(t./ f, 2);
cd(oldpath);
end

function thresh = determineThresh(list,n0,nStep,fPreprocess,func,varargin)
oldpath = cd(list(1).folder);
sampleN = nnz(~getTarget(list));
thresh = zeros(sampleN,1);
tpiIdx = randsample(find(~getTarget(list)),sampleN);
for i = 1:sampleN
    tpi = imread(list(tpiIdx(i)).name);
    if fPreprocess
        tpi = preprocess(tpi);
    end
    thresh_ = n0;
    while func(tpi,thresh_) > 3
        thresh_ = thresh_ + nStep;
    end
    thresh(i) = thresh_;
end
thresh = mean(thresh);
fprintf('Threshold: %d.\n',thresh);
cd(oldpath);
end

function target = getTarget(list)
    target = cellfun(@(f)str2double(f(end)),erase({list.name},'.tif'))';
end

function [accuracy,FN,FP] = evaluateResult(func,result,t)
    N = size(result,1);
    FN = result(:,1) == 1 & result(:,2) == 0;
    FP = result(:,1) == 0 & result(:,2) == 1;
    accuracy = result(:,1) == result(:,2);
    fprintf('Method: %s.\nAccuracy: %.3f. False Positive: %.3f. False Negative: %.3f.\nRun once took %.4fs\n',...
        func2str(func),sum(accuracy)/N,sum(FP)/N,sum(FN)/N,t);
end

function plotError(list,tf,title_,func,varargin)
oldpath = cd(list(1).folder);
if ~nnz(tf);return;end
list = list(tf);
for n = 1: nnz(tf)
    im = imread(list(n).name);
    im2 = preprocess(im);
    switch func2str(func)
        case {'FAST','SURF','KAZE','BRISK'}
            [~,points] = func(im2,varargin{:});
            figure;
            imshowpair(im,im2,'montage');hold on
            if ~isequal(points.Count,0)
                plot(points.selectStrongest(points.Count));
            end
        case 'SIFT'
            [num,f] = func(im,varargin{:});
            figure;
            imshowpair(im,im2,'montage');hold on
            if ~isequal(num,0)
                vl_plotframe(f);
            end
    end
    suptitle({title_,'Left, orignal image;  Right, imajust image'});
end
cd(oldpath);
end

function im = preprocess(im)
im = imadjust(im,stretchlim(im,0));
%im = imadjust(im);
end
%% methods 
function [n,f] = SIFT(im,varargin)
thresh = varargin{1};
f = vl_sift(single(im), 'PeakThresh', thresh) ;
n = size(f,2);
end

function [n,points] = FAST(im,varargin)
points = detectFASTFeatures(im,...
    'MinContrast',varargin{1},...
    'MinQuality',varargin{2});
n = points.Count;
end

function [n,points] = SURF(im,varargin)
points = detectSURFFeatures(im,...
    'MetricThreshold',varargin{1},...
    'NumOctaves',4);
n = points.Count;
end

function [n,points] = KAZE(im,varargin)
points = detectKAZEFeatures(im,...
    'Threshold',varargin{1});
n = points.Count;
end

function [n,points] = BRISK(im,varargin)
points = detectBRISKFeatures(im,...
    'MinContrast',varargin{1});
n = points.Count;
end