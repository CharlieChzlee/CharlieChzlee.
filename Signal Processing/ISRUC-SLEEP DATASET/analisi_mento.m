clear all
close all
clc
%% informazioni
fc=200; %Hz frequenza di campionamento
limitatore=100;%riferimento 0-5
limitatore1=0;
N=6000;
F=linspace(0,fc,N);
figure(1)
load 26_mento.mat
subplot(5,1,1)%plot w
for i=1:length(EMG_risultati.PSD_W(:,1))
    temp(i,:)=EMG_risultati.PSD_W(i,:)/max(EMG_risultati.PSD_W(i,:));
    % plot(F,temp(i,:),'Color',rand(1,3))
    % hold on
    % xlim([limitatore1 limitatore])
end
plot(F,mean(temp))
xlim([limitatore1 limitatore])
title('mento:stadio W')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,2)%plot N1
for i=1:length(EMG_risultati.PSD_N1(:,1))
    temp(i,:)=EMG_risultati.PSD_N1(i,:)/max(EMG_risultati.PSD_N1(i,:));
    % plot(F,temp(i,:),'Color',rand(1,3))
    % hold on
    % xlim([limitatore1 limitatore])
end
plot(F,mean(temp))
xlim([limitatore1 limitatore])
title('mento:stadio N1')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,3)%plot N2
for i=1:length(EMG_risultati.PSD_N2(:,1))
    temp(i,:)=EMG_risultati.PSD_N2(i,:)/max(EMG_risultati.PSD_N2(i,:));
    % plot(F,temp(i,:),'Color',rand(1,3))
    % hold on
    % xlim([limitatore1 limitatore])
end
plot(F,mean(temp))
xlim([limitatore1 limitatore])
title('mento:stadio N2')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
subplot(5,1,4)%plot N3
for i=1:length(EMG_risultati.PSD_N3(:,1))
    temp(i,:)=EMG_risultati.PSD_N3(i,:)/max(EMG_risultati.PSD_N3(i,:));
    % plot(F,temp(i,:),'Color',rand(1,3))
    % hold on
    % xlim([limitatore1 limitatore])
end
plot(F,mean(temp))
xlim([limitatore1 limitatore])
title('mento:stadio N3')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,5)%plot r
for i=1:length(EMG_risultati.PSD_R(:,1))
    temp(i,:)=EMG_risultati.PSD_R(i,:)/max(EMG_risultati.PSD_R(i,:));
    % plot(F,temp(i,:),'Color',rand(1,3))
    % hold on
    % xlim([limitatore1 limitatore])
end
plot(F,mean(temp))
xlim([limitatore1 limitatore])
title('mento:stadio R')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')