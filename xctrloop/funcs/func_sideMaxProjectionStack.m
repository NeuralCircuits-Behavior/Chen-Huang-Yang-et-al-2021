function imTileSides40 = func_sideMaxProjectionStack(ims,sideMaxProjPxl)
% zScanRange40N x 1200 x 4
%      1
%    2   3
%      4
zScanRange40N = size(ims,4);
imTileSides40 = zeros(zScanRange40N,1200,4,'uint16');
imTileSides40(:,:,1) = ...
    squeeze(max(ims(1:sideMaxProjPxl,:,1,:),[],1))'; % z x 1200
imTileSides40(:,:,2) = ...
    squeeze(max(ims(:,1:sideMaxProjPxl,1,:),[],2))'; % z x 1200
imTileSides40(:,:,3) = ...
    squeeze(max(ims(:,end-sideMaxProjPxl:end,1,:),[],2))'; % z x 1200
imTileSides40(:,:,4) = ...
    squeeze(max(ims(end-sideMaxProjPxl:end,:,1,:),[],1))'; % z x 1200
end