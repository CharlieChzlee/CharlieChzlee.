clear all
close all
clc
load 26_occhio_dx.mat
t=linspace(0,30,6000);
for i=1:length(EOG_risultati.N2(2:3,1))
    plot(t,EOG_risultati.N2(i,:),'Color',rand(1,3))
    hold on
end