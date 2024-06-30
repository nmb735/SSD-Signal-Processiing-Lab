%% PRACTICA 3
%% Exercici 1
% Sea una sinusoide de frecuencia 2 kHz y duración 4 ms. Represente
%(utilizando en el eje de abscisas la variable nT) las secuencias obtenidas al
%muestrear a 32 kHz y a 8 kHz. ¿Qué se puede decir respecto al número de
%muestras y el nivel de detalles de cada secuencia?

f = 2E+3;

t = 4E-3;

w = 2 * pi * f;

f1 = 32E+3;

f2 = 8E+3;

nT1 = [0:1/f1:t];
nT2 = [0:1/f2:t];

x1 = sin(w*nT1);
x2 = sin(w*nT2);

subplot(2,1,1);
stem(nT1,x1);

subplot(2,1,2);
stem(nT2,x2);

%% Exercici 2
% Represente 6 ms de una sinusoide de 4 kHz muestreada a 16 kHz. Haga lo
%mismo con 6 ms de una sinusoide de 12 kHz. ¿Qué sucede? ¿Qué se debe
%hacer para evitar que haya confusión entre las dos secuencias?

f = 16E+3;

t = 6E-3;

f1 = 4E+3;

f2 = 12E+3;

nT = [0:1/f:t];

x1 = sin(2*pi*f1*nT);
x2 = sin(2*pi*f2*nT);

subplot(2,1,1);
stem(nT,x1);

subplot(2,1,2);
stem(nT,x2);

%% Exercici 3
% P3. Sea una sinusoide continua de frecuencia fa1 = 1.5 kHz que representaremos en un intervalo de 4 ms. Como MATLAB representa señales discretas, aproximaremos la señal continua muestreando a una frecuencia mucho mayor que la requerida, por ejemplo, 80 kHz. La señal discreta se obtendrá muestreando la sinusoide a fs = 8 kHz. Después del procesado (no haremos nada) emplearemos un ZOH (pulsos rectangulares) para la conversión D/C. Para suavizar la señal pasaremos la señal por un filtro de orden 4 y frecuencia de corte fc = 3 kHz. Todo esto se especifica de la siguiente forma:
cd_dc(4e-3,80e3,1.5e3,0,8e3,'rectpuls',4,3e3);
hold on;
cd_dc(4e-3,80e3,1.5e3,0,8e3,'rectpuls',4,1.5e3);
hold on;
cd_dc(4e-3,80e3,1.5e3,0,8e3,'rectpuls',4,8e3);
hold on;
cd_dc(4e-3,80e3,1.5e3,0,8e3,'rectpuls',4,0.69e3);

%% Exercici 4
% Ahora introduciremos la suma de dos sinusoides fa1 = 1.5 kHz y fa2 = 6.5 kHz, manteniendo fs = 8 kHz y un filtro de orden 4 con fc = 3 kHz. ¿Qué ha sucedido con la señal a la salida del convertidor D/A? Muestree las dos señales por separado para entender lo sucedido. ¿Qué cambios haría en el proceso de muestreo y reconstrucción para recuperar perfectamente la señal original? Muestre un resultado concreto.
Tf = 4E-3;
fo = 8E+3;
f1 = 1.5E+3;
f2 = 6.5E+3;
N = 4;
fc = 3.0E+3;

cd_dc(Tf,80E+3,f1,f2,fo,'rectpuls',N,fc);
hold on;
cd_dc(Tf,80E+3,f1,0,fo,'rectpuls',N,fc);
hold on;
cd_dc(Tf,80E+3,f2,0,fo,'rectpuls',N,fc);

%% Exercici 5
% Tome la señal muestreada a 8 kHz y, utilizando “:” de MATLAB, diézmela por factores 2, 4 y 8. Reproduzca las tres nuevas señales generadas con su nueva frecuencia de muestreo y analice su calidad. Visualice las nuevas señales en tiempo y en frecuencia. Explique el proceso de degradación que va sufriendo a medida que aumenta el diezmado usando el dominio temporal y frecuencial
fm = 8E+3;
D1 = 2;
D2 = 4;
D3 = 8;

d1 = vector_samples_8k(1:D1:end);
d2 = vector_samples_8k(1:D2:end);
d3 = vector_samples_8k(1:D3:end);

rep_tyf(vector_samples_8k);
hold on;
rep_tyf(d1);
hold on;
rep_tyf(d2);
hold on;
rep_tyf(d3);

audiowrite('original.wav', vector_samples_8k, 8E+3);
audiowrite('diezmado2.wav', d1, 8E+3/D1);
audiowrite('diezmado4.wav', d2, 8E+3/D2);
audiowrite('diezmado8.wav', d3, 8E+3/D3);

%% Exercici 6
I1 = 2;
I2 = 4;
 

i1 = interp(vector_samples_8k,I1);
i2 = interp(vector_samples_8k,I2);

i3 = zeros(length(vector_samples_8k)*I1,1);
i3(1:I1:end) = vector_samples_8k;

i4 = zeros(length(vector_samples_8k)*I2,1);
i4(1:I2:end) = vector_samples_8k;

%i3 = interp(i3, 1);
%i4 = interp(i4, 1);

audiowrite('interpolacio2.wav', i1, I1 * 8E+3);
audiowrite('interpolacio4.wav', i2, I2 * 8E+3);
rep_tyf(i1);
rep_tyf(i2);

audiowrite('interpolacio5.wav', i3, I1 * 8E+3);
audiowrite('interpolacio6.wav', i4, I2 * 8E+3);
rep_tyf(i3);
rep_tyf(i4);

%% Exercici 7
% A partir de la señal muestreada a 8 kHz, relacione los procesos de diezmado
%e interpolación con los de aceleración y ralentización de la voz. Represente
%las señales en los dominios temporal y frecuencial para comprobar que se
%ha conseguido el efecto y explique por qué las señales se oyen más agudas o
%graves.
f = 8E+3;

d2 = vector_samples_8k(1:4:end);
audiowrite('diezmadoEx7.wav', d2, f);

i = interp(vector_samples_8k,4);
audiowrite('interpolacionEx7.wav', i, f);

rep_tyf(vector_samples_8k);
hold on;
rep_tyf(d2);
hold on;
rep_tyf(i);

%% Exercici 8 
I = 5;
D = 2;

x = interp(vector_samples_8k, I);
x = x(1:D:end);

y = interp(vector_samples_8k, D);
y = x(1:I:end);

rep_tyf(vector_samples_8k);
hold on;
rep_tyf(x);
hold on;
rep_tyf(y);

audiowrite('retrasat.wav', x, 8E+3);
audiowrite('accelerat.wav', y, 8E+3);



