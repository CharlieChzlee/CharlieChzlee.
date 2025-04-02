clear all
close all
clc
%% informazioni
fc=200; %Hz frequenza di campionamento
limitatore=20;%riferimento 0-5
N=6000;
F=linspace(0,fc,N);
figure(1)
load 3_cuore.mat
subplot(5,1,1)%plot w
for i=1:length(ECG_risultati.PSD_W(:,1))
    plot(F,ECG_risultati.PSD_W(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('cuore:stadio W')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,2)%plot N1
for i=1:length(ECG_risultati.PSD_N1(:,1))
    plot(F,ECG_risultati.PSD_N1(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('cuore:stadio N1')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,3)%plot N2
for i=1:length(ECG_risultati.PSD_N2(:,1))
    plot(F,ECG_risultati.PSD_N2(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('cuore:stadio N2')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
subplot(5,1,4)%plot N3
for i=1:length(ECG_risultati.PSD_N3(:,1))
    plot(F,ECG_risultati.PSD_N3(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('cuore:stadio N3')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,5)%plot r
for i=1:length(ECG_risultati.PSD_R(:,1))
    plot(F,ECG_risultati.PSD_R(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('cuore:stadio R')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')