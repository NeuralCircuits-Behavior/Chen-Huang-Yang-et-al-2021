function func_imSegmentShow(im,fAutoContrast,fNewfig)

if nargin == 1
    fAutoContrast = 1;
    fNewfig = 1;
elseif nargin == 2
    fNewfig = 1;
end

if fNewfig
    figure;
end
montage(repmat(reshape(imSegment(im,fAutoContrast),512,512,1,9),1,1,3,1));
end

function ims = imSegment(img,fAutoContrast)

z1 = 426;
z0 = 434;
z2 = 43;
ims = zeros(512,512,9,'uint16');
ims(:,:,1) = imresize_(img(1:z1, 1:z1));
ims(:,:,2) = imresize_(img(1:z1, z1-z2:z1-z2+z0));
ims(:,:,3) = imresize_(img(1:z1, end-z1:end));

ims(:,:,4) = imresize_(img(z1-z2:z1-z2+z0, 1:z1));
ims(:,:,5) = imresize_(img(z1-z2:z1-z2+z0, z1-z2:z1-z2+z0));
ims(:,:,6) = imresize_(img(z1-z2:z1-z2+z0, end-z1:end));

ims(:,:,7) = imresize_(img(end-z1:end,1:z1));
ims(:,:,8) = imresize_(img(end-z1:end, z1-z2:z1-z2+z0));
ims(:,:,9) = imresize_(img(end-z1:end, end-z1:end));


    function im_ = imresize_(im)
        im_ = imresize(im,[512,512]);
        if fAutoContrast
            im_ = imadjust(im_,stretchlim(im_,0));
        end
        %im = func_imadjust(im);
    end
end

