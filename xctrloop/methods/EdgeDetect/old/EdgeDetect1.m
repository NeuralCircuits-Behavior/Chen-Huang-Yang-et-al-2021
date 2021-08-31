classdef EdgeDetect1 < EdgeDetect
    % NOTE 2017/7/26 ------------------------------------------
    % use abs move (EdgeDetect2) insted of rel move
    % never use this detected method any more
    % will not update
    % -----------------------------------------------
    
    properties
        stepxy; % mm, array
        dir_array;
        stxy_rel_array; % relative to first one position
        stxy_curr_array;
        relxy;
               
    end
    
    properties(Transient)
        nsearchedge = 0; % number of search at first step in once edge detetction whole brain slice
        ntime = 0; % number of step in once edge detetction a brain slice
        farriveedge = 0;
        ffinished = 0;
        stxy_curr_tmp;
    end
    
    properties(Constant)
        expr = 'XY';
    end
    
    
    methods
        function obj = EdgeDetect1(dirObj,mainMObj)
            obj.dirObj = dirObj;

            obj.stepxy= [ 0,mainMObj.stageMObj.stepy;... %dir1
                -mainMObj.stageMObj.stepx,0;... %dir2
                0,-mainMObj.stageMObj.stepy;... %dir3
                mainMObj.stageMObj.stepx,0]; %dir4
        end

        %% get
        function getRelMoveDistance(obj,nScan_xy)
            dir = obj.dirObj.dir_detected;
            
            if obj.ntime == 1
                dir_temp = mod(nScan_xy,2)*2+1; % odd nScan,3,S,oppsite to most first edge detetction; even nScan,1,N, equal to most first edge detetction
                switch dir
                    case {1,2,3,4}
                        obj.relxy = obj.stepxy(dir,1:2);
                        obj.dir_array(1) = dir;
                        obj.farriveedge = 1;
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
                    otherwise % unknown happened,dir is 15(in) or 0(out)
                        % error happened
                        keyboard;
                end
                obj.relxy  = obj.stepxy(dir,1:2);
                obj.dir_array(end+1) = dir;
            end
        end
        %%
        function detectEdge(obj,mainMObj) % not accumulation
            logObj = LogClass.getInstance();
            str = sprintf('Start detecting edge. NO.%d',mainMObj.ndetectedge);
            logObj.writeLog(str);
            
            obj.clearDetectionVars();
            
            mainMObj.notify('clearPositionDisplay');
            
            while ~obj.ffinished
                
                obj.ntime = obj.ntime+1;
                
                while ~obj.farriveedge
                    obj.nsearchedge = obj.nsearchedge+1;
                    obj.beforeGetEdge(mainMObj);
                end
            
                obj.onceStageMove(mainMObj);
            end
            
            obj.clearDetectionVars();
            
            str = sprintf('Finish detecting edge. NO.%d',mainMObj.ndetectedge);
            logObj.writeLog(str);
            
            
        end
        %% 
        function onceStageMove(obj,mainMObj)
            mainMObj.stageMObj.notify('checkStatic'); % check stage whether movement

            stxy_predict = roundn(obj.stxy_rel_array(end,1:2)+obj.relxy,-4);
            % used to know whether already at first position, if yes will not record this position and move, quit cycle
            
            if  isequal([0,0],stxy_predict)         
                obj.ffinished = 1;
                
            elseif   ~ismember(stxy_predict,obj.stxy_rel_array(2:end,1:2),'rows') %~ismember([1,1],(abs(stxy_curr_array(2:ntime,1:2)-stxy_predict)<= .001),'rows')
                
                obj.stxy_rel_array(end+1,1:2) = stxy_predict;
                mainMObj.stageMObj.notify('getCurrentXY');
                obj.stxy_curr_array(end+1,1:2) = mainMObj.stageMObj.stxy_curr_back;
                mainMObj.notify('updatePositionDisplay',DisplayPositionFeature(obj.stxy_curr_array(end,1:2),'bo'));
                
                mainMObj.cameraMObj.notify('captureImage',SimulatedImageFeature(obj,'edgedetect'));
                obj.dirObj.getDetectedDir(mainMObj.cameraMObj.im_captured);                
                obj.getRelMoveDistance(mainMObj.nScan_xy);
                
                mainMObj.stageMObj.moveRelative(obj.expr(obj.relxy~=0),obj.relxy(obj.relxy~=0));
            else
                % error happened
                keyboard;
            end
        end
        %%
        function beforeGetEdge(obj,mainMObj)
            mainMObj.stageMObj.notify('checkStatic'); % stage
            
            mainMObj.stageMObj.notify('getCurrentXY');
            obj.stxy_curr_tmp = mainMObj.stageMObj.stxy_curr_back;
            
            mainMObj.cameraMObj.notify('captureImage',SimulatedImageFeature(obj,'edgedetect'));
            
            obj.dirObj.getDetectedDir(mainMObj.cameraMObj.im_captured);
            
            obj.getRelMoveDistance(mainMObj.nScan_xy);
            
            if obj.farriveedge
                obj.stxy_rel_array(1,1:2) = [0,0];
                obj.stxy_curr_array(1,1:2) = obj.stxy_curr_tmp;
                mainMObj.notify('updatePositionDisplay',DisplayPositionFeature(obj.stxy_curr_array(1,1:2),'bo'));
            else
                mainMObj.notify('updatePositionDisplay',DisplayPositionFeature(obj.stxy_curr_tmp,'ro'));
            end
            
            mainMObj.stageMObj.moveRelative(obj.expr(obj.relxy~=0),obj.relxy(obj.relxy~=0));
        end
        %%
        function clearDetectionVars(obj)
            obj.nsearchedge = 0;
            obj.ntime = 0;
            obj.farriveedge = 0;
            obj.ffinished = 0;
            obj.stxy_curr_tmp=[];
            obj.dir_array=[];
            obj.stxy_rel_array=[]; % relative to first one position
            obj.stxy_curr_array=[];
            obj.relxy=[];
        end
        
    end
    
end