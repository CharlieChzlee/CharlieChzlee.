close all
clc
clear all
len_epoch=6000; %numero di indici contenuti in una epoca
passo=len_epoch/200;
n_segmento=400; %numero di campioni per segmento di 2 s
low_delta=[0.3,1]*passo; %Hz banda low delta
delta=[1,4]*passo; %Hz banda delta
theta=[4,8]*passo; %Hz banda theta
alpha=[8,12]*passo;%Hz banda alpha
sigma=[12,15]*passo; %Hz banda sigma
beta=[15,30]*passo; %Hz banda beta

med_1=readmatrix('3_1.txt');
med_2=readmatrix('3_2.txt');
load 26_frontale_sx.mat

PSD_low_delta=zeros(1,length(EEG_risultati.epoche(:,1)));
PSD_delta=zeros(1,length(EEG_risultati.epoche(:,1)));
PSD_theta=zeros(1,length(EEG_risultati.epoche(:,1)));
PSD_alpha=zeros(1,length(EEG_risultati.epoche(:,1)));
PSD_sigma=zeros(1,length(EEG_risultati.epoche(:,1)));
PSD_beta=zeros(1,length(EEG_risultati.epoche(:,1)));

for i=1:length(EEG_risultati.epoche(:,1)) %itero per tutte le epoche
    Y=fft(EEG_risultati.epoche(i,:),len_epoch);
    PSD=(abs(Y).^2)/len_epoch;
    PSD_low_delta(i)=PSD_low_delta(i)+sum(PSD(low_delta(1):low_delta(2)))/length(PSD(low_delta(1):low_delta(2)));
    PSD_delta(i)=PSD_delta(i)+sum(PSD(delta(1):delta(2)))/length(PSD(delta(1):delta(2)));
    PSD_theta(i)=PSD_theta(i)+sum(PSD(theta(1):theta(2)))/length(PSD(theta(1):theta(2)));
    PSD_alpha(i)=PSD_alpha(i)+sum(PSD(alpha(1):alpha(2)))/length(PSD(alpha(1):alpha(2)));
    PSD_sigma(i)=PSD_sigma(i)+sum(PSD(sigma(1):sigma(2)))/length(PSD(sigma(1):sigma(2)));
    PSD_beta(i)=PSD_beta(i)+sum(PSD(beta(1):beta(2)))/length(PSD(beta(1):beta(2)));
end

load 26_centrale_sx.mat
for i=1:length(EEG_risultati.epoche(:,1)) %itero per tutte le epoche
    Y=fft(EEG_risultati.epoche(i,:),len_epoch);
    PSD=(abs(Y).^2)/len_epoch;
    PSD_low_delta(i)=PSD_low_delta(i)+sum(PSD(low_delta(1):low_delta(2)))/length(PSD(low_delta(1):low_delta(2)));
    PSD_delta(i)=PSD_delta(i)+sum(PSD(delta(1):delta(2)))/length(PSD(delta(1):delta(2)));
    PSD_theta(i)=PSD_theta(i)+sum(PSD(theta(1):theta(2)))/length(PSD(theta(1):theta(2)));
    PSD_alpha(i)=PSD_alpha(i)+sum(PSD(alpha(1):alpha(2)))/length(PSD(alpha(1):alpha(2)));
    PSD_sigma(i)=PSD_sigma(i)+sum(PSD(sigma(1):sigma(2)))/length(PSD(sigma(1):sigma(2)));
    PSD_beta(i)=PSD_beta(i)+sum(PSD(beta(1):beta(2)))/length(PSD(beta(1):beta(2)));
end

load 26_occipitale_sx.mat
for i=1:length(EEG_risultati.epoche(:,1)) %itero per tutte le epoche
    Y=fft(EEG_risultati.epoche(i,:),len_epoch);
    PSD=(abs(Y).^2)/len_epoch;
    PSD_low_delta(i)=PSD_low_delta(i)+sum(PSD(low_delta(1):low_delta(2)))/length(PSD(low_delta(1):low_delta(2)));
    PSD_delta(i)=PSD_delta(i)+sum(PSD(delta(1):delta(2)))/length(PSD(delta(1):delta(2)));
    PSD_theta(i)=PSD_theta(i)+sum(PSD(theta(1):theta(2)))/length(PSD(theta(1):theta(2)));
    PSD_alpha(i)=PSD_alpha(i)+sum(PSD(alpha(1):alpha(2)))/length(PSD(alpha(1):alpha(2)));
    PSD_sigma(i)=PSD_sigma(i)+sum(PSD(sigma(1):sigma(2)))/length(PSD(sigma(1):sigma(2)));
    PSD_beta(i)=PSD_beta(i)+sum(PSD(beta(1):beta(2)))/length(PSD(beta(1):beta(2)));
end
idx_concordi=find(med_1-med_2==0);
temp=7*ones(length(med_1),1); %copia ''vuota'' di med
temp(idx_concordi)=med_1(idx_concordi); %indici concordi, il resto 7 significa discorde
idx_N2=find(temp==2);
idx_N3=find(temp==3);
idx_R=find(temp==5);
idx_W=find(temp==0);
idx_N1=find(temp==1);

% plot(PSD_low_delta/max(PSD_low_delta))
% hold on
% plot(PSD_delta/max(PSD_delta),'red')
% hold on
% plot(PSD_theta/max(PSD_theta),'green')
% hold on
% plot(PSD_alpha/max(PSD_alpha),'yellow')
% grid on
% ylim([0 0.2])
% xlabel('Epoche (30s)')
% ylabel('PSD norm')
PSD_low_delta=PSD_low_delta/3;
PSD_delta=PSD_delta/3;
PSD_theta=PSD_theta/3;
PSD_alpha=PSD_alpha/3;


plot(PSD_low_delta)
hold on
plot(PSD_delta,'red')
hold on
plot(PSD_theta,'green')
hold on
plot(PSD_alpha,'yellow')
grid on
xlabel('Epoche (30s)')
ylabel('PSD')
xline(idx_W,'--blue','W')
xline(idx_N1,'--red','N1')
xline(idx_N2,'--green','N2')
xline(idx_N3,'--yellow','N3')
xline(idx_R,'--black','R')
xlim([650 750])
legend('low delta','delta','theta','alpha')