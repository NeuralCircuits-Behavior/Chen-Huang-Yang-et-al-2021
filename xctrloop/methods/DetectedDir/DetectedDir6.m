classdef DetectedDir6 < DetectedDir
    % 2018/5/25,CH
    % used for spinning disk confcal
    % add judgement of pure background
    % this method need to take one image as template 
    % use matlab SURF to get feture
    % multi tpi
    % use distribition to get thershold of four conners
    % unifrom direction, not specify any more, only 16 or 0
    % corners gray index specific
    
    properties
        tpi; % here use as background
        tpiCornerStack;
        tpiCornerFlat; % (120*120*n)*4 array
        ft;
        threshold;
        overlapSizes; 
            % overlapSize array, [x,y], not [rows,cols],mean axis
            % like [0.1, 0.1] means 10% of all pixs
        detectBgThreshold; 
        peakThresh;
    end
    
    properties %(Access = private)
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
    
    events
        getCurrentThreshold
    end
    
    methods
        %%
        function obj = DetectedDir6(tpi,overlapSizes,detectBgThreshold)
            obj.overlapSizes = overlapSizes;
            obj.setTpi(tpi);
            obj.setCmpRange();
            obj.setThreshold();
            %obj.peakThresh = obj.setPeakThresh();
            obj.detectBgThreshold = detectBgThreshold;
            try
                u = Context.getInstance().getData('mainVObj').userVObj;
                obj.addlistener('getCurrentThreshold',@u.getCurrentThreshold);
            catch
                fprintf('Failed to add listener for event ''getCurrentThreshold''.\n');
                fprintf('Will use inintiated detectBgThreshold.\n');
            end
        end
        
        %%
        function setTpi(obj,tpi)
            obj.tpi = tpi;
        end
        %%
        function detectBgThreshold = get.detectBgThreshold(obj)
            obj.notify('getCurrentThreshold');
            detectBgThreshold = obj.detectBgThreshold;
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
            % not Threshold
            obj.tpiCornerStack = arrayfun(@(ii)obj.tpi(obj.cmp_range_rows(ii,:),...
                obj.cmp_range_cols(ii,:),:),1:4,'unif',0); % 1x4 cell
            %obj.tpiCornerFlat = cell2mat(cellfun(@(ii)ii(:),obj.tpiCornerStack,...
            %    'unif',0));
            obj.tpiCornerFlat = cell2mat(cellfun(@(ii)reshape(mean(ii,3),[],1),...
                obj.tpiCornerStack,'unif',0));
            obj.tpiCornerFlat = double(obj.tpiCornerFlat);
        end
        
        function peakThresh__ = setPeakThresh(obj)
            peakThresh__ = 1;
            step = 1;
            peakThresh_ = zeros(size(obj.tpi,3),1);
            for it = 1:size(obj.tpi,3)
                while obj.getFrameNum(obj.tpi(:,:,it),peakThresh__)
                    peakThresh__ = peakThresh__ + step;
                end
                peakThresh_(it) = peakThresh__;
            end
            obj.peakThresh = max(peakThresh_);
        end
        
        function n = getFrameNum(obj,im,t)
            n = size(vl_sift(single(im), 'PeakThresh', t),2);
        end

        %%
        function getDetectedDir(obj,im)
            % 50% pixels bigger than threshold set 1  
            im = double(im);
            obj.ft = zeros(1,4);
            im_gray = cell(4);
            for c = 1:4
                im_gray_ = im(obj.cmp_range_rows(c,:),...
                    obj.cmp_range_cols(c,:));
                im_gray{c} = im_gray_;
                obj.ft(c) = median(mean(obj.tpiCornerFlat(:,c)<im_gray_(:)'));
            end
            %obj.ft = cellfun(...
            %   @(im,tpi)median(mean(tpi<im(:)')),im_gray,obj.tpiCornerFlat);
            LogClass.getInstance().writeLog(...
                sprintf('tpi<im:%s',num2str(obj.ft,'%.3f ')));
            obj.ft = obj.ft > obj.detectBgThreshold;
            obj.dir_detected = 0;
            if any(obj.ft)
                obj.dir_detected = 16;
            else
                % 0
                %{
                % comment at 2018/11/19
                % extrcat four coners features
                for c = 1:4
                    if obj.getFrameNum(im_gray{c},obj.peakThresh)
                        obj.dir_detected = 16;
                        return
                    end
                end
                %}
                %{
                % reach here means that four coners all 0
                if  obj.getFrameNum(im,8) > 3 % fake 0
                    obj.dir_detected = 16;
                end
                %}
            end
        end
        
    end
    
    
end

function im = preprocess(im)
im = imadjust(im,stretchlim(im,0));
end