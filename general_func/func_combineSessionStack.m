function func_combineSessionStack(list,fileName,fDeleteOrignalData,varargin)

if isempty(varargin)
    cd(list(1).folder);
    fPreprocess = 0;
else
    cd(varargin{1});
    fPreprocess = varargin{2};
end

if isempty(fileName)
    FileTif = regexp(list(1).name,'(?<=exa_)[\d.]+_[\d.]+','match');
    FileTif = ['stack_',FileTif{1}];
else
    FileTif = fileName;
end

if nargin < 3
    fDeleteOrignalData = 0;
    fPreprocess = 0;
end

imread_ = getImreadFunc(fPreprocess);

t = Tiff(FileTif,'w');

imdata = imread_(list(1).folder,list(1).name);

sz1 = size(imdata,1);
sz2 = size(imdata,2);

t = set_(t,sz1,sz2);

t.write(imdata);

for i = 2:numel(list)
    t.writeDirectory();
    t = set_(t,sz1,sz2);
    t.write(imread_(list(i).folder,list(i).name));
    if fDeleteOrignalData
        delete(fullfile(list(i).folder,list(i).name));
    end
end
if fDeleteOrignalData
    delete(fullfile(list(1).folder,list(1).name));
end
t.close();
end

function t = set_(t,sz1,sz2)
t.setTag('ImageLength',sz1);
t.setTag('ImageWidth',sz2);
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('BitsPerSample',16);
t.setTag('SamplesPerPixel',1);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
end

function func = getImreadFunc(fPreprocess)
if fPreprocess
    func = @func_preprocessBeforeStitching;
else
    func = @(f,n)imread(fullfile(f,n));
end

end


