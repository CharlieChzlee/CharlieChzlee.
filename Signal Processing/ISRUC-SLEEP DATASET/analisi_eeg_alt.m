clear all
close all
clc

%% data loading
data=edfread("3.edf");
med_1=readmatrix("3_1.txt"); %valutazioni fasi medico 1 
med_2=readmatrix("3_2.txt"); %valutazioni fasi medico 2
data=timetable2table(data);

EOG=cell2mat(table2array(data(:,2:3))); %movimenti dell'occhio, 2 tracce
EEG=cell2mat(table2array(data(:,4:9))); %attività cerebrale, 6 tracce
EMG=cell2mat(table2array(data(:,10)));  %movimento del mento, 1 traccia
ECG=cell2mat(table2array(data(:,11)));  %elettrocardiogramma. 1 traccia

idx=find(med_1-med_2~=0);
differenze(:,1)=med_1(idx);
differenze(:,2)=med_2(idx);

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

idx_concordi=find(med_1-med_2==0);
temp=7*ones(length(med_1),1); %copia ''vuota'' di med
temp(idx_concordi)=med_1(idx_concordi); %indici concordi, il resto 7 significa discorde
idx_N2=find(temp==2);
idx_N3=find(temp==3);
idx_R=find(temp==5);
idx_W=find(temp==0);
idx_N1=find(temp==1);


%% estrapolazione di EEG e le sue epoche
n_segmento=400; %numero di campioni per segmento di 2 s
len_epoch=6000; %numero di indici contenuti in una epoca
nomi_stadi=char('W','N1','N2','N3','R');
for stadio=1:5
    figure(stadio)
for k=1:3 %indice della traccia
if stadio==1
    idx_stadi=idx_W';
end
if stadio==2
    idx_stadi=idx_N1';
end
if stadio==3
    idx_stadi=idx_N2';
end
if stadio==4
    idx_stadi=idx_N3';
end
if stadio==5
    idx_stadi=idx_R';
end
epochs=zeros(length(EEG(:,k))/len_epoch,len_epoch);
temp=EEG(:,k)';
    a=1;
    b=len_epoch;
for i=1:length(epochs(:,k))

   epochs(i,:)=temp(a:b);
    a=len_epoch*i+1;
    b=b+len_epoch;
end


%matrici delle epoche dei vari stadi
epoche_stadio=zeros(length(idx_stadi),len_epoch);
epoche_stadio=epochs(idx_stadi,:);

%% analisi in frequenza delle epoche concordi
nomi=char('F3-A2', 'C3-A2', 'O1-A2', 'F4-A1', 'C4-A1', '02-A1');
limitatore=30;%15-20 riferimento
N=len_epoch;
F=linspace(0,fc,N);

subplot(3,1,k)
for i=1:length(idx_stadi) %plot singolo stadio
    Y(i,:)=fft(epoche_stadio(i,:),N);
    PSD(i,:)=(abs(Y(i,:)).^2)/N;
    PSD_norm(i,:)=PSD(i,:)/max(PSD(i,:));
    % plot(F,PSD_norm(i,:),'Color',rand(1,3))
    % hold on
    % xlim([0 limitatore])
end
plot(F,mean(PSD_norm)/max(mean(PSD_norm)))

% plot(F,mean(PSD))
xlim([0 limitatore])
title([nomi(k,:),'stadio',nomi_stadi(stadio,:)])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

end
end