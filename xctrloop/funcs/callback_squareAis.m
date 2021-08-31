function callback_squareAis(src,event)
v = abs(diff(src.Position(3:4)));
%{
if v == 0
    %width == height
    return
elseif src.Position(3) > src.Position(4)
    %width > height
    src.Position = ...
        [src.Position+v/2,src.Position(2),...
        src.Position(4),src.Position(4)];
elseif src.Position(3) < src.Position(4)
    %width < height
    src.Position = ...
        [src.Position(1),src.Position(2)+v/2,...
        src.Position(3),src.Position(3)];
end
%}
if v == 0
    return
else
    axis square
end
end