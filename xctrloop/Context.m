classdef Context < handle
    properties
        dataDict;
    end
    
    methods(Access = private)
        function obj = Context()
            obj.dataDict = containers.Map();
        end
    end
    
    methods(Static)
        function obj = getInstance()
            persistent localObj;
            if isempty(localObj) || ~isvalid(localObj)
                localObj = Context();
            end
            obj = localObj;
        end
    end
    
    methods
        function register(obj,ID,data)
            expr = sprintf('obj.dataDict(\''%s\'') = data;',ID);
            eval(expr);
        end
        
        function data = getData(obj,ID)
            if isKey(obj.dataDict,ID)
                data = obj.dataDict(ID);
            else
                error('ID does not exist');
            end
        end
    end
    
end