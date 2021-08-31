function out = func_deblank(in)
% 2019/7/6, CH
% in could be cell 
    out = regexprep(in,' +','');
end