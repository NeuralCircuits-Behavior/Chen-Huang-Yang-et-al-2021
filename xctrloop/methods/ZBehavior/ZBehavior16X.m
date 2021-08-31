classdef ZBehavior16X < ObjectiveDependentZBehavior
    % 2018/4/13,CH
    
    properties
        dir = -1; % sample upper abs position smaller
        deterOffset; % mm, move samll range before determing for better focus
    end
    
    methods
        function preDetermin(obj,m)
            % 2018/6/12, 
            % move dStartStagePosition and dStartPiezoPosition here
            
            p = m.imPipeline;
            if p.nROIsDetermination == 1 || abs(p.nROIsDetBefSection) == 1
                % -1 is when DetermineRate == sectionRate
                % this condition means first determine after section or first of all
                % keep first determine always at bladePlane
                % because use deterOffset, so need move more
                if p.nROIsDetermination == 1
                    % may not the same as p.dStartStagePosition
                    m.imageZStartPosition = [m.stageMObj.getZCurrentPosition(),...
                        m.piezoMObj.getPosition()];
                end
                % dStartStagePosition always is calculated as bladePlane in this
                % condition
                pos = m.vtMObj.bladePlane;
            elseif abs(p.nROIsDetBefSection) ~= 1
                % nROIsDetBefSection = 0  is  last determine before section
                % This is not 1st Determination after last section, so
                % need move to next z pos before next time determine
                pos = p.dStartStagePosition(p.nROIsDetermination-1,3) + ...
                    obj.dir * (range(p.zScanRange)+ p.zScanRate)/1000;
            end
            p.dStartStagePosition(p.nROIsDetermination,:) = ...
                [m.stageMObj.getXYCurrentPosition(),pos];
            
            % let piezo always set as 1st
            % 2018/10/15, CH
            if p.nROIsDetermination == 1
                p.dStartPiezoPosition(p.nROIsDetermination) = ...
                    m.piezoMObj.getPosition();
            else
                p.dStartPiezoPosition(p.nROIsDetermination) = ...
                    p.dStartPiezoPosition(1);
            end
            
            % for better determine, upper deterOffset mm before determining
            pos = pos + obj.dir * obj.deterOffset;
            obj.zMove(m,pos,0);
        end
        
        function deterOffset = get.deterOffset(obj)
            if isempty(obj.deterOffset)
                p = Context.getInstance().getData('mainMObj').imPipeline;
                deterOffset = 1 * range(p.zScanRange) / 1000; % mm % 20200727 change 0.5->1
            else
                deterOffset = obj.deterOffset;
            end
        end
        
        function pos = getLastPosition(obj,m)
            pos = min(m.imPipeline.dROIs(:,3));
        end
        
        function zSeq = determineZROISequence(obj,m,zScanRange)
            % zScanRange: 0: zScanRate: ROIsDetemineRate-1
            % zSeq: stage z moving sequence
            
            p = m.imPipeline;
            zScanRange = zScanRange/1000;
            % move back 
            zSeq = p.dStartStagePosition(p.nROIsDetermination,3) + ...
                obj.dir .* zScanRange';
        end
        
        function zMove(obj,m,zPos,fSaveIm)
            m.stageMObj.moveAbsolute('Z',zPos,fSaveIm);
        end
        
        function pos = getImAbsPosition(obj,m,fNewTile)
            if nargin < 3
                fNewTile = 1;
            end
            
            if fNewTile
                xy = m.stageMObj.getXYCurrentPosition();
                z = m.stageMObj.getZCurrentPosition();
            else
                xy = m.imPipeline.imAbsPosition{end}(end,1:2);
                % comment at 20200731
                if size(m.imPipeline.rROIs,1) > 1
                    % not last one
                    curDir = sign(diff(m.imPipeline.rROIs(1:2,3)));
                    if curDir ~= 0
                        z = m.imPipeline.imAbsPosition{end}(end,3)+...
                            curDir * m.imPipeline.zScanRate/1000;
                    else
                        % curDir == 0, last one
                        z = m.stageMObj.getZCurrentPosition();
                    end
                else
                    z = m.stageMObj.getZCurrentPosition();
                end
            end
            % comment at 20200731, each step get z pos will take lots of time
            %z = m.stageMObj.getZCurrentPosition();
            pos = [xy,z];
        end
        
        function preSection(obj,m)
            p = m.imPipeline;
            % zPosition should be scan last position, not first
            % if zSectionOverlap == 0, will section sectionRate thikness tissue
            zStart = p.dStartStagePosition(p.nROIsDetermination,3); 
%             zStart=m.stageMObj.getZCurrentPosition; %yyx20201202
            pos = zStart + obj.dir * ((range(p.zScanRange) + p.zScanRate)/1000 - ...
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
            z = m.stageMObj.getZCurrentPosition();
            z = z + ...
                obj.dir * (range(p.zScanRange) + p.zScanRate ...
                - p.zSectionOverlap)/1000;
            tf = abs(m.imageZStartPosition(1)-z) >= p.zMaxLimt;
        end
        
        function responseForManualStop(obj,m)
            zPos = m.imPipeline.dStartStagePosition(end,3);
            obj.zMove(m,zPos,0);
        end
        
        function im = captureImage(obj,m,varargin)
            % hardware trigger
            m.tcpW.fwrite2labVIEW('sp');
            im = m.cameraMObj.getData(1);
        end
    end
end