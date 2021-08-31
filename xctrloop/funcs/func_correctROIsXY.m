function [curr,xyDelta] = func_correctROIsXY(last,curr,th)
% 2019/9/30,CH
% last, nROIs x 2, last dertermined rois
% curr, nROIs x 2, current dertermined rois, need shifted
% th, threshold, [stepx,stepy]

dist = sum(th.^2);
xyDelta = [];
val0 = dist;
for i = 1:size(last,1)
    [val,idx] = min(sum((last(i,:)-curr).^2,2));
    if val<val0
        val0 = val;
        xyDelta = last(i,:)-curr(idx,:);
    end
end
if val0<dist
    curr = curr + xyDelta;
end
end