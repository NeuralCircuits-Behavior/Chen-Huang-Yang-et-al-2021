function func_figClosereq(src,callbackdata)
% Close request function
% to display a question dialog box
selection = questdlg('Close This Figure?',...
    'Close Request Function',...
    'Yes','Cancel','Cancel');
switch selection
    case 'Yes'
        delete(gcf)
        delete(gcf)
    case 'Cancel'
        return
end
end