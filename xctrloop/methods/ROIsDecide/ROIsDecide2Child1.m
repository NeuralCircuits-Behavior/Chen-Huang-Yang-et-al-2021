classdef ROIsDecide2Child1 < ROIsDecide2
    % ---------------------------------------------------------------------------------------------------
    % 2018/5/14, CH
    % used to decide ROIs depending on detected edge positions
    % final ROIs include edge ROIs, 
    % all ROIs in ROIsDetermineRate * x * y. order z-x-y, one tile by one tile 
    % Axial scan: 16x is stage movement and 40x is poezo movement
    
    % use for try ROI detetct
    % ---------------------------------------------------------------------------------------------------
    
       
    methods                
        function dROIs = decideROIs(obj,m,p)
            obj.stxyROIsAbsPos = obj.determineXYPositions(m,p);
            dROIs = obj.stxyROIsAbsPos;
            
            obj.notify('updateGUI',...
                    DisplayPositionFeature(obj.stxyROIsAbsPos, 'rx'));
        end
    end
   
    
    
    
    
    
    
    
    
    
    
    
    
end