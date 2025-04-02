clear all
close all
clc
fc=200;
N=6000;
F=linspace(0,fc,N);

low_delta=[0.3,1]; %Hz banda low delta
delta=[1,4]; %Hz banda delta
theta=[4,8]; %Hz banda theta
alpha=[8,12];%Hz banda alpha
sigma=[12,15]; %Hz banda sigma
beta=[15,30]; %Hz banda beta
passo=N/fc;
load 3_frontale_sx.mat
figure(1)
for i=1:5
    campioni=[low_delta(1):fc/N:low_delta(2)]*passo;
    temp=EEG_risultati.PSD_W;
    PSD_low_delta=sum(temp(i,low_delta(1)*passo:low_delta(2)*passo))/length(campioni);
    PSD_delta=sum(temp(i,delta(1)*passo:delta(2)*passo))/length(campioni);
    PSD_theta=sum(temp(i,theta(1)*passo:theta(2)*passo))/length(campioni);
    PSD_alpha=sum(temp(i,alpha(1)*passo:alpha(2)*passo))/length(campioni);
    PSD_sigma=sum(temp(i,sigma(1)*passo:sigma(2)*passo))/length(campioni);
end
