clear all
close all
clc

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
for k=1:6 %traccia
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

N=len_epoch;
F=linspace(0,fc,N);

for i=1:length(idx_W) %PSD_W
    Y_W(i,:)=fft(W(i,:),N);
    PSD_W(i,:)=(abs(Y_W(i,:)).^2)/N;
end

for i=1:length(idx_N1) %PSD_N1
    Y_N1(i,:)=fft(N1(i,:),N);
    PSD_N1(i,:)=(abs(Y_N1(i,:)).^2)/N;
end

for i=1:length(idx_N2) %PSD_N2
    Y_N2(i,:)=fft(N2(i,:),N);
    PSD_N2(i,:)=(abs(Y_N2(i,:)).^2)/N;
end

for i=1:length(idx_N3) %PSD_N3
    Y_N3(i,:)=fft(N3(i,:),N);
    PSD_N3(i,:)=(abs(Y_N3(i,:)).^2)/N;
end

for i=1:length(idx_R) %PSD_R
    Y_R(i,:)=fft(R(i,:),N);
    PSD_R(i,:)=(abs(Y_R(i,:)).^2)/N;
end

EEG_risultati.epoche=epochs;
EEG_risultati.W=W;
EEG_risultati.N1=N1;
EEG_risultati.N2=N2;
EEG_risultati.N3=N3;
EEG_risultati.R=R;
EEG_risultati.PSD_W=PSD_W;
EEG_risultati.PSD_N1=PSD_N1;
EEG_risultati.PSD_N2=PSD_N2;
EEG_risultati.PSD_N3=PSD_N3;
EEG_risultati.PSD_R=PSD_R;
if k==1
    save 26_frontale_sx.mat EEG_risultati
end
if k==2
    save 26_centrale_sx.mat EEG_risultati
end
if k==3
    save 26_occipitale_sx.mat EEG_risultati
end
if k==4
    save 26_frontale_dx.mat EEG_risultati
end
if k==5
    save 26_centrale_dx.mat EEG_risultati
end
if k==6
    save 26_occipitale_dx.mat EEG_risultati
end
end

%% estrapolazione EOG e le sue epoche
for k=1:2 %traccia
epochs=zeros(length(EOG(:,k))/len_epoch,len_epoch);
temp=EOG(:,k)';
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

N=len_epoch;
F=linspace(0,fc,N);

for i=1:length(idx_W) %PSD_W
    Y_W(i,:)=fft(W(i,:),N);
    PSD_W(i,:)=(abs(Y_W(i,:)).^2)/N;
end

for i=1:length(idx_N1) %PSD_N1
    Y_N1(i,:)=fft(N1(i,:),N);
    PSD_N1(i,:)=(abs(Y_N1(i,:)).^2)/N;
end

for i=1:length(idx_N2) %PSD_N2
    Y_N2(i,:)=fft(N2(i,:),N);
    PSD_N2(i,:)=(abs(Y_N2(i,:)).^2)/N;
end

for i=1:length(idx_N3) %PSD_N3
    Y_N3(i,:)=fft(N3(i,:),N);
    PSD_N3(i,:)=(abs(Y_N3(i,:)).^2)/N;
end

for i=1:length(idx_R) %PSD_R
    Y_R(i,:)=fft(R(i,:),N);
    PSD_R(i,:)=(abs(Y_R(i,:)).^2)/N;
end

EOG_risultati.epoche=epochs;
EOG_risultati.W=W;
EOG_risultati.N1=N1;
EOG_risultati.N2=N2;
EOG_risultati.N3=N3;
EOG_risultati.R=R;
EOG_risultati.PSD_W=PSD_W;
EOG_risultati.PSD_N1=PSD_N1;
EOG_risultati.PSD_N2=PSD_N2;
EOG_risultati.PSD_N3=PSD_N3;
EOG_risultati.PSD_R=PSD_R;
if k==1
    save 26_occhio_sx.mat EOG_risultati
end
if k==2
    save 26_occhio_dx.mat EOG_risultati
end
end
%% estrapolazione EMG e le sue epoche

epochs=zeros(length(EMG)/len_epoch,len_epoch);
temp=EMG';
    a=1;
    b=len_epoch;
for i=1:length(epochs(:,1))

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

N=len_epoch;
F=linspace(0,fc,N);

for i=1:length(idx_W) %PSD_W
    Y_W(i,:)=fft(W(i,:),N);
    PSD_W(i,:)=(abs(Y_W(i,:)).^2)/N;
end

for i=1:length(idx_N1) %PSD_N1
    Y_N1(i,:)=fft(N1(i,:),N);
    PSD_N1(i,:)=(abs(Y_N1(i,:)).^2)/N;
end

for i=1:length(idx_N2) %PSD_N2
    Y_N2(i,:)=fft(N2(i,:),N);
    PSD_N2(i,:)=(abs(Y_N2(i,:)).^2)/N;
end

for i=1:length(idx_N3) %PSD_N3
    Y_N3(i,:)=fft(N3(i,:),N);
    PSD_N3(i,:)=(abs(Y_N3(i,:)).^2)/N;
end

for i=1:length(idx_R) %PSD_R
    Y_R(i,:)=fft(R(i,:),N);
    PSD_R(i,:)=(abs(Y_R(i,:)).^2)/N;
end

EMG_risultati.epoche=epochs;
EMG_risultati.W=W;
EMG_risultati.N1=N1;
EMG_risultati.N2=N2;
EMG_risultati.N3=N3;
EMG_risultati.R=R;
EMG_risultati.PSD_W=PSD_W;
EMG_risultati.PSD_N1=PSD_N1;
EMG_risultati.PSD_N2=PSD_N2;
EMG_risultati.PSD_N3=PSD_N3;
EMG_risultati.PSD_R=PSD_R;
save 26_mento.mat EMG_risultati

%% estrapolazione ECG e le sue epoche

epochs=zeros(length(ECG)/len_epoch,len_epoch);
temp=ECG';
    a=1;
    b=len_epoch;
for i=1:length(epochs(:,1))

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

N=len_epoch;
F=linspace(0,fc,N);

for i=1:length(idx_W) %PSD_W
    Y_W(i,:)=fft(W(i,:),N);
    PSD_W(i,:)=(abs(Y_W(i,:)).^2)/N;
end

for i=1:length(idx_N1) %PSD_N1
    Y_N1(i,:)=fft(N1(i,:),N);
    PSD_N1(i,:)=(abs(Y_N1(i,:)).^2)/N;
end

for i=1:length(idx_N2) %PSD_N2
    Y_N2(i,:)=fft(N2(i,:),N);
    PSD_N2(i,:)=(abs(Y_N2(i,:)).^2)/N;
end

for i=1:length(idx_N3) %PSD_N3
    Y_N3(i,:)=fft(N3(i,:),N);
    PSD_N3(i,:)=(abs(Y_N3(i,:)).^2)/N;
end

for i=1:length(idx_R) %PSD_R
    Y_R(i,:)=fft(R(i,:),N);
    PSD_R(i,:)=(abs(Y_R(i,:)).^2)/N;
end

ECG_risultati.epoche=epochs;
ECG_risultati.W=W;
ECG_risultati.N1=N1;
ECG_risultati.N2=N2;
ECG_risultati.N3=N3;
ECG_risultati.R=R;
ECG_risultati.PSD_W=PSD_W;
ECG_risultati.PSD_N1=PSD_N1;
ECG_risultati.PSD_N2=PSD_N2;
ECG_risultati.PSD_N3=PSD_N3;
ECG_risultati.PSD_R=PSD_R;
save 26_cuore.mat ECG_risultati
