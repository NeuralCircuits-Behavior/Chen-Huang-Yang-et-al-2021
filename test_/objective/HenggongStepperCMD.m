% Henggong Stepper Control
% 2018/3/5
% X: +1 -> 40x, +144000 -> 16x
% Y: object center -> +087704
% Z: start form +3000, can't smaller than +3000,
%    +122640 is hight of objective plane

s = serial('COM1');

% infoO = instrhwinfo('serial'); 
% will create a info object which could be used to 
% check which port is availabel. 

s.Terminator = {'LF','CR'};
s.Timeout = 30;
fopen(s);

fprintf(s,'?R');fgetl(s) % ini

fprintf(s,'V255');fgetl(s)  % set speed

fprintf(s,'HX');fgetl(s) % X move to +1

fprintf(s,'HZ');fgetl(s) % X move to +1

fprintf(s,'X-106693');fgetl(s) % move, 1 step is equal to 0.3125 micons
                               % 40 x object pos +1

fprintf(s,'X+143999'); fgetl(s) % 16x pos +144000
fprintf(s,'X-143999');fgetl(s) % back to 40x     


fprintf(s,'?X');fgetl(s) % get position

fprintf(s,'S');fgetl(s) % stop




fclose(s);