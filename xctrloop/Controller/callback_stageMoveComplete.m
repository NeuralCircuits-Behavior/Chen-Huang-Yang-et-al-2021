function callback_stageMoveComplete(varargin)
% pause(0.5); %dummy program
% disp('Move Completed!');
% pause(0.01);

varargin{1}.fMoveComplete=1;

% varargin{1}.position = varargin{1}.GetPosition_Position(0);
% disp(strcat(num2str(varargin{1}.fMoveComplete),', ',num2str(varargin{1}.position)));
end