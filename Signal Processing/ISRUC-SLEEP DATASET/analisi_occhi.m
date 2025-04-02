clear all
close all
clc
%% informazioni
fc=200; %Hz frequenza di campionamento
limitatore=7;%riferimento 0-5
N=6000;
F=linspace(0,fc,N);
figure(1)%occhio sinistro
load 26_occhio_sx.mat
subplot(5,1,1)%plot w
for i=1:length(EOG_risultati.PSD_W(:,1))
    plot(F,EOG_risultati.PSD_W(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio sx:stadio W')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,2)%plot N1
for i=1:length(EOG_risultati.PSD_N1(:,1))
    plot(F,EOG_risultati.PSD_N1(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio sx:stadio N1')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,3)%plot N2
for i=1:length(EOG_risultati.PSD_N2(:,1))
    plot(F,EOG_risultati.PSD_N2(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio sx:stadio N2')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
subplot(5,1,4)%plot N3
for i=1:length(EOG_risultati.PSD_N3(:,1))
    plot(F,EOG_risultati.PSD_N3(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio sx:stadio N3')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,5)%plot r
for i=1:length(EOG_risultati.PSD_R(:,1))
    plot(F,EOG_risultati.PSD_R(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio sx:stadio R')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

figure(2)%occhio destro
load 26_occhio_dx.mat
subplot(5,1,1)%plot w
for i=1:length(EOG_risultati.PSD_W(:,1))
    plot(F,EOG_risultati.PSD_W(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio dx:stadio W')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,2)%plot N1
for i=1:length(EOG_risultati.PSD_N1(:,1))
    plot(F,EOG_risultati.PSD_N1(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio dx:stadio N1')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,3)%plot N2
for i=1:length(EOG_risultati.PSD_N2(:,1))
    plot(F,EOG_risultati.PSD_N2(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio dx:stadio N2')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
subplot(5,1,4)%plot N3
for i=1:length(EOG_risultati.PSD_N3(:,1))
    plot(F,EOG_risultati.PSD_N3(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio dx:stadio N3')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')

subplot(5,1,5)%plot r
for i=1:length(EOG_risultati.PSD_R(:,1))
    plot(F,EOG_risultati.PSD_R(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('occhio dx:stadio R')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')