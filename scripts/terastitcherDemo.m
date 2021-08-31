! terastitcher --import --volin="E:\Data\TeraStitchTest" --volin_plugin="TiledXY|3Dseries" --imin_plugin="tiff3D" --ref1=y --ref2=x --ref3=z --vxl1=0.27361 --vxl2=0.27361 --vxl3=1 --projout=xml_import

! terastitcher --displcompute --projin="E:\Data\TeraStitchTest\xml_import.xml" --subvoldim=1 --oV=110 --oH=110 --algorithm=MST --projout=xml_displcomp

!  terastitcher --displproj --projin="E:\Data\TeraStitchTest\xml_displcomp.xml" --projout=xml_displproj

! terastitcher --displthres --projin="E:\Data\TeraStitchTest\xml_displproj.xml" --projout=xml_displthres --threshold=0.7

! terastitcher --placetiles --projin="E:\Data\TeraStitchTest\xml_displthres.xml" --projout=xml_merging

mkdir('E:\Data\TeraStitchTest\stitched');
! terastitcher --merge --projin="E:\Data\TeraStitchTest\xml_merging.xml" --volout="E:\Data\TeraStitchTest\stitched" --resolutions=01234  --volout_plugin="TiledXY|2Dseries" --imout_format="tif" --imout_depth=16

