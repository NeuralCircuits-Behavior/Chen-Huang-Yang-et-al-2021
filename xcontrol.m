% 2017/5/17, CH
% last update, 2017/5/22

% change log:
%   

% ----------------------------------------------------------------

function im_temp_all = xcontrol
global wbsci sth
% [logger,f_main]= func_APTctrl_ini;

% bitcode,  index,    dir(N, W, S, E)
% 1000      8         1      % 1011      11        1     % 1010  10   1  % 0010      2         2      % 0111      7         2     % 0011  3    2
% 0001      1         3      % 1101      13        3     % 0101  5    3  % 0100      4         4      % 1110      14        4     % 1100  12   4
% 1001      9        9       % 0110      6         6    % 1111  15  15
wbsci.movebit2dir = [3,2,2,4,3,6,2,1,9,1,1,4,3,4,15];

% simulate to catch a picture, bgi and tpi
[im_stack,~] = imread_big('E:\LAB_CH\Guo_LAB\MATLAB_repository\Guo_post_process\X\ls\Concatenated Stacks1_181.tif');
% im_stack = imread('E:\LAB_CH\Guo_LAB\MATLAB_repository\Guo_post_process\X\ls\18-Apr-2017_ImageBlue_1_1_Stitched.tif');
im = imresize(im_stack(:,:,1),size(im_stack(:,:,1))*4);

hsz = 2048/2;
wbsci.bgi_ed = im(18600-hsz:18600+hsz,7182-hsz:7182+hsz);
wbsci.tpi_ed = im(9000-hsz:9000+hsz,12500-hsz:12500+hsz);

firstpoint_x_ind = 5740; % row index of pixel , 1936 on edge, 3533 in
firstpoint_y_ind = 15306; % col index of pixel, 13877 on edge,15018 in
% ----------------------

GetRange_ed_;
GetThr_ed_;

ndetec = 0; % number of edge detetction whole brain slice
wbsci.nScan_xy =0; % total times of scanning of detetcted all ROI, x y
wbsci.stepx_mm = roundn(size(wbsci.bgi_ed,2)*0.9*0.2/1000,-4);
wbsci.stepy_mm = roundn(size(wbsci.bgi_ed,1)*0.9*0.2/1000,-4); % 0.2 um per pixel
GetStepXYArray_ed_; % -/+ temp, test use

%% combine z scan
im_temp_all =zeros(1667,2457,50,'uint8');
for k = 1:10:size(im_stack,3)
    ndetec =ndetec+1;
    im = imresize(im_stack(:,:,k),size(im_stack(:,:,k))*4);
    im = padarray(im,[4096,4096]);
    %% once edge detection
    [stxy_rel_array,stxy_curr_array,fno,im_temp]=EdgeDetect_(im,firstpoint_x_ind,firstpoint_y_ind,hsz);
    %     figure;imshow(im_temp,'Border','tight','InitialMagnification',1);
    wbsci.stxy_ed(:,:,ndetec) = stxy_curr_array;
    wbsci.stxy_rel_ed(:,:,ndetec) = stxy_rel_array;
    im_temp_all(:,:,ndetec)=imresize(im_temp,[1667,2457]);
    wbsci.im_temp = im_temp_all;
    
    
    stxy_sc_abspos = Fill_ed_(stxy_curr_array,stxy_rel_array,fno);
    for ipos_xy = 1: size(stxy_sc_abspos,1)
        sth(1).SetAbsMovePos(0,stxy_sc_abspos(ipos_xy,1));sth(1).MoveAbsolute(0,0);
        sth(2).SetAbsMovePos(0,stxy_sc_abspos(ipos_xy,2));sth(2).MoveAbsolute(0,0);
        pause(0.08);
        WaitMotor_xy_;
        
        Disp_ed_(stxy_sc_abspos(ipos_xy,1),stxy_sc_abspos(ipos_xy,2),fno, 'rx');
        
        pause(0.005); % not necessary
%         % catch images + z scan
%         for ipos_z = 1:10
%             pause(0.005);
%         end
%         %
    end
    wbsci.nScan_xy = wbsci.nScan_xy + 1;
    figure(fno);clf
end
keyboard
end


%% sub functions ======================================================================
function GetStepXYArray_ed_
global wbsci
%mm; now set as up +, left +, depending on the situation
wbsci.stepxy_mm = [ 0,wbsci.stepy_mm;  wbsci.stepx_mm,0;0,-wbsci.stepy_mm;-wbsci.stepx_mm,0];
end

function WaitMotor_xy_
global sth
while func_IsStMoving(sth(1)) || func_IsStMoving(sth(2));end
end

function WaitMotor_z_
global sth
while func_IsStMoving(sth(3));end
end

function GetRange_ed_
global wbsci
% use mean gray val of 4 corners, 10% of row or column pixs
im_sz = size(wbsci.bgi_ed);
sz_sub = round(im_sz.*0.1); % 10% of all pixs, need be equal to overlap
wbsci.range_ed = [1:sz_sub(1);1:sz_sub(2);...    % left up
    1:sz_sub(1);im_sz(2)-sz_sub(2)+1:im_sz(2);... % right uo
    im_sz(1)-sz_sub(1)+1:im_sz(1);1:sz_sub(2);... % left bottem
    im_sz(1)-sz_sub(1)+1:im_sz(1);im_sz(2)-sz_sub(2)+1:im_sz(2); % right bottem
    %                 ceil(im_sz(1)/2)-ceil(sz_sub(1)/2)+1:ceil(im_sz(1)/2)-ceil(sz_sub(1)/2)+sz_sub(1); % center
    %                 ceil(im_sz(2)/2)-ceil(sz_sub(2)/2)+1:ceil(im_sz(2)/2)-ceil(sz_sub(2)/2)+sz_sub(2);
    ];
end

function GetThr_ed_
global wbsci
% % threshold is calculate by mean
% obj.tpi_ed_avg = arrayfun(@(ii)mean(mean(obj.tpi_ed(obj.range_ed(2*ii-1,:),obj.range_ed(2*ii,:)))),1:4); % mean of # 1,2,3,4 corners
% obj.bgi_ed_avg = arrayfun(@(ii)mean(mean(obj.bgi_ed(obj.range_ed(2*ii-1,:),obj.range_ed(2*ii,:)))),1:4);
% obj.thr_ed = abs(diff(mean([obj.tpi_ed_avg;obj.bgi_ed_avg],2)))/4+mean(obj.bgi_ed_avg); % distance form bgi 1/4 diff of (tpi-bgi)
% wbsci.thr_ed = mean(wbsci.tpi_ed(:))-(mean(wbsci.tpi_ed(:))-mean(wbsci.bgi_ed(:)))/4;

% % 10x background std, not good when gray value chaning
% wbsci.thr_ed = mean(wbsci.bgi_ed(:))+std(double(wbsci.bgi_ed(:)))*10;

% 4x tpi std
wbsci.thr_ed = mean(wbsci.tpi_ed(:))-std(double(wbsci.tpi_ed(:)))*4;
end

function dir = GetMoveDir_ed_(im)
global wbsci
% run once need 1.4 ms

im_gray = arrayfun(@(ii)mean(mean(im(wbsci.range_ed(2*ii-1,:),wbsci.range_ed(2*ii,:)))),1:4);
ft = im_gray > wbsci.thr_ed;
dir = bin2dec(sprintf('%d',ft));
if dir
    dir = wbsci.movebit2dir(dir);
end
end


function [stxy_rel_array,stxy_curr_array,fno,im_temp]=EdgeDetect_(im,firstpoint_x_ind,firstpoint_y_ind,hsz)
global sth wbsci

tic
fprintf('* Edge detecting ');
t = timer('TimerFcn','fprintf(''.'');', 'Period', 1, 'ExecutionMode', 'fixedSpacing');start(t);

figure(99);fno = get(gcf,'number');set(gcf,'Units','normalized','Position',[0.21,0.51,0.1885,0.22]);

nstep = 0; % number of step in once edge detetction whole brain slice
dir_array = zeros(2000,1);
[stxy_rel_array,stxy_curr_array] = deal(zeros(2000,2));
ffinished = 0;
im_temp =im;
while ~ffinished % note here, modify further
    nstep = nstep+1;
    
    if nstep ==1
        farriveedge = 0;
        dir_temp = mod(wbsci.nScan_xy,2)*2+1; % odd nScan,3,S,oppsite to most first edge detetction; even nScan,1,N, equal to most first edge detetction
        nsearchedge = 0;
        while ~farriveedge

            % codes for catching image here ----------------------------------------------
            nsearchedge = nsearchedge + 1;

            if nsearchedge > 1
                step_pix = [round(relxy_mm(2)/0.2*1000),round(relxy_mm(1)/0.2*1000)];
                cen_ind = [cen_ind(1)-step_pix(1),cen_ind(2)-step_pix(2)];
            else
                stx_curr_tmp = sth(1).GetPosition_Position(0);
                sty_curr_tmp = sth(2).GetPosition_Position(0);
                
                cen_ind = [firstpoint_x_ind-round((sty_curr_tmp-25)/0.2*1000),firstpoint_y_ind-round((stx_curr_tmp-25)/0.2*1000)];
            end
            row_ind = intersect(cen_ind(1)-hsz:cen_ind(1)+hsz,1:size(im,1));
            col_ind = intersect(cen_ind(2)-hsz:cen_ind(2)+hsz,1:size(im,2));
            im_sim = im(row_ind,col_ind);
            pause(0.02)
            %------------------------------------------------------------------------------
            
            dir = GetMoveDir_ed_(im_sim);

            switch dir
                case {1,2,3,4}
                    relxy_mm = wbsci.stepxy_mm(dir,1:2);
                    stx_current = sth(1).GetPosition_Position(0);
                    sty_current = sth(2).GetPosition_Position(0);
                    stxy_curr_array(nstep,1:2) = [stx_current,sty_current];
                    dir_array(nstep) = dir;
                    stxy_rel_array(nstep,1:2) = [0,0];
                    farriveedge = 1;
                case 15;relxy_mm = wbsci.stepxy_mm(dir_temp,1:2);  % in
                case 0;relxy_mm = -wbsci.stepxy_mm(dir_temp,1:2); % out
                otherwise
                    % unknown happened,dir is nan
                    keyboard
            end
            
            Disp_ed_(sth(1).GetPosition_Position(0),sth(2).GetPosition_Position(0),fno, 'ro');
            
            sth(1).SetRelMoveDist(0,relxy_mm(1));sth(1).MoveRelative(0,0);
            sth(2).SetRelMoveDist(0,relxy_mm(2));sth(2).MoveRelative(0,0);
            pause(0.08); % time to send to motor control
            
            WaitMotor_xy_;
        end
    else
        
        % codes for catching image here
        step_pix = [round(relxy_mm(2)/0.2*1000),round(relxy_mm(1)/0.2*1000)];
        cen_ind = [cen_ind(1)-step_pix(1),cen_ind(2)-step_pix(2)];
        row_ind = intersect(cen_ind(1)-hsz:cen_ind(1)+hsz,1:size(im,1));
        col_ind = intersect(cen_ind(2)-hsz:cen_ind(2)+hsz,1:size(im,2));
        im_sim = im(row_ind,col_ind);
        im_temp(row_ind,col_ind) = 255;
        %         figure(9999);imshow(im_temp,'Border','tight','InitialMagnification',5);
%                           figure;warning off;imshow(im_sim,'Border','tight','InitialMagnification',5);
        pause(0.02);
        %-----------------------------------
        
        stxy_predict = roundn(stxy_rel_array(nstep-1,1:2)+relxy_mm,-4);
        
        if  isequal([0,0],stxy_predict)          %all(abs(stxy_curr_array(1,1:2)-stxy_predict)<= .001)
            ffinished = 1;
        elseif   ~ismember(stxy_predict,stxy_rel_array(2:nstep-1,1:2),'rows') %~ismember([1,1],(abs(stxy_curr_array(2:nstep,1:2)-stxy_predict)<= .001),'rows')
            dir = GetMoveDir_ed_(im_sim);

            stxy_rel_array(nstep,1:2) = stxy_predict;
            stx_current = sth(1).GetPosition_Position(0);
            sty_current = sth(2).GetPosition_Position(0);
            stxy_curr_array(nstep,1:2) = [stx_current,sty_current];
            
            Disp_ed_(stx_current,sty_current,fno, 'bo')
            
            switch dir
                case {1,2,3,4}
                case 9 % 1001
                    dir_temp = [4,3,2,1];
                    dir = dir_temp(dir_array(nstep-1));
                case 6 % 0110
                    dir_temp = [2,1,4,3];
                    dir = dir_temp(dir_array(nstep-1));
                otherwise % unknown happened,dir is 15(in) or 0(out)
                    % error happened
                    keyboard;
            end
            
            relxy_mm = wbsci.stepxy_mm(dir,1:2);
            sth(1).SetRelMoveDist(0,relxy_mm(1));sth(1).MoveRelative(0,0);
            sth(2).SetRelMoveDist(0,relxy_mm(2));sth(2).MoveRelative(0,0);
            
            pause(0.08); % time to send to motor control
            
            dir_array(nstep) = dir;
            WaitMotor_xy_;
        else
            % error happened
            keyboard;
        end
    end
end
stop(t); et=toc; fprintf(' done. Elapsed %.2f seconds.\n', et);

end

function Disp_ed_(stx_current,sty_current,fno, mark)
figure(fno); plot(stx_current,sty_current,mark);
axis equal;set(gca,'XTick',19:28,'YTick',19:26,'XDir','reverse','XLim',[19,28],'YLim',[19,26]);hold on
end

function stxy_sc_abspos = Fill_ed_(stxy_curr_array,stxy_rel_array,fno)
global wbsci

tic
fprintf('* Filling positions . ');

empty_tf = ismember(stxy_curr_array,[0,0],'rows');
stxy_rel_array(empty_tf,:)=[];

stxy_rel_array_sorted = sortrows(stxy_rel_array,[2,1],'descend'); % here sort by y the by x, axis vertical to scan dir
ind_min = [find(abs(diff(stxy_rel_array_sorted(:,2)))>.001);size(stxy_rel_array_sorted,1)]; % index of max val , col vecter
ind_max = [1;ind_min(1:end-1)+1]; % index of min val , col vecter

stx_start_end_per_row = [stxy_rel_array_sorted(ind_min,1),stxy_rel_array_sorted(ind_max,1)]+ stxy_curr_array(1,1);
% now at first row, first col is smaller val, second is bigger val, depend on axis

pos_space = round((stxy_rel_array_sorted(ind_max,1)-stxy_rel_array_sorted(ind_min,1))./abs(wbsci.stepx_mm)); % col vecter
stxy_sc_abspos = zeros(sum(pos_space+1),2);
for irow = 1:numel(ind_max)
    x_temp = stx_start_end_per_row(irow,mod(irow,2)+1)+(-1)^mod(irow,2)*(0:pos_space(irow))*abs(wbsci.stepx_mm);
    stxy_sc_abspos(sum(pos_space(1:irow)+1)-pos_space(irow):sum(pos_space(1:irow)+1),1:2) = ...
        [x_temp',repmat(stxy_rel_array_sorted(ind_max(irow),2)+ stxy_curr_array(1,2),numel(x_temp),1)];
end
% stxy_sc_abspos =[];
% for irow = 1:numel(ind_max)
%     x_temp = stx_start_end_per_row(irow,mod(irow,2)+1)+(-1)^mod(irow,2)*(0:pos_space(irow))*abs(wbsci.stepx_mm);
%     stxy_sc_abspos = [stxy_sc_abspos;...
%         [x_temp',repmat(stxy_rel_array_sorted(ind_max(irow),2)+ stxy_curr_array(1,2),numel(x_temp),1)]];
% end


if mod(wbsci.nScan_xy,2) % 1 from left to right, now def left and up is positive;
    stxy_sc_abspos = flipud(stxy_sc_abspos);
end

Disp_ed_(stxy_sc_abspos(:,1),stxy_sc_abspos(:,2),fno, 'ko');
et=toc; fprintf(' done. Elapsed %.2f seconds.\n', et);
end