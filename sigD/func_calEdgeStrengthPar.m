function E = func_calEdgeStrengthPar(im,d)
im1 = pad(im,d);

sz = size(im);
%{
% verti
ev = zeros(sz);
for k = 1:sz(2)
ev(:,k) = core(im1(:,d+k),d);
end

% horiz
eh = zeros(sz);
for k = 1:sz(1)
eh(k,:) = core(im1(d+k,:),d);
end
%}
fev = parfeval(@func,1,im1,2,sz,d);
feh = parfeval(@func,1,im1,1,sz,d);
ev = fetchOutputs(fev);
eh = fetchOutputs(feh);
E = max(ev,eh);
end

function out = func(im1,dim,sz,d)
out = zeros(sz);
if dim==1
    %h
    for k = 1:sz(1)
        out(k,:) = core(im1(d+k,:),d);
    end
elseif dim==2
    %v
    for k = 1:sz(2)
        out(:,k) = core(im1(:,d+k),d);
    end
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