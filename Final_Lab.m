% Christian Camilo Gaviria Castro
% Julian Castrillón García
% Brahian Steven Cortés

clc,clearvars,clear workspace, close all

Sujeto=('a. Christian Gaviria\nb. Julian Castrillón\nc. Brahian Cortés\n');
disp('Seleccione sujeto:')
fprintf(Sujeto)
Usuario=input(':','s');
Fs=2000;
Ts=1/Fs;
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
    Ocupacion=input(':','s');
    
    switch Ocupacion
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
    Ocupacion=input(':','s');
    
    switch Ocupacion
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
    Ocupacion=input(':','s');
    
    switch Ocupacion
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
    if Prueba=='b'
        if Channel(i)==1
            Div=data(datastart(Channel(i),ind):dataend(Channel(i),ind));
            Div=resample(Div,1,2);
            Tarea(i,:)=Div;
        else
            Tarea(i,:)=data(datastart(Channel(i),ind):dataend(Channel(i),ind));
        end
    else
            Tarea(i,:)=data(datastart(Channel(i),ind):dataend(Channel(i),ind)); %Posición y selección de canales
  
    end
    
%%%%%%%%%%%%%%%%%%%%%_____SEÑAL-ORIGINAL_____%%%%%%%%%%%%%%%%%%%%%%%%%%%

    t=0:1/Fs:length(Tarea(i,:))/Fs-Ts;
    figure(1)
    set(gcf,'Name','Señales en el dominio del tiempo') 
    subplot(3,1,i)
    plot(t,Tarea(i,:),'k')
    title(['El canal utilizado es: ',num2str(titles(Channel(i),:))])%(fila,columna)
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on

%%%%%%%%%%%%%%%%%%%%%%%%_____FOURIER_____%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L=length(Tarea(i,:)); %Longitud de la señal
Z=fft(Tarea(i,:));
Mag=abs (Z/L);
Mag2=Mag(2:L/2).^2;
f=linspace(0,Fs/2,length(Mag2));
figure(2)
set(gcf,'Name','Señales con su espectro de Fourier') 
subplot(3,1,i)
plot(f,Mag2,'b')
title(['Espectro original de Fourier Señal: ',num2str(titles(Channel(i),:))])%(fila,columna)


%%%%%%%%%%%%%%%%%%%%%_____FILTRO-NOTCH_____%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[num,den]=butter(5,[59 61]*2*pi,'stop','s'); %Rad/seg
[num,den]=bilinear(num,den,Fs);
df1=filter(num,den,Tarea(i,:));

%%%%%%%%%%%%%%%%%%%_____FILTRO-PASABANDA_____%%%%%%%%%%%%%%%%%%%%%%%%%%

[num,den]=butter(5,[25 500]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fs);
df2=filter(num,den,df1); %Filtro pasabanda al filtro notch

%%%%%%%%%%%%%%%%%%%%%%%_____FOURIER_____%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ln=length(df2); 
Zn=fft(df2);
Magn=abs(Zn/Ln);
Mag2n=Magn(2:Ln/2).^2;
fn=linspace(0,Fs/2,length(Mag2n));
figure(3)
set(gcf,'Name','Señales filtradas con su espectro de Fourier') 
subplot(3,1,i)
plot(fn,Mag2n,'r')
title(['Espectro de Fourier Señal filtrada: ',num2str(titles(Channel(i),:))])%(fila,columna)

%%%%%%%%%%%%%%%%%%%%%%%_____MODULACION_____%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fmu=4000; %Frecuencia muestreo 4kHz
Fp1=1200; %Frecuencia portadora sn1
Fp2=1500; %Frecuencia portadora sn2
Fp3=800;  %Frecuencia portadora sn3

%tomar en cuenta que solo debemos tomar una banda BLU
mod1 = ssbmod(Tarea(i,:),Fp1,Fmu,0); % modulacion banda inferior
mod2 = ssbmod(Tarea(i,:),Fp1,Fmu,0,'upper'); % Modulacion Banda Superior

mag=abs(fft(mod1));
figure(4)
subplot(3,1,i)
plot(t,mod1,'r-',t,mod2,'k--');
grid
title('Señal Modulada en SSB')
legend('Modulación Banda Superior','Modulación Banda Inferior')

magblu1=abs(fft(mod1));
figure(5)
subplot(3,1,i)
plot(t,magblu1,'LineWidth',2.2)


magblu2=abs(fft(mod2));
figure(6)
subplot(3,1,i)
plot(t,magblu2,'LineWidth',2.2)

end

