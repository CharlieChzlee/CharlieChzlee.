clear all
close all
clc

data=edfread("3.edf");
med_1=readmatrix("3_1.txt"); %valutazioni fasi medico 1 
med_2=readmatrix("3_2.txt"); %valutazioni fasi medico 2
data=timetable2table(data);
data=cell2mat(table2array(data(:,2:11)));

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

%% estrapolazione dei segnali e delle loro epoche
n_segmento=400; %numero di campioni per segmento di 2 s
len_epoch=6000; %numero di indici contenuti in una epoca
for k=1:10 %traccia
epochs=zeros(length(data(:,k))/len_epoch,len_epoch);
temp=data(:,k)';
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

risultati.epoche=epochs;
risultati.W=W;
risultati.N1=N1;
risultati.N2=N2;
risultati.N3=N3;
risultati.R=R;
risultati.PSD_W=PSD_W;
risultati.PSD_N1=PSD_N1;
risultati.PSD_N2=PSD_N2;
risultati.PSD_N3=PSD_N3;
risultati.PSD_R=PSD_R;
if k==1
    save 3_occhio_sx.mat risultati
end
if k==2
    save 3_occhio_dx.mat risultati
end
if k==3
    save 3_frontale_sx.mat risultati
end

if k==4
    save 3_centrale_sx.mat risultati
end
if k==5
    save 3_occipitale_sx.mat risultati
end
if k==6
    save 3_frontale_dx.mat risultati
end
if k==7
    save 3_centrale_dx.mat risultati
end
if k==8
    save 3_occipitale_dx.mat risultati
end
if k==9
    save 3_mento.mat risultati
end
if k==10
    save 3_cuore.mat risultati
end
end
