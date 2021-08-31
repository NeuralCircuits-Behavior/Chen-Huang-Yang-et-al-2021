function im = func_imadjust(im0)
im = uint16(medfilt2(wiener2(double(imadjust(im0)))));
end