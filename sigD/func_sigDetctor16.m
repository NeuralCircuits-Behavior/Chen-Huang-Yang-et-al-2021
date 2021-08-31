function [result,resultCoor] = func_sigDetctor16(im,thre,overlaps,resoultions)
% im, 1200x1200 uint16
% overlaps,[16x,40x]
% resoultions,[16x,40x]

if nargin==1 || nargin==2
    re16 = 0.75576;
    re40 = 0.27361;

    olp40 = 0.1;
    olp16 = 1 - 3 * ( 1 - olp40) * re40 / re16;
    overlaps = [olp16,olp40];
    
    resoultions = [re16,re40]; % 16x,40x
end

if nargin == 1
    thre = 6;
end
%sz1 = [1200,1200];
%sz2 = [512,512];
%im_ = imresize(im,sz2);
%E = func_calEdgeStrengthHV512(im_);
%E = func_calEdgeStrengthHV512(im);
E = func_calEdgeStrengthHVFull(im);
%{
x = 0.1:0.05:10;
% 1000 for 512*512,sz dependent
pMax = 12000;
y = arrayfun(@(a)nnz(E>a),x);
idx = find(y<=pMax,2);
if isempty(idx)
    thre = 5;
else
    thre = x(idx(end));
end
%}
%thre = 6;
[z0,z1,z2] = getZ(overlaps,resoultions);
%{
result = decideSig(imresize(medfilt2(E>thre),sz1,'nearest'),...
    z0,z1,z2)'; % logcial
%}
%result = decideSig(medfilt2(E>thre,[5,5]),z0,z1,z2)'; % logcial
%result = decideSig(bwareaopen(medfilt2(E>thre,[5,5]),4,8),z0,z1,z2)'; % logcial
resultBi = bwareaopen(E>thre,5,8);
[result,resultCoor] = decideSig(resultBi,z0,z1,z2); % logcial
result = result';
end


function [z0,z1,z2] = getZ(overlaps,resoultions)
re40 = resoultions(2);
re16 = resoultions(1);

olp40 = overlaps(2);

z0 = round(re40 *1200 / re16);
z1 = round((0.5 * re40 + (olp40 - 1) * re40 + 0.5 * re16) * 1200 / re16);
z2 = round(olp40 * re40 *1200 / re16);

end

function [result01,sigPos] = decideSig(img,z0,z1,z2)
result = zeros(9,1);
sigPos = cell(9,1);

[result(1),sigPos{1}] = foo(img(1:z1, 1:z1));
[result(2),sigPos{2}] = foo(img(1:z1, z1-z2:z1-z2+z0));
[result(3),sigPos{3}] = foo(img(1:z1, end-z1:end));
[result(4),sigPos{4}] = foo(img(z1-z2:z1-z2+z0, 1:z1));
[result(5),sigPos{5}] = foo(img(z1-z2:z1-z2+z0, z1-z2:z1-z2+z0));
[result(6),sigPos{6}] = foo(img(z1-z2:z1-z2+z0, end-z1:end));
[result(7),sigPos{7}] = foo(img(end-z1:end,1:z1));
[result(8),sigPos{8}] = foo(img(end-z1:end, z1-z2:z1-z2+z0));
[result(9),sigPos{9}] = foo(img(end-z1:end, end-z1:end));
%{
result(1) = nnz(img(1:z1, 1:z1));
result(2) = nnz(img(1:z1, z1-z2:z1-z2+z0));
result(3) = nnz(img(1:z1, end-z1:end));

result(4) = nnz(img(z1-z2:z1-z2+z0, 1:z1));
result(5) = nnz(img(z1-z2:z1-z2+z0, z1-z2:z1-z2+z0));
result(6) = nnz(img(z1-z2:z1-z2+z0, end-z1:end));

result(7) = nnz(img(end-z1:end,1:z1));
result(8) = nnz(img(end-z1:end, z1-z2:z1-z2+z0));
result(9) = nnz(img(end-z1:end, end-z1:end));
%}
result01 = logical(result);

    function [result,resultCoor] = foo(ims)
        result = nnz(ims);
        [resultCoor(:,2),resultCoor(:,1)] = find(ims);
    end
end