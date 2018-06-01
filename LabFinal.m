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
    
    t=0:1/Fs:length(Tarea(i,:))/Fs-1/Fs;
    subplot(3,1,i)
    plot(t,Tarea(i,:))
    title(['El canal utilizado es: ',num2str(titles(Channel(i),:))])%(fila,columna)
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
end
