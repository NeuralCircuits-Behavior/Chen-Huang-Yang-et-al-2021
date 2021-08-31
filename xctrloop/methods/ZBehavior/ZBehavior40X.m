classdef ZBehavior40X < ObjectiveDependentZBehavior
    % 2018/4/13,CH
    % 40X behavior is different from 16X because of piezo movement.
    % note z stage only move when sectioning
    
    properties
        dir = 1; % sample did not move, piezo bigger close to sample
        deterOffset; % um, move samll range before determing for better focus
    end
    
    methods
        function preDetermin(obj,m)
            % 2018/6/13, 
            % move dStartStagePosition and dStartPiezoPosition here
            
            p = m.imPipeline;
            if p.nROIsDetermination == 1 ||  abs(p.nROIsDetBefSection) == 1
                % this condition means first determine after section or first of all
                % keep first determine always at bladePlane
                % because use deterOffset, so need move more
                m.stageMObj.moveAbsolute('Z',m.vtMObj.bladePlane);
                % dStartStagePosition always is calculated as bladePlane in this 
                % condition 
                p.dStartStagePosition(p.nROIsDetermination,:) = ...
                    [m.stageMObj.getXYCurrentPosition(),m.vtMObj.bladePlane];
                % note dStartPiezoPosition is dynamic, so if error or anything
                % unexpected, need move to dStartPiezoPosition after some conditions
                if p.nROIsDetermination > 1
                    p.dStartPiezoPosition(p.nROIsDetermination) = ...
                        p.dStartPiezoPosition(1);
                elseif p.nROIsDetermination == 1
                    p.dStartPiezoPosition(1) = m.piezoMObj.getPosition();
                    % may not the same as p.dStartStagePosition
                    m.imageZStartPosition = [m.stageMObj.getZCurrentPosition(),...
                        m.piezoMObj.getPosition()];
                end
                pos = p.dStartPiezoPosition(1) + obj.dir * obj.deterOffset;
            elseif abs(p.nROIsDetBefSection) ~= 1
                % nROIsDetBefSection = 0 should mean last determine before section
                % This is not 1st Determination after last section, so
                % need move to next z pos before next time determine
                pos = p.dStartPiezoPosition(p.nROIsDetermination-1) + ...
                    obj.dir * (range(p.zScanRange) + p.zScanRate);
                
                p.dStartStagePosition(p.nROIsDetermination,:) = ...
                    [m.stageMObj.getXYCurrentPosition(), ...
                    p.dStartStagePosition(p.nROIsDetermination-1,3)];
                p.dStartPiezoPosition(p.nROIsDetermination) = pos;
                
                % for better determine, upper deterOffset mm before determining
                pos = pos + obj.dir * obj.deterOffset; 
            end
            obj.zMove(m,pos,0);
        end
        
        function deterOffset = get.deterOffset(obj)
            if isempty(obj.deterOffset)
                p = Context.getInstance().getData('mainMObj').imPipeline;
                deterOffset = 0.5 * range(p.zScanRange); % um
            else
                deterOffset = obj.deterOffset;
            end
        end
        
        function pos = getLastPosition(obj,m)
            pos = max(m.imPipeline.dROIs(:,3));
        end
        
        function zSeq = determineZROISequence(obj,m,zScanRange)
            % zScanRange: 0: zScanRate: ROIsDetemineRate-1
            % zSeq: piezo z moving sequence
            
            p = m.imPipeline;
            zSeq = p.dStartPiezoPosition(p.nROIsDetermination) + ...
                obj.dir .* zScanRange';
        end
        
        function zMove(obj,m,zPos,fSaveIm)
            m.piezoMObj.movePiezo(zPos);
            if fSaveIm
                m.imPipeline.notify('saveImageNow');
            end
            m.piezoMObj.waitForPiezoStatic(zPos); % 2018/10/1
        end
        
        %{
        % comment at 2018/3/14, because of using stack imaging
        function pos = getImAbsPosition(obj,m,fNewTile)
             if nargin < 3
                fNewTile = 1;
            end
            
            % output pos is convert to stage position 
            p = m.imPipeline;
            if fNewTile
                xy = m.stageMObj.getXYCurrentPosition();
            else
                switch class(m.imPipeline)
                    case 'SmartImagingPipeline'
                        xy = p.imAbsPosition40{end}(end,1:2);
                    otherwise
                        xy = p.imAbsPosition{end}(end,1:2);
                end
            end
            zStage0 = p.dStartStagePosition(p.nROIsDetermination,3);
            % if p.sectionRate == p.ROIsDetermineRate, will be ok
            %{
            zPiezo0 = p.dStartPiezoPosition(p.nROIsDetermination);
            n = p.nROIsDetBefSection + (p.sectionRate/p.ROIsDetermineRate) * ...
                ~p.nROIsDetBefSection;
            z0 = (n - 1) * p.ROIsDetermineRate;
            z = zStage0 - (z0 - obj.dir*(m.piezoMObj.getPosition()-zPiezo0))/1000;
            %}
            
            % 2018/11/27, CH, for faster imaging, never get piezo position 
            % in smart model any more
            switch class(m.imPipeline)
                    case 'SmartImagingPipeline'
                        zpos = p.rROIs40(1,3);
                otherwise
                        zpos = m.piezoMObj.getPosition();
            end
            z = zStage0 - obj.dir * ...
                (zpos - p.dStartPiezoPosition(1))/1000;
            pos = [xy,z];
        end
        %}
        
        function pos = getImAbsPosition(obj,m,fNewTile)
            % 2019/3/14, will get p.zScanRange40N positions
            if nargin < 3
                fNewTile = 1;
            end
            
            % output pos is convert to stage position 
            p = m.imPipeline;
            if fNewTile
                xy = m.stageMObj.getXYCurrentPosition();
            else
                switch class(m.imPipeline)
                    case 'SmartImagingPipeline'
                        % will not reach here, fNewTile always 1 
                        %{
                        xy = p.imAbsPosition40{end}(end,1:2);
                        %}
                        keyboard;
                    otherwise
                        xy = p.imAbsPosition{end}(end,1:2);
                end
            end
            zStage0 = p.dStartStagePosition(p.nROIsDetermination,3);
            
            % 2018/11/27, CH, for faster imaging, never get piezo position 
            % in smart mode any more
            switch class(m.imPipeline)
                    case 'SmartImagingPipeline'
                        %zpos = p.rROIs40(1,3);
                        zpos = p.rROIs40(1:p.zScanRange40N,3);
                otherwise
                        zpos = m.piezoMObj.getPosition();
            end
            z = zStage0 + m.objectiveMObj.deltaFocusStageZMove - obj.dir * ...
                (zpos - p.dStartPiezoPosition(1))/1000;
            pos = [repelem(xy,numel(z),1),z];
        end
        
        function preSection(obj,m)
            p = m.imPipeline;
            m.piezoMObj.movePiezo(p.dStartPiezoPosition(1));
            zStart = p.dStartStagePosition(p.nROIsDetermination,3);
            % need aglin 40x focus plane and blade plane first,
            % and then need not use ob.deltaFocusHeight
            % because ever section, piezo will move back to 1st position
            % stage need move whole sectionRate
            pos = zStart - obj.dir * (p.sectionRate/1000 - ...
                (p.zSectionOverlap/1000 - m.vtMObj.bladeOffset));
            m.stageMObj.moveAbsolute('Z',pos);
            m.stageMObj.waitForStageStatic();
        end
        
        function postSection(obj,m,oriSpeed,y)
            st = m.stageMObj;
            st.changeSpeed('Y',oriSpeed);
            st.moveAbsolute('Y',y);
            st.waitForStageStatic();
        end
        
        function tf = fImagingNeedFinish(obj,m)
            p = m.imPipeline;
            z = p.dStartStagePosition(p.nROIsDetermination,3) - ...
                obj.dir * (range(p.zScanRange) + p.zScanRate ...
                - p.zSectionOverlap)/1000;
            tf = abs(m.imageZStartPosition(1)-z) >= p.zMaxLimt;
        end
        
        function responseForManualStop(obj,m)
            zPos = m.imPipeline.dStartPiezoPosition(end);
            obj.zMove(m,zPos,0);
        end
        
        function im = captureImage(obj,m,varargin)
            % hardware trigger
            % just trigger
            m.tcpW.fwrite2labVIEW(varargin{1});
            im = nan;
        end
    end
end