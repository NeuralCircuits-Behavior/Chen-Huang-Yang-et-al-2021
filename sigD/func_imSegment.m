function ims = func_imSegment(img,z0,z1,z2)
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

    function im = imresize_(im)
        im = imresize(im,[512,512]);
        im = imadjust(im,stretchlim(im,0));
        %im = func_imadjust(im);
    end
end