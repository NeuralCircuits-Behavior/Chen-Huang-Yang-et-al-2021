classdef EdgeDetect3 < EdgeDetect
    % ------------------
    % 2018/4/1
    % use abs positions replace relative position 
    % remove simulated camera
    % stage x axis changed 
    % ------------------
    
    properties(SetAccess = private)
        stepxy; % mm, array
        dirIdx_array; % 0-16
        stxy_rel_array; % relative to first one position
        stxy_curr_array;
        relxy;
        ori;
        stxy_quadrant; % objective or camera, oppsite to  stage
        quadrant_array; % objective or camera, oppsite to  stage
        
    end
    
    properties(Transient, SetAccess = private)
        nSearchEdge = 0; 
            % number of search at first step in once 
            % edge detetction whole brain slice
        nTime = 0; 
            % number of step in once edge detetction of a brain slice
        fArriveEdge = 0;
        stxy_curr_tmp;
        hFig;
    end
    
    properties(Transient, SetAccess = public)
        fFinished = 0;
    end
    
    properties(Constant, Access = private)
        expr = 'XY';
        moveIdx2qua = {1,4,[1,4],2,[1,2],16,1,4,16,[3,4],4,[2,3],2,3,16,16};
    end
    
    events
        % addlistener function at UserV 
        % event data is: DisplayPositionFeature(stxy_plot,mark)
        newDetection;
        % addlistener function at UserV 
        xyPositionChanged;
    end
    
    methods
        function obj = EdgeDetect3(dirObj,m)
            
            obj.dirObj = dirObj;

            % direction (N,W,S,E) is represent ROI or camera movement,
            % so sample or stage movement is opposite.
            % note stepx and stepy are positive, sign also depended on 
            % how stages are assembled .
            % current N and W are stage abs biggger directions.
            %                 N(stagey-,stagey samaller ROI is more to N)
            %  W(stagex-)    (laser or camera center)     E(stagex+)
            %                 S(stagey+)
            obj.stepxy = [ 0,                  -m.stageMObj.stepy;...  %dir1, N
                          -m.stageMObj.stepx,  0;...                   %dir2, W
                          0,                   +m.stageMObj.stepy;...  %dir3, S
                          +m.stageMObj.stepx,  0                  ];   %dir4, E
            obj.stepxy(5,:) = sum(obj.stepxy(1:2,:));                  %dir5, NW
            obj.stepxy(6,:) = sum(obj.stepxy(2:3,:));                  %dir6, SW
            obj.stepxy(7,:) = sum(obj.stepxy(3:4,:));                  %dir7, SE
            obj.stepxy(8,:) = sum(obj.stepxy([1,4],:));                %dir8, NE
            
            %{
            % 2019/1/11 directly use
            % future version will set changable ori, not use iniPosition_xyz
            % because sample may not be sticked at center. 
            obj.ori = m.stageMObj.manualSampleCenter;
            %}
            
            obj.addListeners();
        end
        
        %%
        function detectEdge(obj,m,p) 
            %{
                % note this  not accumulation
                obj.clearDetectionVars();
                obj.notify('newDetection');
            %}
            while ~obj.fFinished && ~p.fStopByUser && ~p.fPauseByUser
                
                obj.nTime = obj.nTime+1;
                
                if obj.nTime == 1
                    % initiate
                    obj.stxy_curr_array(1,:) = m.stageMObj.getXYCurrentPosition();
                    obj.quadrant_array(1) = ...
                        obj.getQuadrant(obj.stxy_curr_array(1,:),...
                        m.stageMObj.manualSampleCenter);
                    obj.stxy_rel_array(1,1:2) = [0,0];
                    obj.notify('xyPositionChanged',...
                        DisplayPositionFeature(obj.stxy_curr_array(1,1:2),'r.'));
                end 
                
                im = m.imPipeline.captureImage(m);
                obj.dirObj.getDetectedDir(im);
                obj.getRelMoveDistance(m.nScan_xy);
                
                obj.writeResult(m,p);
                
                obj.onceStageMove(m);
            end
            
        end
       %%
        function clearDetectionVars(obj)
            obj.nSearchEdge = 0;
            obj.nTime = 0;
            obj.fArriveEdge = 0;
            obj.fFinished = 0;
            obj.stxy_curr_tmp=[];
            obj.dirIdx_array=[];
            obj.stxy_rel_array=[]; % relative to first one position
            obj.stxy_curr_array=[];
            obj.quadrant_array=[];
            obj.relxy=[];
        end
        %%
        function setfFinished(obj,val)
            obj.fFinished = val;
        end
        %%
        function clearGUIDisplay(obj)
            obj.notify('newDetection');
        end
        %%
        function updateGUIDisplay(obj,xy,distype)
            obj.notify('xyPositionChanged',DisplayPositionFeature(xy,distype));
        end
    end
    
    methods(Access = private)
        %%  walking along edge
        function onceStageMove(obj,m)
            stxy_predict = round(obj.stxy_rel_array(end,1:2)+obj.relxy,4);
                % used to know whether will move to first position,
                % if yes will not record this position and move, quit cycle
            
            if  decideWhetherShouldStop(obj,m,stxy_predict)
                obj.fFinished = 1;
            else
                obj.stxy_rel_array(end+1, 1:2) = stxy_predict;
                abs_pos = obj.stxy_curr_array(1,1:2) + stxy_predict;
                m.stageMObj.moveAbsolute(...
                    obj.expr(obj.relxy~=0), abs_pos(obj.relxy~=0));
                m.stageMObj.waitForStageStatic(); % stage
                obj.stxy_curr_array(end+1, 1:2) = ...
                    m.stageMObj.getXYCurrentPosition();
                % record current position
                obj.quadrant_array(end+1) = ...
                    obj.getQuadrant(obj.stxy_curr_array(end,:),...
                    m.stageMObj.manualSampleCenter);
                
                obj.updateGUIDisplay(obj.stxy_curr_array(1:end-1,1:2),'bo-');
                obj.updateGUIDisplay(obj.stxy_curr_array(end,1:2),'ro-');
                
            end
            %----------------------------------------------------------------
            % local functions
            function tf = decideWhetherShouldStop(obj,m,stxy_predict)
                tfClose = any(all(abs(obj.stxy_rel_array(1:end-2,:) - stxy_predict) ...
                    < 0.005,2));
                    % if predict position is close (x,y axis both < 5 um ) 
                    % to alreadly moved positions, need stop.
                    % may have bug, need at least 2mm * 2mm sample
                    
                % need be a closed ployon
                %{
                tempRel = [obj.stxy_rel_array;stxy_predict];
                tempQua = [obj.quadrant_array,...
                    obj.getQuadrant(...
                    obj.stxy_curr_array(1,:) + stxy_predict,...
                    m.stageMObj.manualSampleCenter)];
                tfRepeatX = isequal(unique(tempRel(ismember(tempQua,1:4),1)),...
                    unique(tempRel(ismember(tempQua,2:3),1)));
                tfRepeatY = isequal(unique(tempRel(ismember(tempQua,1:2),2)),...
                    unique(tempRel(ismember(tempQua,3:4),2)));
                %}
                tf = tfClose;
            end
        end
        %%
        function qua = getQuadrant(obj,pos,ori)
            % this function is used to decide camera or ROI is in which 
            % quadrant depend on input stage abs positions.
            %              (stagey+)
            %              1   |   4
            % (stagex+)--  initiation pos  --(stagex-)
            %              2   |   3
            %              (stagey-)
            % quadrant 1 means that ROIs captured at abs postions whose 
            % x,y both bigger than initiation values will in the quadrant 1.
            % note: current now need put the sample at center, use initiation 
            % is ok, but if sample is sticked not at center, may occur error.
            
            deltaPos = pos-ori;
            if deltaPos(1)<0 && deltaPos(2)<=0
                qua = 1;
            elseif deltaPos(1)<=0 && deltaPos(2)>0
                qua = 2;
            elseif deltaPos(1)>0 && deltaPos(2)>=0
                qua = 3;
            elseif deltaPos(1)>=0 && deltaPos(2)<0
                qua = 4;
            end
        end
        
        %% get
        function getRelMoveDistance(obj,nScan_xy)
            dirIdx = obj.dirObj.dir_detected;
            if dirIdx > 0
                quaShouldIn = obj.moveIdx2qua{dirIdx};
                if ismember(obj.quadrant_array(end),quaShouldIn)
                    dir = obj.dirObj.movebit2dir(dirIdx);                    
                else
                    %dir = specialCase__(obj,[2,3,4,1]);
                    dir = specialCase__(obj,[5,6,7,8]); % 20180731,CH
                end
            else
                % outer
                if obj.nTime > 1 && obj.dirIdx_array(end)
                    %dir = specialCase__(obj,[6,7,8,5]); % 20180731,CH
                    dir = specialCase__(obj,[3,4,1,2]);
                else
                    dir = specialCase__(obj,[3,4,1,2]);
                end
            end
            %{
            switch dir
                case {1,2,3,4}
                    %{
                case 9 % 1001
                    dir_temp = [4,3,2,1];
                    dir = dir_temp(obj.dirIdx_array(end));
                case 6 % 0110
                    dir_temp = [2,1,4,3];
                    dir = dir_temp(obj.dirIdx_array(end));
                    %}
                case 0 %0 (out)
                    dir = specialCase__(obj,[3,4,1,2]);
                case 15 % 15(in)
                    dir = specialCase__(obj,[1,2,3,4]);
                case 16 % fake 0
                    dir = specialCase__(obj,[2,3,4,1]);
            end
            %}
            obj.relxy  = obj.stepxy(dir,1:2);
            if obj.nTime > 1
                obj.dirIdx_array(end+1) = dirIdx;
            else
                obj.dirIdx_array(1) = dirIdx;
                obj.fArriveEdge = 1;
            end
            %-------------------------------------------
            
            function dir = specialCase__(obj,dirs)
                dir = dirs(obj.quadrant_array(end));
            end
            
        end
        
        %%
        function writeResult(obj,m,p)
            %{
            % move into zBehavior
            if obj.nTime == 1
                p.dStartStagePosition(p.nROIsDetermination,:) = ...
                    [obj.stxy_curr_array(1,:),m.stageMObj.getZCurrentPosition()];
                p.dStartPiezoPosition(p.nROIsDetermination) = ...
                    m.piezoMObj.getPosition();
            end
            %}
            p.edPositions{p.nROIsDetermination}(obj.nTime,:) = ...
                obj.stxy_curr_array(obj.nTime,:);
            p.edRelTo1stPos{p.nROIsDetermination}(obj.nTime,:) = ...
                obj.stxy_rel_array(obj.nTime,:);
            p.edDirIdx{p.nROIsDetermination}(obj.nTime) = ...
                obj.dirIdx_array(obj.nTime);
        end
        %%
        function addListeners(obj)
            u = Context.getInstance().getData('mainVObj').userVObj;
            obj.addlistener('xyPositionChanged',@u.displayPositions);
            obj.addlistener('newDetection',@u.clearDisplayPos);
        end
        
        %%
        function showIm(obj,im)
            figure;
            imshow(imadjust(im),'Border','tight','InitialMagnification',30);
        end
        %%
        function saveIm(obj,im)
            func_writeTifFast(sprintf('%s%s.tif',obj.tempSavePath,...
                num2str(obj.stxy_rel_array(end,:),'%.4f_')),im,16);
        end
    end
    
end
