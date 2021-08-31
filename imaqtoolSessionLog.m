vid = videoinput('pmimaq', 1, 'PM-Cam 1200x1200');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);

stoppreview(vid);

preview(vid);

src.ReadoutRate = 'P0S1: 100MHz, 16b, CMOS';

src.GainIndex = 'Gain 1-HDR';

src.Exposure = 5;

src.ExposeOutMode = 'All Rows';

src.ExposeOutMode = 'Any Row';

src.ExposeOutMode = 'First Row';

src.ExposeOutMode = 'Rolling Shutter';

src.ExposeOutMode = 'First Row';

src.Binning = '2x2';

stoppreview(vid);

preview(vid);

src.Binning = '1x1';

src.AutoContrast = 'OFF';

src.AutoContrast = 'ON';

src.PP0ENABLED = 'NO';

src.PP1ENABLED = 'NO';

src.PP2ENABLED = 'NO';

src.PP3ENABLED = 'NO';

src.PMode = 'Alternate Normal';

src.PMode = 'Normal';

src.Exposure = 10;

stoppreview(vid);

preview(vid);

stoppreview(vid);

preview(vid);

src.PP1THRESHOLD = 145;

src.PP1THRESHOLD = 100;

src.Binning = '2x2';

src.Binning = '1x1';

src.Binning = '2x2';

src.Binning = '1x1';

src.Binning = '2x2';

src.Binning = '1x1';

src.Exposure = 1;

src.GainIndex = 'Gain 1-HDR';

src.PP0ENABLED = 'YES';

src.PP1ENABLED = 'YES';

src.PP1THRESHOLD = 125;

src.PP2ENABLED = 'YES';

src.PP3ENABLED = 'YES';

src.ReadoutRate = 'P0S0: 200MHz, 12b, CMOS';

src.Exposure = 2;

src.Exposure = 3;

src.Exposure = 10;

src.Exposure = 9;

src.Exposure = 11;

src.Exposure = 10;

src.Exposure = 15;

src.Exposure = 20;

src.Exposure = 10;

src.Exposure = 1;

src.Exposure = 2;

src.Binning = '2x2';

src.ClearCycles = 10;

src.ClearCycles = 20;

src.ClearCycles = 5;

src.ClearCycles = 1;

src.Binning = '1x1';

src.AutoContrast = 'OFF';

src.ClearCycles = 10;

src.ReadoutRate = 'P0S1: 100MHz, 16b, CMOS';

src.ReadoutRate = 'P0S0: 200MHz, 12b, CMOS';

src.ReadoutRate = 'P0S1: 100MHz, 16b, CMOS';

src.PP3ENABLED = 'NO';

src.PP2ENABLED = 'NO';

src.PP1ENABLED = 'NO';

src.PP0ENABLED = 'NO';

src.Exposure = 10;



% make preview in GUI
   Examples
      % Create a customized GUI.
      figure('Name', 'My Custom Preview Window');
      uicontrol('String', 'Close', 'Callback', 'close(gcf)');

      % Create an image object for previewing.
      vidRes = get(obj, 'VideoResolution'); % obj is videpinput obj
      nBands = get(obj, 'NumberOfBands');
      hImage = image(ax,zeros(vidRes(2), vidRes(1), nBands)); % ax is axes obj
      preview(obj, hImage);
