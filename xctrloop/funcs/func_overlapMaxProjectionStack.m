function ims = func_overlapMaxProjectionStack(ims0,zSectionOverlap)
% 2019/9/30,CH
% obj.zSectionOverlap x 1200 x 2
%      1
%    2   (3)
%      (4)
% only use 1,2
% ims need from piezo small to big val


ims = ...
    zeros(zSectionOverlap,1200,2,'uint16');

tmp = ims0(:,:,:,end-zSectionOverlap+1:end);

ims(:,:,1) = ...
    squeeze(max(tmp,[],1))';
ims(:,:,2) = ...
    squeeze(max(tmp,[],2))';

end