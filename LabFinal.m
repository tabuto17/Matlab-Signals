% Christian Camilo Gaviria Castro
% Julian Castrillón García
% Brahian Steven Cortés

clc,clearvars,clear workspace, close all

Sujeto=('a. Christian Gaviria\nb. Julian Castrillón\nc. Brahian Cortés\n');
disp('Seleccione sujeto:')
fprintf(Sujeto)
Usuario=input(':','s');
Fs=2000;

switch Usuario
    case 'a' %Christian Gaviria
        Experimento=('a. Praxias\nb. Fonendoscopio\nc. Deglución\n');
        disp('Seleccione experimiento:')
        fprintf(Experimento)
        Prueba=input(':','s');
        
        switch Prueba
            case 'a'
                load('cristiangaviria-praxis.mat')
            case 'b'
                load('cristiangaviria-fonendoscopio.mat')
            case 'c'
                load('cristiangaviria-deglucion.mat')
        end
        
    case 'b' %Julián Castrillón
        Experimento=('a. Praxias\nb. Fonendoscopio\nc. Deglución\n');
        disp('Seleccione experimiento:')
        fprintf(Experimento)
        Prueba=input(':','s');
        
        switch Prueba
            case 'a'
                load('juliancastrillon-praxis.mat')
            case 'b'
                load('juliancastrillon-fonendoscopio.mat')
            case 'c'
                load('juliancastrillon-deglucion.mat')
        end
        
    case 'c' %Brahian Cortés
        Experimento=('a. Praxias\nb. Fonendoscopio\nc. Deglución\n');
        disp('Seleccione experimiento:')
        fprintf(Experimento)
        Prueba=input(':','s');
        
        switch Prueba
            case 'a'
                load('brahiancortes-praxis.mat')
            case 'b'
                load('brahiancortes-fonendoscopio.mat')
            case 'c'
                load('brahiancortes-deglucion.mat')
        end
end

if Prueba=='a' %Praxias
    Actividad=('a. Abrir boca\nb. Apretar dientes\nc. Tirar beso\n');
    disp('Seleccione actividad:')
    fprintf(Actividad)
    Accion=input(':','s');
    
    switch Accion
        case 'a'
            ind=1; %indicador
        case 'b'
            ind=2;
        case 'c'
            ind=3;
    end
    
    Canal=('1. Pulsador\n2. Cigomatica_R\n3. Cigomatica_L\n4. Orbicular_Sup\n5. Orbicular_Inf\n6. Suprahio_R\n7. Suprahio_L\n8. Infrahio_R\n9. Infrahio_L\n');
    disp('Seleccione canales:')
    fprintf(Canal)
    Channel=input(':');
    
elseif Prueba=='b' %Fonendoscopio
    
    Actividad=('a. Yogur 3 mL\nb. Yogur 7 mL\nc. Saliva\n');
    disp('Seleccione actividad:')
    fprintf(Actividad)
    Accion=input(':','s');
    
    switch Accion
        case 'a'
            ind=1; %indicador
        case 'b'
            ind=2;
        case 'c'
            ind=3;
    end
    
    Canal=('1. Fonendoscopio\n2. Cigomatica_R\n3. Cigomatica_L\n4. Orbicular_Sup\n5. Orbicular_Inf\n6. Suprahio_R\n7. Suprahio_L\n8. Infrahio_R\n');
    disp('Seleccione canales:')
    fprintf(Canal)
    Channel=input(':');
    
elseif Prueba=='c' %Deglución
    
    Actividad=('a. Agua 5 mL\nb. Agua 10 mL\nc. Agua 20 mL\nd. Saliva\ne. Yogur 3 mL\nf. Yogur 5 mL\ng. Yogur 7 mL\nh. Yogur 10 mL\ni. Yogur 20 mL\nj. Galleta\n');
    disp('Seleccione actividad:')
    fprintf(Actividad)
    Accion=input(':','s');
    
    switch Accion
        case 'a'
            ind=1; %indicador
        case 'b'
            ind=2;
        case 'c'
            ind=3;
        case 'd'
            ind=4;
        case 'e'
            ind=5;
        case 'f'
            ind=6;
        case 'g'
            ind=7;
        case 'h'
            ind=8;
        case 'i'
            ind=9;
        case 'j'
            ind=10;
    end
    Canal=('1. Cigomatica_R\n2. Cigomatica_L\n3. Orbicular_Sup\n4. Orbicular_Inf\n5. Suprahio_R\n6. Suprahio_L\n7. Infrahio_R\n8. Infrahio_L\n');
    disp('Seleccione canales:')
    fprintf(Canal)
    Channel=input(':');
end

for i=1:length(Channel)
    if Prueba=='b' && Channel(i)==1
        Div=data(datastart(Channel(i),ind):dataend(Channel(i),ind));
        Div=resample(Div,1,2);
        Tarea(i,:)=Div;
    else
        Tarea(i,:)=data(datastart(Channel(i),ind):dataend(Channel(i),ind));%Tarea(columna,fila)
    end
    
    t=0:1/Fs:length(Tarea(i,:))/Fs-1/Fs;
    figure(1);
    set(gcf,'Name','Signals in time domain.')
    subplot(3,1,i)
    plot(t,Tarea(i,:),'k')
    title(['El canal utilizado es: ',num2str(titles(Channel(i),:))])%(fila,columna)
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    
    Fourier=fft(Tarea(i,:));
    Longitud=length(Tarea(i,:)); %Se almacena toda longitud de la señal en una nueva variable
    Magnitud=abs(Fourier/Longitud);
    Dimension=Magnitud(2:Longitud/2).^2; %Es necesario elevarlo al cuadrado por FFT
    f1=linspace(0,Fs/2,length(Dimension));
    figure(2);
    set(gcf,'Name','Signals in frequency domain.')
    subplot(3,1,i)
    plot(f1,Dimension,'b')
    title(['El canal utilizado es: ',num2str(titles(Channel(i),:))])
    xlabel 'Frecuencia [Hz]', ylabel 'Amplitud [dB]', axis tight, grid on
    
    %Filtro Notch
    [num,den]=butter(5,[55 69]*2*pi,'stop','s'); %Rad/seg para que lo retorne al dominio de la transformada de laplace, filtro rechaza bandas
    [num,den]=bilinear(num,den,Fs);
    Notch(i,:)=filter(num,den,Tarea(i,:));
    
    %Filtro Pasa Bandas
    [num,den]=butter(5,[25 500]*2*pi,'bandpass','s'); %'2' es el orden
    [num,den]=bilinear(num,den,Fs);
    PasaBandas(i,:)=filter(num,den,Notch(i,:)); %Filtro pasa bandas al filtro Notch.
    
    fourier=fft(PasaBandas(i,:));
    longitud=length(PasaBandas(i,:));
    magnitud=abs(fourier/longitud);
    dimension=magnitud(2:longitud/2).^2;
    f2=linspace(0,Fs/2,length(dimension));
    figure(3)
    set(gcf,'Name','Filtered signals in Fourier Spectrum.')
    subplot(3,1,i)
    plot(f2,dimension,'r')
    title(['Señal filtrada del canal: ',num2str(titles(Channel(i),:))])
    xlabel 'Frecuencia [Hz]', ylabel 'Amplitud [dB]', axis tight, grid on
end

%Modulación
Fm=Fs*3; %Frecuencia de muestreo 6kHz
Fp1=600; %Frecuencia de portadora sn1
Fp2=1200; %Frecuencia de portadora sn2
Fp3=1800; %Frecuencia de portadora sn3

%Remuestreo de la señal al triple (6000)
Modu1=resample(PasaBandas(i,:),3,1);
Modu2=resample(PasaBandas(i,:),3,1);
Modu3=resample(PasaBandas(i,:),3,1);

%Modulación BLU-BLI
Blue1=ssbmod(Modu1,Fp1,Fm);
Blue2=ssbmod(Modu2,Fp2,Fm);
Blue3=ssbmod(Modu3,Fp3,Fm);

MagnitudBlu1=abs(fft(Blue1));
MagnitudBlu2=abs(fft(Blue2));
MagnitudBlu3=abs(fft(Blue3));
fmod1=linspace(0,Fm,length(MagnitudBlu1));
fmod2=linspace(0,Fm,length(MagnitudBlu2));
fmod3=linspace(0,Fm,length(MagnitudBlu3));
figure(4)
set(gcf,'Name','Single Sideband Amplitude Modulation in Fourier Spectrum.')
subplot(3,1,1)
plot(fmod1,MagnitudBlu1,'LineWidth',1.9) %Linewidth: Ancho de la linea
title(['Señal modulada del canal: ',num2str(titles(Channel(i),:))])
xlabel 'Frecuencia [Hz]', ylabel 'Amplitud [dB]', axis tight, grid on
subplot(3,1,2)
plot(fmod2,MagnitudBlu2,'LineWidth',1.9)
title(['Señal modulada del canal: ',num2str(titles(Channel(i),:))])
xlabel 'Frecuencia [Hz]', ylabel 'Amplitud [dB]', axis tight, grid on
subplot(3,1,3)
plot(fmod3,MagnitudBlu3,'LineWidth',1.9)
title(['Señal modulada del canal: ',num2str(titles(Channel(i),:))])
xlabel 'Frecuencia [Hz]', ylabel 'Amplitud [dB]', axis tight, grid on

%Filtro Pasa Bandas
[num,den]=butter(2,[100 575]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fm);
BPF1=filter(num,den,Blue1);

[num,den]=butter(2,[700 1175]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fm);
BPF2=filter(num,den,Blue2);

[num,den]=butter(2,[1300 1775]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fm);
BPF3=filter(num,den,Blue3);

%Multiplexación
SM=BPF1+BPF2+BPF3; % SM = Señal Multiplexada
FourierM=fft(SM);
LongitudM=length(SM);
MagnitudM=abs(FourierM/LongitudM);
DimensionM=MagnitudM(2:LongitudM/2).^2;
f3=linspace(0,Fm,length(DimensionM));
figure(5)
set(gcf,'Name','Fourier Spectrum of the modulated signal')
plot(f3,DimensionM,'m')
title('Espectro de Fourier de la señal modulada')
xlabel 'Frecuencia [Hz]', ylabel 'Amplitud [dB]', axis tight, grid on

%Reconstrucción%

%Filtro Pasa Bandas
[num,den]=butter(2,[100 575]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fm);
bpf1=filter(num,den,SM);

[num,den]=butter(2,[700 1175]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fm);
bpf2=filter(num,den,SM);

[num,den]=butter(2,[1300 1775]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fm);
bpf3=filter(num,den,SM);

%Filtro Pasa Bandas para eliminar la portadora
[num,den]=butter(2,Fp1*2*pi,'low','s');
[num,den]=bilinear(num,den,Fm);
BPFC1=filter(num,den,bpf1); %BPFP1 = BandPass Filter Carrier 1

[num,den]=butter(2,Fp2*2*pi,'low','s');
[num,den]=bilinear(num,den,Fm);
BPFC2=filter(num,den,bpf2);

[num,den]=butter(2,Fp3*2*pi,'low','s');
[num,den]=bilinear(num,den,Fm);
BPFC3=filter(num,den,bpf3);
