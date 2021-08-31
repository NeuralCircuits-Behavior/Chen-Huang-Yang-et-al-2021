
acPath = 'E:\Data\CH\autoCollectionData';

re16 = 0.75576;
re40 = 0.27361;

olp40 = 0.1;
olp16 = 1 - 3 * ( 1 - olp40) * re40 / re16;

z0 = round(re40 *1200 / re16);
z1 = round((0.5 * re40 + (olp40 - 1) * re40 + 0.5 * re16) * 1200 / re16);
z2 = round(olp40 * re40 *1200 / re16);


t = tcpip('127.0.0.1', 5001, 'NetworkRole', 'server',...
    'OutputBufferSize',1000,'InputBufferSize',512*512*2*1000,...
    'Timeout',24*40*60);

fopen(t);

mo = createMatObj(getMatObjFileName(acPath));
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
%im = imSegment(im,z0,z1,z2) ;
%%
figure();
warning off;
while 1
    fResize = fread(t,1,'uint16');
    if fResize
        im_1 = fread(t,1200*1200,'uint16');
        maxI = max(im_1(:));
        %im1 = imSegment(uint16(reshape(im_1',[1200,1200])),z0,z1,z2);
        %im = imSegment(im,z0,z1,z2);
        beep2;
        montage(repmat(reshape(imSegment(uint16(reshape(im_1',[1200,1200])),z0,z1,z2),512,512,1,9),1,1,3,1));
        p_ = '';
        validInputTf = 0;
        while ~validInputTf
            [validInputTf,p_] = processInput(...
                input(sprintf('%d, + add, - minus\n',maxI),'s'));
        end
        disp(p_);
        
        %{
        while numel(p_)~=9 || checkNum(p_)
            p_ = input(sprintf('%d, 1 or 0\n',maxI),'s');
        end
        %}
    else
        im_ = fread(t,512*512,'uint16');
        maxI = max(im_(:));
        
        if maxI>=300
            % ~2x std
            fwrite(t,'1');
            writeMatObj(mo,1,maxI);
            continue
        elseif maxI<=134
            fwrite(t,'0');
            writeMatObj(mo,0,mean2(im_));
            continue
        end
        
        im = uint16(reshape(im_',[512,512]));
        beep2;
        %{
        imshow(func_imadjust(im),...
            'InitialMagnification',100);
        %}
        
        imshow(imadjust(im(:,:),stretchlim(im(:,:),0)),...
            'InitialMagnification',100);
        %}
        p_ = '';
        while numel(p_)~=1 || checkNum(p_)
            p_ = input(sprintf('%d, 1 or 0\n',maxI),'s');
        end
        
        if str2double(p_)>=1
            writeMatObj(mo,1,maxI);
        else
            writeMatObj(mo,0,mean2(im_));
        end
    end
    %{
    maxI = max(im(:));
    for k = 1:size(im,3)
        com.mathworks.mwswing.MJUtilities.beep;
        imshow(imadjust(im(:,:,k),stretchlim(im(:,:,k),0)),...
            'InitialMagnification',240);
        p_ = input(sprintf('%d, 1 or 0\n',maxI));
        fwrite(t,num2str(p_));
    end
    %}
    fwrite(t,p_); 
    %clearvars im*
end
%%
function ims = imSegment(img,z0,z1,z2)
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

function tf = checkNum(str)
tf  = ~isempty(regexp(str,'\D', 'once'));
end

function mo = createMatObj(fName)
mo = matfile(fName,'Writable',true);
[mo.im0s,mo.im1s] = deal([]);
end

function fName = getMatObjFileName(acPath)
c = clock();
prefix = regexprep(num2str(c(1:3),'%02d'),' ','');
list = dir(fullfile(acPath,sprintf('%s_*.mat',prefix)));
fName = fullfile(acPath,sprintf('%s_%02d.mat',prefix,numel(list)+1));
end

function writeMatObj(mo,type,data)
if ischar(type)
    type = str2double(type)>=1 + 0 ;
end
switch type
    case 0
        mo.im0s(end+1,1) = data;
    case 1
        mo.im1s(end+1,1) = data;
end
end

function [validInputTf,p0] = processInput(p)
keyboardSeq = [7,8,9,4,5,6,1,2,3];
if isempty(p)
    validInputTf = 0;
    p0 = [];
    return
end
switch p(1)
    case '+'
        p0 = repmat('0',1,9);
        idx = str2double(regexp(p,'\d','match'));
        if isempty(idx)
            validInputTf = 0;
        elseif any(~idx)
            validInputTf = 1;
        else
            validInputTf = 1;
            p0(keyboardSeq(idx)) = '1';
        end
    case '-'
        p0 = repmat('1',1,9);
        idx = str2double(regexp(p,'\d','match'));
        if isempty(idx)
            validInputTf = 0;
        elseif any(~idx)
            validInputTf = 1;
        else
            validInputTf = 1;
            p0(keyboardSeq(idx)) = '0';
        end
    otherwise
        validInputTf = ~(numel(p)~=9 || checkNum(p));
        p0 = p;
end

end