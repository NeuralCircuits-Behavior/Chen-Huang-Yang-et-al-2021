classdef ObjectiveDependentZBehavior < handle
    % 2018/4/13,CH
    
    methods(Abstract)
        preDetermin(obj);
        determineZROISequence(obj);
        zMove(obj);
        getImAbsPosition(obj);
        preSection(obj);
        postSection(obj);
        getLastPosition(obj);
    end
end