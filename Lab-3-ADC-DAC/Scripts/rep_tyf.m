function rep_tyf(x)
% rep_tyf(x)
% x: secuencia discreta a representar
%  Representa la secuencia x en el dominio del tiempo y la frecuencia
% 
N=length(x); %Longitud de la secuencia
n=0:(N-1); % Genero instantes de tiempo equiespaciados

X_f=fft(x)/length(x); %Hago la DFT, el resultado va desde 0 a 1
X_f=fftshift(X_f); %Transformo el resultado de -1/2 a 1/2
f=linspace(-1/2,1/2,N+1); %Genero N+1 muestras de frecuencia espaciadas 1/N 
f=f(1:N);%Me quedo con las N primeras

%Representacion grafica
figure;%crea figura nueva

subplot(2,1,1);
plot(n,x);
axis([n(1) n(end) -max(abs(x)) max(abs(x))]);%ajusto límites ejes
xlabel('n');ylabel('x[n]'); grid;

subplot(2,1,2);
plot(f,abs(X_f));
axis([-1/2 1/2 0 max(abs(X_f))]);%ajusto límites ejes
%f = frecuencia discreta, F = frecuencia continua,Fm = frecuencia muestreo
xlabel('f = F/Fm');ylabel('abs(X[f])');grid %Represento solo el módulo!!
