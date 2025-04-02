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
% plot(F,ECG_risultati.PSD_N1(3,:))
% xlim([0 20])
for i=1:length(ECG_risultati.W(:,1))-1
    temp=ECG_risultati.W(i,:);
% idx_threshold=find(temp>40);
% idx_peaks=[0];
% for a=1:length(idx_threshold)-1
%     if idx_threshold(a+1)-idx_threshold(a)~=1
%         idx_peaks=[idx_peaks idx_threshold(a)];
%     end
% end
[~, locs] = findpeaks(temp, 'MinPeakHeight', 40, 'MinPeakDistance', 30);
% idx_peaks=[idx_peaks(2:length(idx_peaks)) idx_threshold(length(idx_threshold))];
t_peaks=t(locs);


%% quesito 3
for a=2:length(t_peaks)
    tacogramma(a-1)=t_peaks(a)-t_peaks(a-1);% attenzione e' in millisecondi
end
%% quesito 4
for a=1:length(tacogramma)
    bpm(i,a)=60/(tacogramma(a));
end
bpm_medio(i,:)=mean(bpm(i,:));
bpm_max(i,:)=max(bpm(i,:));
bpm_min(i,:)=min(bpm(i,:));
end
plot(bpm_medio)
hold on
plot(bpm_max,'r')
hold on
plot(bpm_min,'green')
legend('medio','massimo','minimo')
