function func_writeTifFast(FileTif, imdata, bps)


if bps==8
    imdata = uint8(imdata);
elseif bps==16
    imdata = uint16(imdata);
elseif bps==32
    imdata=uint32(imdata);
end



t = Tiff(FileTif,'w8');

t.setTag('ImageLength',size(imdata,1));
t.setTag('ImageWidth',size(imdata,2));
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('BitsPerSample',bps);
t.setTag('SamplesPerPixel',1);
% t.setTag('TileWidth',128);
% t.setTag('TileLength',128);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);

t.write(imdata(:,:,1));

for i = 2:size(imdata,3)
    t.writeDirectory();
    t.setTag('ImageLength',size(imdata,1));
    t.setTag('ImageWidth',size(imdata,2));
    t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
    t.setTag('BitsPerSample',bps);
    t.setTag('SamplesPerPixel',1);
    t.setTag('Compression',Tiff.Compression.None);
    t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
    t.write(imdata(:,:,i));
end

t.close();





