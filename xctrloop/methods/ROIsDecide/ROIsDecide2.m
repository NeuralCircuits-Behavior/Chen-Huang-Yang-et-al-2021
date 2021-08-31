classdef ROIsDecide2 < ROIsDecide
    % ---------------------------------------------------------------------------------------------------
    % 2018/4/13, CH
    % used to decide ROIs depending on detected edge positions
    % final ROIs include edge ROIs, 
    % all ROIs in ROIsDetermineRate * x * y. order z-x-y, one tile by one tile 
    % Axial scan: 16x is stage movement and 40x is poezo movement
    
    % ---------------------------------------------------------------------------------------------------
    
    properties
        stxyROIsAbsPos; % one slice
        zROIsPos; 
            % could be piezo (positions need to move to) or 
            % stage (abs positions need to move to)
            % col vecter, unique
    end
    
    events
        updateGUI;
    end
        
    methods
        %%
        function obj = ROIsDecide2()
            obj.addListeners();
        end
        
        function addListeners(obj)
            u = Context.getInstance().getData('mainVObj').userVObj;
            obj.addlistener('updateGUI',@u.displayPositions);
        end
        
        function dROIs = decideROIs(obj,m,p,edMethod)
            % 2019/9/3, CH
            if nargin<4
                edMethod = 'auto';
            end
            
            switch lower(edMethod)
                case 'auto'
                    obj.stxyROIsAbsPos = obj.determineXYPositions(m,p);
                case {'rectangle','rec','rect'}
                    halfy = mean(p.distFromCenter(1:2));
                    halfx = mean(p.distFromCenter(3:4));
                    center = m.stageMObj.manualSampleCenter + ...
                        [diff(p.distFromCenter(3:4)),diff(p.distFromCenter(1:2))]/2;
                    obj.stxyROIsAbsPos = func_determineRecROIXY(...
                        [m.stageMObj.stepx,m.stageMObj.stepy],...
                        center,[halfx,halfy]);
            end
            
            if p.nROIsDetermination>1
                % 2019/9/30, CH
                % correct xy small shift by determination between sections
                
                lastROIs = unique(p.dROIsAll{p.nROIsDetermination-1}(:,1:2),'rows');
                obj.stxyROIsAbsPos = func_correctROIsXY(...
                    lastROIs,obj.stxyROIsAbsPos,...
                    [m.stageMObj.stepx,m.stageMObj.stepy]);
            end
            
            p.zLocWhenROIsFinish = isodd(size(obj.stxyROIsAbsPos,1));
            
            % 2020/1/11, CH
            % keep overlap engough, and bottom fine scan
            % 3 more z rois
            if isempty(p.zScanRangeReal)
                zScanRange = p.zScanRange;
            else
                zScanRange = p.zScanRangeReal;
            end
            obj.zROIsPos = obj.determineZPositions(m,zScanRange);
            
            dROIs = obj.combineROIsXYZ(obj.stxyROIsAbsPos,obj.zROIsPos);
            
            obj.notify('updateGUI',...
                DisplayPositionFeature(obj.stxyROIsAbsPos, 'rx'));
            %obj.plotSliceROIs(dROIs);
        end
        
        function dROIs = combineROIsXYZ(obj,xy_,z_)
            xy = repelem(xy_,numel(z_),1);
            z = repmat([z_;flipud(z_)],ceil(size(xy_,1)/2),1);
            dROIs = [xy,z(1:size(xy,1))];
        end
        
        
        function plotSliceROIs(obj,dROIs)
            f = figure;hold on;
            plot3(dROIs(:,1),dROIs(:,2),dROIs(:,3),'.-');
            plot3(dROIs(1,1),dROIs(1,2),dROIs(1,3),'o');
            f.Children.YDir = 'reverse';
            xlim(15+[-10,10]);
            ylim(15+[-10,10]);
        end
    end
    
    methods(Access = protected)
        function stxyROIsAbsPos = determineXYPositions(obj,m,p)
            stxyRelArray = ...
                p.edRelTo1stPos{p.nROIsDetermination};
            stxyCurArray = ...
                p.edPositions{p.nROIsDetermination};
            stepx = max(p.edObj.stepxy(:,1));
            tfNeedMove = p.edDirIdx{p.nROIsDetermination} == 0;%false(size(p.edDirIdx{p.nROIsDetermination}));%p.edDirIdx{p.nROIsDetermination} == 0;
                % remove outter ROIs
            stxyNeedMove = stxyCurArray(tfNeedMove,:);
            
            stxyRelArraySorted = sortrows(stxyRelArray,[2,1],'descend');
            % here sort by y then by x, axis vertical to scan dir
            idxMin = [find(abs(diff(stxyRelArraySorted(:,2)))>.01);...
                size(stxyRelArraySorted,1)]; % index of max val , col vecter
            idxMax = [1;idxMin(1:end-1)+1]; % index of min val , col vecter
            
            stxStartEndPerRow = ...
                [stxyRelArraySorted(idxMin,1),...
                stxyRelArraySorted(idxMax,1)] + stxyCurArray(1,1);
            % now at first row, first col is smaller val,
            % second is bigger val, depend on axis
            
            posSpace = round((stxyRelArraySorted(idxMax,1) - ...
                stxyRelArraySorted(idxMin,1))./abs(stepx)); % col vecter
            
            stxyROIsAbsPos = zeros(sum(posSpace+1),2);
            for irow = 1:numel(idxMax)
                xTemp = stxStartEndPerRow(irow,mod(irow,2)+1) ...
                    + (-1)^mod(irow,2) * (0:posSpace(irow)) * abs(stepx);
                % (-1)^mod(irow,2) decide descend or ascend
                stxyROIsAbsPos(sum(posSpace(1:irow)+1) - ...
                    posSpace(irow):sum(posSpace(1:irow)+1), 1:2) = ...
                    [xTemp',repmat(stxyRelArraySorted(idxMax(irow),2) ...
                    + stxyCurArray(1,2),numel(xTemp),1)];
            end

            curPos = m.stageMObj.getXYCurrentPosition();
            dist__ = @(a,b)sum((a-b).^2);
            if dist__(curPos,stxyROIsAbsPos(end,:)) < ...
                    dist__(curPos,stxyROIsAbsPos(1,:))
                stxyROIsAbsPos = flipud(stxyROIsAbsPos);
            end
            
            %{
            % remove outter ROIs
            tfM = @(a,b,p)abs(a(:,p)-b(:,p)')<= 0.005;
            tfMove = any(tfM(stxyROIsAbsPos,stxyNeedMove,1) & ...
                tfM(stxyROIsAbsPos,stxyNeedMove,2),2);
            stxyROIsAbsPos = stxyROIsAbsPos(~tfMove,:);
            % 20180808,CH, remove indiviadual outter pos
            [tfIn,tfOn] = inpolygon(stxyROIsAbsPos(:,1),stxyROIsAbsPos(:,2),...
                stxyCurArray(:,1),stxyCurArray(:,2));
            % some close pos need to remain
            moveIdx = find(~(tfIn|tfOn));
            tfMove = ~any(tfM(stxyCurArray,stxyROIsAbsPos(moveIdx,:),1) & ...
                tfM(stxyCurArray,stxyROIsAbsPos(moveIdx,:),2));
            stxyROIsAbsPos(moveIdx(tfMove),:) = [];
            %}
        end
        
        function zROIsPos = determineZPositions(obj,m,zScanRange)
            zROIsPos = m.imPipeline.zBehavior.determineZROISequence(m,zScanRange);
        end
    end
    
    
    
    
    
    
    
    
    
    
    
    
end