%% P4: SiSD
%% Exercici 1

filterDesigner
%% Exercici 2
%% Exercici 3
%% Exercici 4
%% Exercici 5
%% Exercici 6

load sounds.mat

rep_tyf(guitar);
rep_tyf(triang);

guitarObj = audioplayer(guitar,fs);
play(guitarObj);

triangObj = audioplayer(triang,fs);
play(triangObj);

%% B
conciertoClavedeSol = triang+guitar;

rep_tyf(conciertoClavedeSol);

conciertoClavedeSolObj = audioplayer(conciertoClavedeSol,fs);
play(conciertoClavedeSolObj);


%% Exercici 7

x1 = guitar; %x1 es la señal de guitarra
%Filtro IIR elíptico, orden 15, 1 dB de rizado en banda de paso,
%banda de rechazo por debajo de 80 dB, frecuencia de corte 4 kHz
[B1,A1]=ellip(15,1,80,4000/(fs/2));% A1, B1 coeficientes del filtro
x1f = filter(B1,A1,x1);%filtramos x1 usando el filtro anterior

rep_tyf(x1f);

x1fObj = audioplayer(x1f,fs);
play(x1fObj);

x2 = triang; %x2 es la señal de triangulo
%Filtro IIR elíptico, orden 15, 1 dB de rizado en banda de paso,
%banda de rechazo por debajo de 80 dB, frecuencia de corte 6 kHz
[B2,A2]=ellip(15,1,80,6000/(fs/2));% A1, B1 coeficientes del filtro
x2f = filter(B2,A2,x2);%filtramos x1 usando el filtro anterior

rep_tyf(x2f);

x2fObj = audioplayer(x2f,fs);
play(x2fObj);
%% Exercici 8

n=0:(length(x1f)-1); %Vector con índices
x1m=x1f.*cos(2*pi*5000/fs*n);% Multiplico por coseno (5k)
x2m=x2f.*cos(2*pi*15000/fs*n);% Multiplico por coseno (15k)

s = x1m+x2m;

rep_tyf(s);

sObj = audioplayer(s,fs);
play(sObj);
%% Exercici 9

y1f=s.*cos(2*pi*5000/fs*n);%multiplico por coseno
y1=filter(B1,A1,y1f);%filtro para quedarme con la señal de guitarra
y2f=s.*cos(2*pi*15000/fs*n);%multiplico por coseno
y2=filter(B2,A2,y2f);%filtro para quedarme con la señal de triangulo

%% y1f
rep_tyf(y1f);
y1fObj = audioplayer(y1f,fs);
play(y1fObj);

%% y1
rep_tyf(y1);
y1Obj = audioplayer(y1,fs);
play(y1Obj);

%% y2f
rep_tyf(y2f);
y2fObj = audioplayer(y2f,fs);
play(y2fObj);

%% y2
rep_tyf(y2);
y2Obj = audioplayer(y2,fs);
play(y2Obj);