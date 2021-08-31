% 2018/4/25 CH


exp = 0.004:0.004:8; % mm
inter = 3;
exa4 = zeros(inter,size(exp,2));
t4 = zeros(inter,size(exp,2));
% Microstep2
for ii = 1:inter
    for s = 1:numel(exp)
        tic;
        m.stageMObj.moveAbsolute('Z',exp(s));
        t4(ii,s) = toc;
        m.stageMObj.waitForStageStatic();
        exa4(ii,s) = m.stageMObj.getZCurrentPosition();
    end
end
%%