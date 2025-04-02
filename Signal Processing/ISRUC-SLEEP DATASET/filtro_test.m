clear all
close all
clc
load 3_cuore.mat
F=linspace(0,200,6000);
t=linspace(0,30,6000);
%W non lo facciamo
%N1 40
%N2 60
%N3 60
%R 60
% %% implementazione filtro notch Hz=3.5 Hz
% Hz=5.8;
% fase=Hz*2*pi/200;
% z=[exp(1i*fase);exp(-1i*fase)];
% p=[0.9*exp(1i*fase);0.9*exp(-1i*fase)];
% 
% fase=7*2*pi/200;
% z=[z;exp(1i*fase);exp(-1i*fase)];
% p=[p;0.9*exp(1i*fase);0.9*exp(-1i*fase)];
% b=poly(z);
% a=poly(p);

A=50; %parametro di attenuazione
R=0.03; %parametro di ondulazione
FS=200;
Bp=5; %banda passante
Wp=Bp/(FS/2);

Bo=9; %banda oscura
Ws=Bo/(FS/2);

Rs=20*log10(A);
Rp=(20*log10(1+R)-20*log10(1-R))/2;

[n, Wn]=buttord(Wp,Ws,Rp,Rs); %ordine del filtro, banda per -3dB normalizzata

[b,a]=butter(n,Wn,"low"); %parametri per la funzione
temp=filter(b,a,ECG_risultati.N1(3,:));
Y=(abs(fft(temp,6000))).^2/6000;
plot(t,temp)
% plot(F,Y)
% xlim([0 100])