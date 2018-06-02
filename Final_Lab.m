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
    
    [num,den]=butter(5,[59 61]*2*pi,'stop','s'); %Rad/seg para que lo retorne al dominio de la transformada de laplace y de un filtro continuo
    [num,den]=bilinear(num,den,Fs);
    df1(i,:)=filter(num,den,Tarea(i,:));
    
    %%%%%%%%%%%%%%%%%%%_____FILTRO-PASABANDA_____%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [num,den]=butter(3,[25 500]*2*pi,'bandpass','s'); %compara sl stream que esta entre apostrofes
    [num,den]=bilinear(num,den,Fs);
    df2(i,:)=filter(num,den,df1(i,:)); %Filtro pasabanda al filtro notch
    
    %%%%%%%%%%%%%%%%%%%%%%%_____FOURIER_____%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Ln=length(df2(i,:));
    Zn=fft(df2(i,:));
    Magn=abs(Zn/Ln);
    Mag2n=Magn(2:Ln/2).^2; %vector tiempo
    fn=linspace(0,Fs/2,length(Mag2n));
    figure(3)
    set(gcf,'Name','Señales filtradas con su espectro de Fourier')
    subplot(3,1,i)
    plot(fn,Mag2n,'r')
    title(['Espectro de Fourier Señal filtrada: ',num2str(titles(Channel(i),:))])%(fila,columna)
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%_____MODULACION_____%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
%Remuestreamos la señal al doble
mod_1=resample(df2(1,:),2,1);
mod_2=resample(df2(2,:),2,1);
mod_3=resample(df2(3,:),2,1);

mod_sup1 = ssbmod(mod_1,Fp1,Fmu);
mod_sup2 = ssbmod(mod_2,Fp2,Fmu);
mod_sup3 = ssbmod(mod_3,Fp3,Fmu);

magblu1= abs(fft(mod_sup1));
magblu2= abs(fft(mod_sup2));
magblu3= abs(fft(mod_sup3));

fmod1=linspace(0,Fmu,length(magblu1));
fmod2=linspace(0,Fmu,length(magblu2));
fmod3=linspace(0,Fmu,length(magblu3));

figure(5)
subplot(3,1,1)
plot(fmod1,magblu1,'LineWidth',2.2) %Linewidth: Ancho de la linea :)
subplot(3,1,2)
plot(fmod2,magblu2,'LineWidth',2.2)
subplot(3,1,3)
plot(fmod3,magblu3,'LineWidth',2.2)

%%%FILTROS PASABANDA

[num,den]=butter(3,[100 575]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fmu);
sf1=filter(num,den,mod_sup1);

[num,den]=butter(3,[700 1175]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fmu);
sf2=filter(num,den,mod_sup2);

[num,den]=butter(3,[1300 1775]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fmu);
sf3=filter(num,den,mod_sup3);

recons=sf1+sf2+sf3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[num,den]=butter(3,[100 575]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fmu);
SF1=filter(num,den,recons);

[num,den]=butter(3,[700 1175]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fmu);
SF2=filter(num,den,recons);

[num,den]=butter(3,[1300 1775]*2*pi,'bandpass','s');
[num,den]=bilinear(num,den,Fmu);
SF3=filter(num,den,recons);

demod_1=resample(SF1,2,1);
demod_2=resample(SF2,2,1);
demod_3=resample(SF3,2,1);

demod_sup1 = ssbdemod(demod_1,Fp1,Fmu);
demod_sup2 = ssbdemod(demod_2,Fp2,Fmu);
demod_sup3 = ssbdemod(demod_3,Fp3,Fmu);

demagblu1= abs(fft(demod_sup1));
demagblu2= abs(fft(demod_sup2));
demagblu3= abs(fft(demod_sup3));

defmod1=linspace(0,Fmu,length(demagblu1));
defmod2=linspace(0,Fmu,length(demagblu2));
defmod3=linspace(0,Fmu,length(demagblu3));

figure(6)
subplot(3,1,1)
plot(defmod1,demagblu1,'LineWidth',2.2) %Linewidth: Ancho de la linea :)
subplot(3,1,2)
plot(defmod2,demagblu2,'LineWidth',2.2)
subplot(3,1,3)
plot(defmod3,demagblu3,'LineWidth',2.2)

