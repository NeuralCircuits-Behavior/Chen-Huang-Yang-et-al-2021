classdef EdgeDetect2 < EdgeDetect
    % ------------------
    % 2017/7/25
    % use abs positions replace relative position 
    % ------------------
    
    properties(SetAccess = private)
        stepxy; % mm, array
        dir_array;
        stxy_rel_array; % relative to first one position
        stxy_curr_array;
        relxy;
    end
    
    properties(Transient, SetAccess = private)
        nSearchEdge = 0; 
            % number of search at first step in once 
            % edge detetction whole brain slice
        nTime = 0; 
            % number of step in once edge detetction a brain slice
        fArriveEdge = 0;
        fFinished = 0;
        stxy_curr_tmp;
    end
    
    properties(Constant, Access = private)
        expr = 'XY';
    end
    
    events
        % addlistener function at UserV 
        % event data is: DisplayPositionFeature(stxy_plot,mark)
        newDetection;
        % addlistener function at UserV 
        xyPositionChanged;
    end
    
    methods
        function obj = EdgeDetect2(dirObj,mainMObj)
            obj.dirObj = dirObj;

            obj.stepxy= [ 0, mainMObj.stageMObj.stepy;... %dir1, N
                -mainMObj.stageMObj.stepx, 0;... %dir2, W
                0, -mainMObj.stageMObj.stepy;... %dir3, S
                +mainMObj.stageMObj.stepx, 0]; %dir4, E
            
            obj.addListeners();
        end

        %% get
        function getRelMoveDistance(obj,nScan_xy)
            dir = obj.dirObj.dir_detected;
            
            if obj.nTime == 1
                dir_temp = mod(nScan_xy,2)*2+1; 
                    % odd nScan, 3(S) oppsite to most first edge detetction; 
                    % even nScan, 1(N) equal to most first edge detetction
                switch dir
                    case {1,2,3,4}
                        obj.relxy = obj.stepxy(dir,1:2);
                        obj.dir_array(1) = dir;
                        obj.fArriveEdge = 1;
                    case 15
                        obj.relxy = obj.stepxy(dir_temp,1:2);  % in
                    case 0
                        obj.relxy = -obj.stepxy(dir_temp,1:2); % out
                    otherwise
                        % unknown happened,dir is nan
                        keyboard; % manual move future
                end
            else
                switch dir
                    case {1,2,3,4}
                    case 9 % 1001
                        dir_temp = [4,3,2,1];
                        dir = dir_temp(obj.dir_array(end));
                    case 6 % 0110
                        dir_temp = [2,1,4,3];
                        dir = dir_temp(obj.dir_array(end));
                    otherwise
                        % unknown happened,dir is 15(in) or 0(out)
                        % error happened
                        keyboard;
                end
                obj.relxy  = obj.stepxy(dir,1:2);
                obj.dir_array(end+1) = dir;
            end
        end
        %%
        function detectEdge(obj,mainMObj) 
            % note this function will not accumulation
            
            str = sprintf('Start detecting edge. NO.%d',mainMObj.ndetectedge);
            LogClass.getInstance().writeLog(str);
            
            obj.clearDetectionVars();
            
            obj.notify('newDetection');
            
            while ~obj.fFinished
                obj.nTime = obj.nTime+1;
                while ~obj.fArriveEdge
                    obj.nSearchEdge = obj.nSearchEdge + 1;
                    obj.beforeGetEdge(mainMObj);
                end
                obj.onceStageMove(mainMObj);
            end
            
            obj.writeResult(mainMObj); 
                % write vars into mainMObj, index by mainMObj.ndetectedge
            
            obj.clearDetectionVars();
            
            str = sprintf('Finish detecting edge. NO.%d',mainMObj.ndetectedge);
            LogClass.getInstance().writeLog(str);
            
        end
        %%  walking along edge
        function onceStageMove(obj,mainMObj)
            mainMObj.stageMObj.waitForStageStatic(); 
                % check stage whether movement

            stxy_predict = roundn(obj.stxy_rel_array(end,1:2)+obj.relxy,-4); 
                % used to know whether already at first position, 
                % if yes will not record this position and move, quit cycle
            
            if  isequal([0,0],stxy_predict)          
                obj.fFinished = 1;
                
            elseif   ~ismember(stxy_predict, ...
                    obj.stxy_rel_array(2:end,1:2), 'rows')
                
                obj.stxy_rel_array(end+1, 1:2) = stxy_predict;
 
                obj.stxy_curr_array(end+1, 1:2) = ...
                    mainMObj.stageMObj.getXYCurrentPosition(); 
                    % record current position
                obj.notify('xyPositionChanged',...
                    DisplayPositionFeature(obj.stxy_curr_array(end,1:2),'bo'));

                obj.notifyCamera(mainMObj);
                
                obj.dirObj.getDetectedDir(mainMObj.cameraMObj.im_captured);
                obj.getRelMoveDistance(mainMObj.nScan_xy);
                
                % move to a absolute pos calculated by first position, 
                % can't by last position
                abs_pos = obj.stxy_curr_array(1,1:2) + ...
                    obj.stxy_rel_array(end,1:2) + obj.relxy;
                mainMObj.stageMObj.moveAbsolute(...
                    obj.expr(obj.relxy~=0), abs_pos(obj.relxy~=0));
            else
                % error happened
                keyboard;
            end
        end
        %% before arriving at edge
        function beforeGetEdge(obj,mainMObj)
             mainMObj.stageMObj.waitForStageStatic(); % stage
            
            obj.stxy_curr_tmp = mainMObj.stageMObj.getXYCurrentPosition();
                       
            obj.dirObj.getDetectedDir(obj.captureIm(mainMObj));
            
            obj.getRelMoveDistance(mainMObj.nScan_xy);
            
            if obj.fArriveEdge
                obj.stxy_rel_array(1,1:2) = [0,0];
                obj.stxy_curr_array(1,1:2) = obj.stxy_curr_tmp;
                obj.notify('xyPositionChanged',...
                    DisplayPositionFeature(obj.stxy_curr_array(1,1:2),'bo'));
                % move to a absolute pos calculated by first position
                abs_pos = obj.stxy_curr_array(1,1:2) + obj.relxy;
                mainMObj.stageMObj.moveAbsolute(...
                    obj.expr(obj.relxy~=0),abs_pos(obj.relxy~=0));
            else
                obj.notify('xyPositionChanged',...
                    DisplayPositionFeature(obj.stxy_curr_tmp,'ro'));
                mainMObj.stageMObj.moveRelative(...
                    obj.expr(obj.relxy~=0),obj.relxy(obj.relxy~=0));
            end
        end
        %%
        function im = captureIm(obj,mainMObj)
            switch mainMObj.cameraMObj.type
                case 'simulate'
                    mainMObj.cameraMObj.notify('captureImageNow',...
                        SimulatedImageFeature(obj,'edgedetect'));
                    im = mainMObj.cameraMObj.im_captured;
                otherwise
                    im = mainMObj.cameraMObj.captureImage();
            end
        end
        %%
        function clearDetectionVars(obj)
            obj.nSearchEdge = 0;
            obj.nTime = 0;
            obj.fArriveEdge = 0;
            obj.fFinished = 0;
            obj.stxy_curr_tmp=[];
            obj.dir_array=[];
            obj.stxy_rel_array=[]; % relative to first one position
            obj.stxy_curr_array=[];
            obj.relxy=[];
        end
        
        %%
        function writeResult(obj,mainMObj)
            mainMObj.edgeDetectPositions{mainMObj.ndetectedge} = ...
                obj.stxy_curr_array;
            mainMObj.edgeDetectDirections{mainMObj.ndetectedge} = ...
                obj.dir_array;
            mainMObj.edgeDetectRelativeToFirstPos{mainMObj.ndetectedge} = ...
                obj.stxy_rel_array;
        end
        %%
        function addListeners(obj)
            u = Context.getInstance().getData('mainVObj').userVObj;
            obj.addlistener('xyPositionChanged',@u.displayPositions);
            obj.addlistener('newDetection',@u.clearDisplayPos);
        end
    end
    
end