function ROIxy = func_determineRecROIXY(stepxy,centerPos,halfSideLenXY)
x = (centerPos(1) + halfSideLenXY(1)):...
    -stepxy(1):(centerPos(1) - halfSideLenXY(1));
y = (centerPos(2) + halfSideLenXY(2)):...
    -stepxy(2):(centerPos(2) - halfSideLenXY(2));
[ROIx,ROIy] = meshgrid(x,y);
ROIx = flipEven(ROIx)';
ROIy = flipEven(ROIy)';
ROIxy = [ROIx(:),ROIy(:)];

    function array = flipEven(array)
        array(2:2:end,:) = fliplr(array(2:2:end,:));
    end
end