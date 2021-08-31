classdef DetectedDir4 < DetectedDir
    % 2018/5/12,CH
    % used for spinning disk confcal
    % add judgement of pure background
    % this method need to take one image as template 
    % use matlab SURF to get feture
    % multi tpi
    
    properties
        tpi; % here use as background
        ft;
        threshold;
        overlapSizes; 
            % overlapSize array, [x,y], not [rows,cols],mean axis
            % like [0.1, 0.1] means 10% of all pixs
        detectBgThreshold; % not use
        peakThresh;
    end
    
    properties(Access = private)
        cmp_range_rows;
        cmp_range_cols;
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
        function obj = DetectedDir4(tpi,overlapSizes,detectBgThreshold)
            obj.overlapSizes = overlapSizes;
            obj.detectBgThreshold = detectBgThreshold;
            obj.setTpi(tpi);
            obj.setCmpRange();
            obj.setThreshold();
            obj.setPeakThresh();
        end
        
        %%
        function setTpi(obj,tpi)
            obj.tpi = tpi;
        end
        %%
        function setCmpRange(obj)
            [im_sz_rows,im_sz_cols,~] = size(obj.tpi);
            
            % 10% of all pixs, need be equal to overlap!!!!!!!  
            % overlapSizes not [rows,cols],mean axis
            sz_sub_rows = round(im_sz_rows * obj.overlapSizes(2)); 
            sz_sub_cols = round(im_sz_cols * obj.overlapSizes(1));
            
            obj.cmp_range_rows = [1:sz_sub_rows;...    % left up
                1:sz_sub_rows;... % right up
                im_sz_rows-sz_sub_rows+1:im_sz_rows;...% left bottem
                im_sz_rows-sz_sub_rows+1:im_sz_rows]; % right bottem
            
            obj.cmp_range_cols = [1:sz_sub_cols;...    % left up
                im_sz_cols-sz_sub_cols+1:im_sz_cols;... % right up
                1:sz_sub_cols;...% left bottem
                im_sz_cols-sz_sub_cols+1:im_sz_cols]; % right bottem
        end
        %%
        function setThreshold(obj)
            % 6 x tpi std
            %temp = double(arrayfun(@(ii)mean2(obj.tpi(obj.cmp_range_rows(ii,:),...
            %    obj.cmp_range_cols(ii,:))),1:4));
            temp = double(obj.tpi(:));
            obj.threshold = mean(temp) + std(temp)*6;
        end
        
        function peakThresh__ = setPeakThresh(obj)
            peakThresh__ = 1000;
            step = 100;
            peakThresh_ = zeros(size(obj.tpi,3),1);
            for it = 1:size(obj.tpi,3)
                while obj.getFrameNum(obj.tpi(:,:,it),peakThresh__) > 3
                    peakThresh__ = peakThresh__ + step;
                end
                peakThresh_(it) = peakThresh__;
            end
            obj.peakThresh = mean(peakThresh_);
        end
        
        function n = getFrameNum(obj,im,t)
            points = detectSURFFeatures(preprocess(im),...
                'MetricThreshold',t,...
                'NumOctaves',4);
            n = points.Count;
            
            function im = preprocess(im)
                im = imadjust(im,stretchlim(im,0));
            end
        end
        
        
        %%
        function getDetectedDir(obj,im)
            im_gray = arrayfun(@(ii)mean2(im(obj.cmp_range_rows(ii,:),...
                obj.cmp_range_cols(ii,:))),1:4);
            obj.ft = im_gray > obj.threshold;
            obj.dir_detected = obj.ft * 2.^(3:-1:0)';
                % bin2dec(sprintf('%d',ft));
            if obj.dir_detected
                %obj.dir_detected = obj.movebit2dir(obj.dir_detected);
            else
                % 0
                featureNum = obj.getFrameNum(im,obj.peakThresh);
                stats = regionprops(edge(im,'approxcanny'),'area');
                edgePerimeter = median([stats.Area]);
                if  featureNum > 2 || edgePerimeter >= 40 % fake 0
                    obj.dir_detected = 16;
                end
            end
        end
        
    end
    
    
end