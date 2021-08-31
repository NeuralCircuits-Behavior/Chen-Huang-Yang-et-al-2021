% 2017/5/16, CH
% last updated 2017/5/17
%
% change log:
% 

classdef WBSI < handle
    properties
        tpi_ed; % template image used for edge detection
        bgi_ed; % background image used for edge detection
        thr_ed;  % threshold used for edge detection
        range_ed; % ROI range used for edge detection
        stxy_ed = zeros(2000,2,500); % dected edge positions of motor stage, filled with 0
        stxy_rel_ed = zeros(2000,2,500);
    end
    
    properties(Constant)
%         % num inarray correspond to move dir, 1-8 from N to EN anticlockwise. 15 is in
%         % movebit2dir = [4,2,3,6,5,nan,3,8,nan,1,1,7,5,7,15]; 

        % bitcode,  index,    dir(N, W, S, E)
        % 1000      8         1      % 1011      11        1     % 1010  10   1
        % 0010      2         2      % 0111      7         2     % 0011  3    2
        % 0001      1         3      % 1101      13        3     % 0101  5    3
        % 0100      4         4      % 1110      14        4     % 1100  12   4    
        % 1001      9        9       % 0110      6         6    % 1111  15  15          
        movebit2dir = [3,2,2,4,3,6,2,1,9,1,1,4,3,4,15]; 
    end
    
    properties(Hidden)
        tpi_ed_avg; % temp var 
        bgi_ed_avg; % temp var 
    end
    
    methods
        function obj = WBSI()
        end
        
        function GetRangeEdgeDetec(obj)
            % use mean gray val of 4 corners, 20% of row or column pixs 
            im_sz = size(obj.bgi_ed);
            sz_sub = round(im_sz.*0.1); % 10% of all pixs, need be equal to overlap
            obj.range_ed = [1:sz_sub(1);1:sz_sub(2);...    % left up
                1:sz_sub(1);im_sz(2)-sz_sub(2)+1:im_sz(2);... % right uo
                im_sz(1)-sz_sub(1)+1:im_sz(1);1:sz_sub(2);... % left bottem
                im_sz(1)-sz_sub(1)+1:im_sz(1);im_sz(2)-sz_sub(2)+1:im_sz(2); % right bottem
%                 ceil(im_sz(1)/2)-ceil(sz_sub(1)/2)+1:ceil(im_sz(1)/2)-ceil(sz_sub(1)/2)+sz_sub(1); % center
%                 ceil(im_sz(2)/2)-ceil(sz_sub(2)/2)+1:ceil(im_sz(2)/2)-ceil(sz_sub(2)/2)+sz_sub(2);
                ];
        end
        
        function GetThrEdgeDetec(obj)
            % % threshold is calculate by mean
            % obj.tpi_ed_avg = arrayfun(@(ii)mean(mean(obj.tpi_ed(obj.range_ed(2*ii-1,:),obj.range_ed(2*ii,:)))),1:4); % mean of # 1,2,3,4 corners
            % obj.bgi_ed_avg = arrayfun(@(ii)mean(mean(obj.bgi_ed(obj.range_ed(2*ii-1,:),obj.range_ed(2*ii,:)))),1:4);
            % obj.thr_ed = abs(diff(mean([obj.tpi_ed_avg;obj.bgi_ed_avg],2)))/4+mean(obj.bgi_ed_avg); % distance form bgi 1/4 diff of (tpi-bgi)
            
            % 5x background std
            obj.thr_ed = mean(obj.bgi_ed(:))+std(double(obj.bgi_ed(:)))*5;
        end
        
        function dir = GetMoveDirEdgeDetec(obj,im)
            % run once need 1.4 ms
            im_gray = arrayfun(@(ii)mean(mean(im(obj.range_ed(2*ii-1,:),obj.range_ed(2*ii,:)))),1:4);
            ft = im_gray>obj.thr_ed;
            dir = bin2dec(sprintf('%d',ft));
            if dir
                dir = obj.movebit2dir(dir);
            end
%             fout = ~any(ft); % out: all corners < threshold, bitcode 0
%             fin = all(ft); % in all corners > threshold, , bitcode 15
%             fedge = 1-sum([fout,fin]); % edge: not out and not in
%             pos = find([fout,fedge,fin]); % 1 out; 2 edge; 3 in, 
        end
        
        
        
        
        
        
        
        
        
        
        
    end
end