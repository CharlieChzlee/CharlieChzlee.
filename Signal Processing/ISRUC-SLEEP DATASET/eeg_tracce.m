clear all
close all
clc

%% data loading
data=edfread("26.edf");
med_1=readmatrix("26_1.txt"); %valutazioni fasi medico 1 
med_2=readmatrix("26_2.txt"); %valutazioni fasi medico 2
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
for k=1:6 %indice della traccia

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
N2=zeros(length(idx_N2),len_epoch);
N3=zeros(length(idx_N3),len_epoch);
R=zeros(length(idx_R),len_epoch);
W=zeros(length(idx_W),len_epoch);
N1=zeros(length(idx_N1),len_epoch);


N2=epochs(idx_N2,:);
N3=epochs(idx_N3,:);
R=epochs(idx_R,:);
W=epochs(idx_W,:);
N1=epochs(idx_N1,:);

%% analisi in frequenza delle epoche concordi
nomi=char('F3-A2', 'C3-A2', 'O1-A2', 'F4-A1', 'C4-A1', '02-A1');
limitatore=30;%15-20 riferimento
N=len_epoch;
F=linspace(0,fc,N);
figure(k)
subplot(5,1,1)
for i=1:length(idx_W) %plot di W
    Y_W(i,:)=fft(W(i,:),N);
    PSD_W(i,:)=(abs(Y_W(i,:)).^2)/N;
    PSD_W_norm(i,:)=PSD_W(i,:)/max(PSD_W(i,:));
    plot(F,PSD_W_norm(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title([nomi(k,:),'stadio W'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

subplot(5,1,2)
for i=1:length(idx_N1) %plot di N1
    Y_N1(i,:)=fft(N1(i,:),N);
    PSD_N1(i,:)=(abs(Y_N1(i,:)).^2)/N;
    PSD_N1_norm(i,:)=PSD_N1(i,:)/max(PSD_N1(i,:));
    plot(F,PSD_N1_norm(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title([nomi(k,:),'stadio N1'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

subplot(5,1,3)
for i=1:length(idx_N2) %plot di N2
    Y_N2(i,:)=fft(N2(i,:),N);
    PSD_N2(i,:)=(abs(Y_N2(i,:)).^2)/N;
    PSD_N2_norm(i,:)=PSD_N2(i,:)/max(PSD_N2(i,:));
    plot(F,PSD_N2_norm(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title([nomi(k,:),'stadio N2'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

subplot(5,1,4)
for i=1:length(idx_N3) %plot di N3
    Y_N3(i,:)=fft(N3(i,:),N);
    PSD_N3(i,:)=(abs(Y_N3(i,:)).^2)/N;
    PSD_N3_norm(i,:)=PSD_N3(i,:)/max(PSD_N3(i,:));
    plot(F,PSD_N3_norm(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title([nomi(k,:),'stadio N3'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])

subplot(5,1,5)
for i=1:length(idx_R) %plot di R
    Y_R(i,:)=fft(R(i,:),N);
    PSD_R(i,:)=(abs(Y_R(i,:)).^2)/N;
    PSD_R_norm(i,:)=PSD_R(i,:)/max(PSD_R(i,:));
    plot(F,PSD_R_norm(i,:),'Color',rand(1,3))
    hold on
    xlim([0 limitatore])
end
title([nomi(k,:),'stadio R'])
grid on
xlabel('Frequenze (Hz)')
ylabel('PSD')
xline([low_delta delta theta alpha beta])
end
