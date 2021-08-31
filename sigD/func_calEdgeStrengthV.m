function ev = func_calEdgeStrengthV(im,d)
im1 = pad(im,d);

sz = size(im);

% verti
ev = zeros(sz);
for k = 1:sz(2)
ev(:,k) = core(im1(:,d+k),d);
end
end

function im1 = pad(im,d)
im1 = zeros(size(im)+2*d,class(im));
im1(1:d,d+1:end-d) = flipud(im(1:d,:));
im1(end-d+1:end,d+1:end-d) = flipud(im(end-d+1:end,:));
im1(d+1:end-d,1:d) = fliplr(im(:,1:d));
im1(d+1:end-d,end-d+1:end) = fliplr(im(:,end-d+1:end));
im1(d+1:end-d,d+1:end-d) = im;
end

function col1 = core(col,d)
col1 = zeros(size(col));
for k = d+1:length(col)-d
    col1(k) = max(col(k)-(mean(col([-d,d]+k))+abs(diff(col([-d,d]+k)))),0);
end
col1 = col1(d+1:length(col)-d);
end