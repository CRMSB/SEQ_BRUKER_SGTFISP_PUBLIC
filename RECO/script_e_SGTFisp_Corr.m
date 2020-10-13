%% script e_SGTFisp
[im,p,Nav,kdata]=e_SGTFisp();
%%
% Récupération des données de self-gating

y=abs(sum(double(Nav(1:2,:,3)),1));

% Filtre gaussien appliquée aux données
sigma =10;
sizef = 15;
x = linspace(-sizef / 2-1, sizef / 2, sizef);
gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
gaussFilter = gaussFilter / sum (gaussFilter); % normalize

yfilt = conv (y, gaussFilter,'same');

%

T = 0.004;                     % Sample time
Fs = 1/T;                    % Sampling frequency
L = length(y);                     % Length of signal
t = (0:L-1)*T;                % Time vector


idxECG=peakfinder(yfilt/max(yfilt),1/70);

figure;plot(t,y);hold on;
plot(t,yfilt,'r');
plot(t(idxECG),yfilt(idxECG),'or');
title('Signal');
xlabel('time (seconds)');

%% Suppression 1er pick
idxECG(1)=[];
idxECG(end)=[];

%% 

RespWindowPos = 30; % nombre de points de chaque côté du peak.
RespWindowNeg = 30; % nombre de points de chaque côté du peak.

idxLinePos=idxECG+RespWindowPos;
idxLineNeg=idxECG-RespWindowNeg;

idxWindow=[];
for i=1:length(idxLineNeg)
    idxWindow=[idxWindow idxLineNeg(i):idxLinePos(i)];
end


idxLine=[idxLineNeg idxLinePos];
idxLine(idxLine < 1)=[];

figure;hax=axes;
plot(t,y);hold on;
plot(t,yfilt,'r');
plot(t(idxECG),yfilt(idxECG),'or');
title('Signal');
xlabel('time (seconds)');

line([t(idxLine)' t(idxLine)'],get(hax,'YLim'),'Color',[0 1 1])

%line([t(idxWindow)' t(idxWindow)'],get(hax,'YLim'),'Color',[0 1 1])


%%
kdata2=reshape(kdata,p.PVM_Matrix(1),[],p.PVM_EncNReceivers);

for i=1:length(idxWindow)
    kdata2(:,idxWindow(i),:)=nan;
end

kdata2=reshape(kdata2,size(kdata));

mask=kdata2;
mask(~isnan(mask))=1;
mask(isnan(mask))=0;
mask=sum(mask,4);

sum(mask(:)==0)/length(mask(:))*100% nombre de ligne non comblée
mask(mask==0)=1;


kdata3=kdata2;
kdata3(isnan(kdata3))=0;
kdata3=sum(kdata3,4)./mask;



imCor=fftshift(ifft(ifft(ifft(fftshift(kdata3),[],1),[],2),[],3));
imCor4=sqrt(sum(abs(imCor).^2,5));

%imagine(mean(im,4),imCor)


%% SOS of TF

imCorTot70_70=sqrt(imCor1.^2+imCor2.^2+imCor3.^2+imCor4.^2);

