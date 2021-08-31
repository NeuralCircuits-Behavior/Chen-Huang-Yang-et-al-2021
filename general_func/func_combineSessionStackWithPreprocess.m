function func_combineSessionStackWithPreprocess(list,fileName,fDeleteOrignalData,varargin)

if isempty(varargin)
    cd(list(1).folder);
else
    cd(varargin{1});
end

if isempty(fileName)
    FileTif = regexp(list(1).name,'(?<=exa_)[\d.]+_[\d.]+','match');
    FileTif = ['stack_',FileTif{1}];
else
    FileTif = fileName;
end

if nargin < 3
    fDeleteOrignalData = 0;
end

imdata = imread(fullfile(list(1).folder,list(1).name));
sz1 = size(imdata,1);
sz2 = size(imdata,2);

stack = zeros(sz1,sz2,numel(list),'uint16');
stack(:,:,1) = imdata;
for i = 2:numel(list)
    stack(:,:,i) = imread(fullfile(list(i).folder,list(i).name));
end

func_writeTifFast8(func_preprocessBeforeStitching([],[],stack),FileTif);

if fDeleteOrignalData
    %delete(fullfile(list(1).folder,list(1).name));
end

end



