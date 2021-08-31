classdef DetectedDir7 < DetectedDir
    % 2018/8/21,CH
    % CNN
    
    properties
        tpi; % here use as background
        overlapSizes; 
            % overlapSize array, [x,y], not [rows,cols],mean axis
            % like [0.1, 0.1] means 10% of all pixs
    end
    
    properties(Transient)
        tcpW
    end
    
    properties(Constant)
        movebit2dir = [3,2,2,4,3,6,2,1,9,1,1,4,3,4,15];
        % 4 bits sequence is upper left, upper right, lower left, lower right
        % of each images
        % bitcode,  index, dir(N, W, S, E), quadrant
        % 1000      8   1  4    % 1011      11  1  4     % 1010  10   1   3,4
        % 0010      2   2  4    % 0111      7   2  1     % 0011  3    2   1,4
        % 0001      1   3  1    % 1101      13  3  2     % 0101  5    3   1,2
        % 0100      4   4  2    % 1110      14  4  3     % 1100  12   4   2,3
        % 1001      9   9       % 0110      6   6        % 1111  15  15
    end
    
    
    methods
        %%
        function obj = DetectedDir7(tpi,overlapSizes,detectBgThreshold)
            obj.overlapSizes = overlapSizes;
            obj.tcpW = Context.getInstance().getData('mainMObj').tcpW;
        end
        %%
        function getDetectedDir(obj,im)
            data = preprocess(im,obj.tcpW.outSize);
            obj.tcpW.fwrite_(data);
            obj.dir_detected = fread_(obj.tcpW) * 16;
            LogClass.getInstance().writeLog(...
                sprintf('Detection result:%d',obj.dir_detected)...
                ); 
        end
    end
end

function data = preprocess(im,outSize)
data = imresize(im,outSize);
data = [0,data(:)'];
end