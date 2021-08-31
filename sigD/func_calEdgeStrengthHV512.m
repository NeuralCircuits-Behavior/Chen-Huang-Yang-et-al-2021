function E = func_calEdgeStrengthHV512(im)
% im is 512 x 512, uint16
p = 8;
im = uint16(imfilter(medfilt2(double(im),'symmetric'),fspecial('average',5),'symmetric'));
%im = uint16(imgaussfilt(medfilt2(double(im),'symmetric'),3));
im_ = imresize(im,[512,512]);
e = zeros(512,512,2);
for k = 1:2
    if k == 1
        e(:,:,k) = func_calEdgeStrengthH_mex(im_,p);
    else
        e(:,:,k) = func_calEdgeStrengthV_mex(im_,p);
    end
end
%E = max(e,[],3);
E = mean(e,3) + prod(e,3).^0.5;

figure;imagesc(E)
end
