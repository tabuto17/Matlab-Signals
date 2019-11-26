clc; clear all; close all;
%% 1. a. SELECCIÓN - REPRODUCCIÓN
input('Presione enter: Elija el audio del integrante sin música de fondo: ')
[filename,filepath]=uigetfile({'*.mp3'},'Elija el audio del integrante sin musica de fondo');
fullname=[filepath,filename];
[audio,Fs_2] = audioread(fullname);
fil_sound1 = audioplayer(audio,Fs_2);
play(fil_sound1)

input('Presione enter: Seleccione el audio con música de fondo ')
[FileName, PathName] = uigetfile('*.mp3');
[y,Fs]=audioread([PathName,FileName]);

%% 1. b. DISEÑO
Fn = Fs/2; % Frecuencia Nyquist
M = 60; % Orden del filtro
n = 5; a=1;
y = y(:,1); 
Fp = [100 800];
Wp = Fp./Fn;
Wn = 2*pi*Fp; %Para IIR

filtro=input('1.(Filtro FIR), 2.(Filtro IIR): ');
switch filtro
    case 1
        metodo=input('1.(Enventanado), 2.(Muestreo en frecuencia), 3.(Parks-McClellan): ');
        switch metodo
            case 1 
                b = fir1(M,Wp); 
                y_2 = filter(b,1,y);
            case 2 
                b = fir2(M,[0 Wp 1],[1 1 0 0]);%Pasa altas
                y_2 = filter(b,1,y);
            case 3  
                b = firpm(M,[0 Wp 1],[0 1 1 0]);%Pasa bandas
                y_2 = filter(b,1,y);
        end
    case 2
        topologia = input('1.(Butter), 2.(Cheb I), 3.(Cheb II), 4.(Elip): ');        
        switch topologia
            case 1 
                [num,den]=butter(n,Wn, 'stop');
            case 2
                Rp=.5;
                [num,den]=cheby1(n,Rp,Wn,'s');
            case 3
                Rs=60;
                [num,den]=cheby2(n,Rs,Wn,'s');
            case 4
                Rp=.5; Rs=60;
                [num,den]=ellip(n,Rp,Rs,Wn,'s');
        end
        
        metodo=input('1.(Invarianza del impulso) ó 2.(Transformacion bilineal): ');
        switch metodo
            case 1  
                [b,a] = impinvar(num,den,Fs);
                y_2=filter(b,a,y);
            case 2
                [b,a] = bilinear(num,den,Fs);
                y_2=filter(b,a,y);
        end
end

%% 2. RESPUESTA EN FRECUENCIA
[Hw,w]=freqz(b,a);
figure('Name','Respuesta en Frecuencia del Filtro');
subplot(211);
plot(w,20*log10(abs(Hw)));
xlabel '\omega [rad]', ylabel '|H(\omega)[dB]|', title 'Rta en frec. de magnitud', grid on
subplot(212),plot(w,Hw);
xlabel '\omega [rad]', ylabel '\angleH(\omega)|', title 'Rta en frec. de fase', grid on
%% 3. RESPUESTA AL IMPULSO
figure('Name','Respuesta al Impulso');
impz(b,a,[],Fs),title('Respuesta al impulso'),xlabel('Muestras'), ylabel('Amplitud')
%% 4. SEÑAL DE AUDIO
t = linspace(0,length(y),length(y)); 
t_f = linspace(0,length(y_2),length(y_2));
figure('Name','Señal de audio')

subplot(211), plot(t,y) ,xlabel 't [seg]',...
        ylabel 'Amplitud', title 'Audio sin filtrar en el dom del Tiempo'
subplot(212), plot(t_f,y_2,'r'), grid on,...
        title 'Audio filtrado en el dom del Tiempo', xlabel ' Tiempo [s]', ylabel 'Amplitud'

%% 5. DENSIDAD ESPECTRAL DE POTENCIA (PSD)
figure('Name','Densidad espectral de potencia (PSD)');       
%PSD SIN FILTRAR
N = length(y);
xdft = fft(y); xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
t = size(y,1)/Fs; x_x = 0:1/Fs:t;
freq = 0:Fs/length(x_x):Fs/2;
subplot(211), plot(freq,10*log10(psdx)), grid on,...
    title('Densidad espectral de potencia - Original'), xlabel('Frecuencia(Hz)'), ylabel('Potencia(dB/Hz)')
%PSD SEÑAL FILTRADA
N_f = length(y_2);
xdft_f = fft(y_2); xdft_f = xdft_f(1:N/2+1);
psdx_f = (1/(Fs*N)) * abs(xdft_f).^2;
psdx_f(2:end-1) = 2*psdx_f(2:end-1);
t_f = size(y_2,1)/Fs; x_x_f = 0:1/Fs:t_f;
freq = 0:Fs/length(x_x_f):Fs/2;
subplot(212), plot(freq,10*log10(psdx_f), 'r'), grid on,...
    title('Densidad espectral de potencia - Filtrada'), xlabel('Frecuencia(Hz)'), ylabel('Potencia(dB/Hz)')

%% Reproducir audio filtrado
 fil_sound2 = audioplayer(y_2,Fs);
 play(fil_sound2)
