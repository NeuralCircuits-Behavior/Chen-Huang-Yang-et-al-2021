classdef ROIsDecideSmart40X < ROIsDecide
    
    
    events
        updateGUI;
        clearGUI;
    end
    
    methods
        function obj = ROIsDecideSmart40X()
            obj.addListeners();
        end
        
        function addListeners(obj)
            u = Context.getInstance().getData('mainVObj').userVObj;
            obj.addlistener('updateGUI',@u.displayPositions);
            obj.addlistener('clearGUI',@u.clearDisplayPos);
        end
        
        function dROIs = decideROIs(obj,m)
            p = m.imPipeline;
            % when finish 16x imaging, position was oppsite
            dROIsXY = flipud(p.dROIsXY);
            if size(p.dROIsXY,1) ~= numel(p.dROIsTf)
                dROIsTf = reshape(fliplr(reshape(p.dROIsTf,9,[])),[],1);
            else
                dROIsTf = flipud(p.dROIsTf);
            end
            [dROIsXY40,dROIsTf40] = ...
                obj.segment16XROIs(dROIsXY,dROIsTf,p.stepxy40); % 40x xy ROIs
            
            % 2019/9/30,CH
            [dROIsXY40,dROIsTf40] = addLastROIsXY40(...
                dROIsXY40,dROIsTf40,p.aROIs40);
            
            % 2019/10/31, align 16x and 40x roi center
            try
                delta = [m.objectiveMObj.deltaXPosition,...
                    m.objectiveMObj.deltaYPosition];
            catch
                delta = [0,0];
            end
            dROIsXY40 = dROIsXY40 + delta;
            
            zSeq = ZBehavior40X().determineZROISequence(m,p.zScanRange40);
            dROIs = ROIsDecide2().combineROIsXYZ(dROIsXY40,zSeq);
            dROIs(:,4) = repelem(dROIsTf40,numel(zSeq));
                        
            obj.notify('clearGUI');
            obj.notify('updateGUI',...
                    DisplayPositionFeature(dROIsXY40(dROIsTf40==1,:),'b+'));
            obj.notify('updateGUI',...
                    DisplayPositionFeature(dROIsXY40(dROIsTf40==0,:),'r.'));
        end
        
        function [dROIsXY40,dROIsTf40] = ...
                segment16XROIs(obj,dROIsXY,dROIsTf,stepxy40)
            sortDirX = getSortDirX(dROIsXY(:,1));
            sortDirY = getSortDirY(dROIsXY(:,2));
            
            dROIsXY40 = [processOneAxis(dROIsXY(:,1),stepxy40(:,1)),...
                processOneAxis(dROIsXY(:,2),stepxy40(:,2))];
            % dROIsTf40 = repelem(dROIsTf,9); % current 9 sub images all 1
            dROIsTf40 = dROIsTf(:);
            dROIs40 = [dROIsXY40,dROIsTf40];
            dROIs40 = sortrows(dROIs40,[2,1],{sortDirY,sortDirX});
            
            dROIs40Y = unique(dROIs40(:,2),'stable');
            for iy = dROIs40Y(2:2:end)'
                dROIs40(dROIs40(:,2)==iy,:) = ...
                    flipud(dROIs40(dROIs40(:,2)==iy,:));
            end
            
            dROIsXY40 = dROIs40(:,1:2);
            dROIsTf40 = dROIs40(:,3);
        end
    end
end

function x = processOneAxis(x,x_)
x = (x+x_')';
x = x(:);
end

function sortDir = getSortDirY(y)
Y = unique(y,'stable');
if numel(Y) == 1
    sortDir = 'ascend';
    return
end
switch sign(diff(Y(1:2)))
    case -1
        sortDir = 'descend';
    case 1
        sortDir = 'ascend';
end
end

function sortDir = getSortDirX(x)
if numel(x) == 1
    sortDir = 'ascend';
    return
end
switch sign(diff(x(1:2)))
    case -1
        sortDir = 'descend';
    case 1
        sortDir = 'ascend';
end
end

function [curr,tf] = addLastROIsXY40(curr,tf,last)
% 2019/9/30,CH

if isempty(last)
    return 
end

tmpROIs = [];
tmpTf = [];
for i = 1:size(last,1)
    dist = sum((curr-last(i,:)).^2,2);
    idx = find(dist<(1.5/1000)^2);
    if numel(idx)==0
        tmpROIs = [tmpROIs;last(i,:)];
        tmpTf = [tmpTf;1];
    elseif numel(idx)==1
        tf(idx) = 1;
    elseif numel(idx)>1
        % error
        keyboard;
    end
end
curr = [curr;tmpROIs];
tf = [tf;tmpTf];
end