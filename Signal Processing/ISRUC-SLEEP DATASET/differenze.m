clear all
close all
clc

%% informazioni
fc=200; %Hz frequenza di campionamento
t_segmento=2; %s divisione del segnale
t_epoch=30; %s durata di un'epoca
low_delta=[0.3,1]; %Hz banda low delta
delta=[1,4]; %Hz banda delta
theta=[4,8]; %Hz banda theta
alpha=[8,12];%Hz banda alpha
sigma=[12,15]; %Hz banda sigma
beta=[15,30]; %Hz banda beta
med_1=readmatrix("26_1.txt");
med_2=readmatrix('26_2.txt');

idx_differenze=find(med_2-med_1~=0);

stadi=7*ones(length(med_2),2);
stadi(idx_differenze,1)=med_1(idx_differenze);
stadi(idx_differenze,2)=med_2(idx_differenze);

idx=find(stadi(:,1)==1 & stadi(:,2)==2);


%% analisi in frequenza delle epoche discordi
nomi=char('F3-A2', 'C3-A2', 'O1-A2');
limitatore=30;%15-20 riferimento
N=6000;
F=linspace(0,fc,N);
load 26_frontale_sx.mat
epoche_discordi=EEG_risultati.epoche(idx,:);
subplot(3,1,1)
for i=1:length(epoche_discordi(:,1)) %plot singolo stadio
    Y(i,:)=fft(epoche_discordi(i,:),N);
    PSD(i,:)=(abs(Y(i,:)).^2)/N;
    PSD_norm(i,:)=PSD(i,:)/max(PSD(i,:));
    % plot(F,PSD_norm(i,:),'Color',rand(1,3))
    % hold on
    % xlim([0 limitatore])
end
plot(F,mean(PSD_norm)/max(mean(PSD_norm)))

% plot(F,mean(PSD))
xlim([0 limitatore])
title([nomi(1,:),'stadio'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

load 26_centrale_sx.mat
epoche_discordi=EEG_risultati.epoche(idx,:);
subplot(3,1,2)
for i=1:length(epoche_discordi(:,1)) %plot singolo stadio
    Y(i,:)=fft(epoche_discordi(i,:),N);
    PSD(i,:)=(abs(Y(i,:)).^2)/N;
    PSD_norm(i,:)=PSD(i,:)/max(PSD(i,:));
    % plot(F,PSD_norm(i,:),'Color',rand(1,3))
    % hold on
    % xlim([0 limitatore])
end
plot(F,mean(PSD_norm)/max(mean(PSD_norm)))

% plot(F,mean(PSD))
xlim([0 limitatore])
title([nomi(2,:),'stadio'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

load 26_occipitale_sx.mat
epoche_discordi=EEG_risultati.epoche(idx,:);
subplot(3,1,3)
for i=1:length(epoche_discordi(:,1)) %plot singolo stadio
    Y(i,:)=fft(epoche_discordi(i,:),N);
    PSD(i,:)=(abs(Y(i,:)).^2)/N;
    PSD_norm(i,:)=PSD(i,:)/max(PSD(i,:));
    % plot(F,PSD_norm(i,:),'Color',rand(1,3))
    % hold on
    % xlim([0 limitatore])
end
plot(F,mean(PSD_norm)/max(mean(PSD_norm)))

% plot(F,mean(PSD))
xlim([0 limitatore])
title([nomi(3,:),'stadio'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

figure(2)
load 26_cuore.mat
limitatore=20;
epoche_cuore=ECG_risultati.epoche(idx,:);
for i=1:length(epoche_cuore(:,1))
    Y=fft(epoche_cuore(i,:),6000);
    PSD=(abs(Y).^2)/6000;
    plot(F,PSD,'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title('cuore: conflitto 1-2')
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')