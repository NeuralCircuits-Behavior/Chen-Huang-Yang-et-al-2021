classdef ROIsDecide1 < ROIsDecide
    % ---------------------------------------------------------------------------------------------------
    % used to decide ROIs depending on detected edge positions
    % final ROIs not include edge ROIs, 
    % but if the edge ROI has error bigger than 1.5 um compare with decide ROI, 
    % it will image again
    
    % only determine one slice
    % ---------------------------------------------------------------------------------------------------
    
    properties
        stxy_sc_abspos;
    end
        
    methods
        %%
        function output = decideROIs(obj,m)
            stxy_rel_array = ...
                m.edgeDetectRelativeToFirstPos{m.imPipeline.nROIsDetermination};
            stxy_curr_array = ...
                m.edgeDetectPositions{m.imPipeline.nROIsDetermination};
            stepx = max(m.edObj.stepxy(:,1));
            
            stxy_rel_array_sorted = sortrows(stxy_rel_array,[2,1],'descend'); 
                % here sort by y then by x, axis vertical to scan dir
            ind_min = [find(abs(diff(stxy_rel_array_sorted(:,2)))>.01);...
                size(stxy_rel_array_sorted,1)]; % index of max val , col vecter
            ind_max = [1;ind_min(1:end-1)+1]; % index of min val , col vecter
            
            stx_start_end_per_row = ...
                [stxy_rel_array_sorted(ind_min,1),...
                stxy_rel_array_sorted(ind_max,1)] + stxy_curr_array(1,1);
                % now at first row, first col is smaller val, 
                % second is bigger val, depend on axis
            
            pos_space = round((stxy_rel_array_sorted(ind_max,1) - ...
                stxy_rel_array_sorted(ind_min,1))./abs(stepx)); % col vecter
            
            obj.stxy_sc_abspos = zeros(sum(pos_space+1),2);
            for irow = 1:numel(ind_max)
                x_temp = stx_start_end_per_row(irow,mod(irow,2)+1) ...
                    + (-1)^mod(irow,2) * (0:pos_space(irow)) * abs(stepx); 
                    % (-1)^mod(irow,2) decide descend or ascend
                obj.stxy_sc_abspos(sum(pos_space(1:irow)+1) - ...
                    pos_space(irow):sum(pos_space(1:irow)+1), 1:2) = ...
                    [x_temp',repmat(stxy_rel_array_sorted(ind_max(irow),2) ...
                    + stxy_curr_array(1,2),numel(x_temp),1)];
            end
            

            %{
            if mod(m.nScan_xy,2) 
                    % 1 from left to right, now def left and up is positive;
                obj.stxy_sc_abspos = flipud(obj.stxy_sc_abspos);
            end
            %}
            
            % trim to leave inside points, allow x um error
            error_allowed = 0.0015; % + - 1.5 um 
            
            delta_x_array = abs(bsxfun(...
                @minus,obj.stxy_sc_abspos(:,1), stxy_curr_array(:,1)'));
            delta_y_array = abs(bsxfun(...
                @minus,obj.stxy_sc_abspos(:,2), stxy_curr_array(:,2)'));
            tf = delta_x_array <= error_allowed & ...
                delta_y_array <= error_allowed;
            tf_on = any(tf,2);
            
            tf_in = inpolygon(obj.stxy_sc_abspos(:,1),obj.stxy_sc_abspos(:,2),...
                stxy_curr_array(:,1),stxy_curr_array(:,2));
            
            obj.stxy_sc_abspos = obj.stxy_sc_abspos(tf_in & ~tf_on,:);
            
            curr_pos = m.stageMObj.getXYCurrentPosition();
            dist__ = @(a,b)sum((a-b).^2);
            if dist__(curr_pos,obj.stxy_sc_abspos(end,:)) < ...
                    dist__(curr_pos,obj.stxy_sc_abspos(1,:))
                obj.stxy_sc_abspos = flipud(obj.stxy_sc_abspos);
            end
            output = obj.stxy_sc_abspos;
            
            f = figure;hold on;
            plot(obj.stxy_sc_abspos(:,1),obj.stxy_sc_abspos(:,2),'x-');
            plot(stxy_curr_array(:,1),stxy_curr_array(:,2),'bo');
            plot(obj.stxy_sc_abspos(1,1),obj.stxy_sc_abspos(1,2),'r.');
            axis equal
            f.Children.YDir = 'reverse';
            xlim(15+[-10,10]);
            ylim(15+[-10,10]);
        end
        
    end
    
    
    
    
    
    
    
    
    
    
end