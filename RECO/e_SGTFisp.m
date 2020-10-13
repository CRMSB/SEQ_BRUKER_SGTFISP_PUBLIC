%
% [im,p,Nav,kdata]=e_SGTFisp();
%
% Author:   Aurélien TROTIER  (a.trotier@gmail.com)
% Date:     2016-06-22
% Partner: none
% Institute: CRMSB (Bordeaux)
%
% Function description:

%
% Input:
%
% Output:
%
%
%
%
% Algorithm & bibliography:
%
% See also :
%
% To do :
%

function [im,p,Nav,kdata]=e_SGTFisp()
%read params in bruker directory selected
[p]=readParams_Bruker();

%%
sx=p.PVM_EncMatrix(1);
sy=p.ACQ_size(2);

if size(p.ACQ_size) < 3
    sz=1;
else
    sz=p.ACQ_size(3);
end

Nc=p.PVM_EncNReceivers;



% read fid file in the same directory
rawDataTemp=readFIDMc(p.ACQ_size(1)/2,Nc,[p.dirPath '/fid']);

kdata=zeros(sx,sy,sz,p.NR);

for i=1:Nc
   Nav(:,:,i)=double(rawDataTemp{i}(1:end-sx,:));
   kdata(:,:,:,:,i)=double(reshape(rawDataTemp{i}(end-sx+1:end,:),sx,sy,sz,p.NR));
end

im=fftshift(ifft(ifft(ifft(fftshift(kdata),[],1),[],2),[],3));

im=sqrt(sum(abs(im).^2,5));

end
