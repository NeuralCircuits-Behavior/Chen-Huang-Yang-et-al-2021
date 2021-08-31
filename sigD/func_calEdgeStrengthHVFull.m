function E = func_calEdgeStrengthHVFull(im)
% im is 1200 x 1200, uint16
p = 5;
im = uint16(imfilter(medfilt2(double(im),'symmetric'),fspecial('average',3),'symmetric'));
%im = uint16(imgaussfilt(medfilt2(double(im),'symmetric'),3));

e = zeros(1200,1200,2);
for k = 1:2
    if k == 1
        e(:,:,k) = func_calEdgeStrengthH_mex(im,p);
    else
        e(:,:,k) = func_calEdgeStrengthV_mex(im,p);
    end
end
E = max(e,[],3);
%E = prod(e,3);

%figure;imagesc(E)
end
