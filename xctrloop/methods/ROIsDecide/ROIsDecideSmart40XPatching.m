classdef ROIsDecideSmart40XPatching < ROIsDecide

    events
        updateGUI;
    end

    methods
        function obj = ROIsDecideSmart40XPatching()
            obj.addListeners();
        end
        
        function addListeners(obj)
            u = Context.getInstance().getData('mainVObj').userVObj;
            obj.addlistener('updateGUI',@u.displayPositions);
        end
        
        function dROIs = decideROIs(obj,m)
            p = m.imPipeline;
            dROIsXY = obj.arrangeROIs(p.pROIs40, ...
                p.imAbsPosition40{end}(end,1:2));
            zSeq = ZBehavior40X().determineZROISequence(m,p.zScanRange40);
            zSeq = obj.reDetermineZSeq(p,zSeq); % make 1st roi z as last roi
            dROIs = ROIsDecide2().combineROIsXYZ(dROIsXY,zSeq);
            
            obj.notify('updateGUI',...
                    DisplayPositionFeature(dROIsXY, 'b.'));
        end
        
        function dROIsXY = arrangeROIs(obj,dROIsXY,pos)
            dROIsXY = unique(dROIsXY,'rows','stable');
            dROIsXY = sortrows(dROIsXY,[2,1]);
            dROIsY = unique(dROIsXY(:,2),'stable');
            if numel(dROIsY)>1
                for iy = dROIsY(2:2:end)'
                    dROIsXY(dROIsXY(:,2)==iy,:) = ...
                        flipud(dROIsXY(dROIsXY(:,2)==iy,:));
                end
            end
            
            if sum((dROIsXY(end,:)-pos).^2) < sum((dROIsXY(1,:)-pos).^2)
                dROIsXY = flipud(dROIsXY);
            end
                
        end
        
        function zSeq = reDetermineZSeq(obj,p,zSeq)
            ROI = p.findLastValidFinishedROI();
            [~,idx] = min(abs(ROI(3)-zSeq([1,end])));
            if idx == 2
                if iscolumn(zSeq)
                    zSeq = flipud(zSeq);
                else
                    zSeq = fliplr(zSeq);
                end
            end
        end
    end






end