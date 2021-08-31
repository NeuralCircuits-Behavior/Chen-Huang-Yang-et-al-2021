function func_writeTifFast8(imdata, FileTif)
% specifically for imaging

t = Tiff(FileTif,'w');

sz1 = size(imdata,1);
sz2 = size(imdata,2);

t = set_(t,sz1,sz2);

t.write(imdata(:,:,1));

for i = 2:size(imdata,3)
    t.writeDirectory();
    t = set_(t,sz1,sz2);
    t.write(imdata(:,:,i));
end

t.close();


    function t = set_(t,sz1,sz2)
        t.setTag('ImageLength',sz1);
        t.setTag('ImageWidth',sz2);
        t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
        t.setTag('BitsPerSample',8);
        t.setTag('SamplesPerPixel',1);
        t.setTag('Compression',Tiff.Compression.None);
        t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
    end
end



