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
    [num,den]=butter(2,[55 69]*2*pi,'stop','s'); %Rad/seg para que lo retorne al dominio de la transformada de laplace y de un filtro continuo
    [num,den]=bilinear(num,den,Fs);
    Notch(i,:)=filter(num,den,Tarea(i,:));
    
    %Filtro Pasa Bandas
    [num,den]=butter(2,[25 500]*2*pi,'bandpass','s'); %'2' es el orden
    [num,den]=bilinear(num,den,Fs);
    PasaBandas(i,:)=filter(num,den,Notch(i,:)); %Filtro pasa bandas al filtro Notch.
    
    fourier=fft(PasaBandas(i,:));
    longitud=length(PasaBandas(i,:));
    magnitud=abs(fourier/longitud);
    dimension=magnitud(2:longitud/2).^2;
    f2=linspace(0,Fs/2,length(dimension));
    figure(3)
    set(gcf,'Name','Filtered signals with the Fourier spectrum.')
    subplot(3,1,i)
    plot(f2,dimension,'r')
    title(['Señal filtrada del canal: ',num2str(titles(Channel(i),:))])%(fila,columna)
end

%Modulación
