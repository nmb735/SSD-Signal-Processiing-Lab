% cd_dc(Tf,Fo,Fa1,Fa2,Fm,pulso,N,Fc)
%
% Simula la conversion C/D y D/C de la señal
% No incluye filtro de antialiasing a la entrada
% x(t)=sin(2*pi*Fa1*t)+sin(2*pi*Fa2*t)
%
% Entrada
% Tf: duración de la simulación
% Fo: Frecuencia de muestreo en Hz de la señal continua
% Fa1: frecuencia en Hz de la sinusoide 1
% fa2: frecuencia en Hz de la sinusoide 2
% fs: Frecuencia de muestreo en Hz de la señal discreta
% pulso: 'tripuls' para pulso triangular
% 'rectpuls' para pulso rectangular
% N: orden del filtro Butterworth reconstructor, si N=0 no hay filtro
% fc: frecuencia de corte en Hz del filtro reconstructor
% Salida: no tiene, figura con la representacion temporal
% de las diferentes señales del proceso
%
function ad_da(Tf,Fo,Fa1,Fa2,Fm,pulso,N,Fc)
% Muestreo a una frecuencia mucho mas alta de lo necesario
% para dar la sensación de señal continua.
if Fo<Fm/10, error('Fo debe ser mayor o igual que Fm/10');end
To = 1/Fo; % Periodo de muestreo señal continua = inverso de la frecuencia
t = 0:To:Tf; % Instantes de muestreo para señal continua
xt = sin(2*pi*Fa1*t) + sin(2*pi*Fa2*t); % Genero la señal continua
figure; % Abro una nueva figura
subplot(2,2,1); % Divido la figura en 4 subfiguras y me situo en la primera
plot(t*1e3,xt);% Represento la señal
xlabel('t(ms)'); ylabel('x(t)');title(sprintf('Fo = %d kHz',Fo/1000));
%
%
Ts = 1/Fm; % Periodo de muestreo = inverso de la frecuencia
n = 0: Ts: Tf; % Instantes de muestreo para señal discreta
xn = sin(2*pi*Fa1*n) + sin(2*pi*Fa2*n);; % Genero la señal discreta
subplot(2,2,2); % Me situo en la segunda subfigura
stem(n*1e3,xn); % Represento la señal
xlabel('t(ms)');ylabel('x(n)');title(sprintf('Fm = %d kHz',Fm/1000));
%
%
% Uso ZOH para generar la señal continua
if strcmp(pulso,'tripuls'),
xr = pulstran(t,[n-Ts; xn]','tripuls',2*Ts);
elseif strcmp(pulso,'rectpuls'),
xr = pulstran(t,[n-Ts/2; xn]','rectpuls',Ts);
else
error('Tipo de pulso no disponible');
end;
subplot(2,2,3);
plot(t*1e3,xr);
xlabel('t(ms)');ylabel('x_r(t)');title(sprintf('Pulso = %s',pulso));
%
%
% Filtro reconstructor
if N==0, % si el orden es cero no utilizo filtro
xs=xr;
Fc=0;
else
% Obtengo parámetros de un filtro paso bajo Butterworth
% de orden N y frecuencia de corte fc, muestreado a fo
[B,A]=butter(N,2*Fc/Fo); %
xs = filter(B,A,xr); %filtro la señal xr
end;
subplot(2,2,4);
plot(t*1e3,xs);
xlabel('t(ms)');ylabel('x_s(t)');
title(sprintf('N = %d, Fc = %.1f kHz',N,Fc/1000));
return