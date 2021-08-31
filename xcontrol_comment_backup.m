%                 case 0 % out
%                     switch dir_array_real(nstep-1)
%                         case {2,3}; dir_temp = 5; case {4,5}; dir_temp = 7; case {6,7}; dir_temp = 1; case {8,1}; dir_temp = 3;
%                     end
%                     dir_temp
%                     stx_current = sth(1).GetPosition_Position(0); stx_curr_array(nstep)=stx_current;
%                     sty_current = sth(2).GetPosition_Position(0); sty_curr_array(nstep)=sty_current;
%                     
%                     relx_mm = stepxy_mm(dir_temp,1);rely_mm = stepxy_mm(dir_temp,2);
%                     sth(1).SetRelMoveDist(0,relx_mm);sth(1).MoveRelative(0,0);
%                     sth(2).SetRelMoveDist(0,rely_mm);sth(2).MoveRelative(0,0);
%                     
% %                     stx_curr_array(nstep)=stx_current; % only dir not 0 will record current pos, 0 case will all be 0
% %                     sty_curr_array(nstep)=sty_current;
%                     dir_array_real(nstep) = dir_temp; dir_array_raw(nstep) = dir;