% Christian Camilo Gaviria Castro
% Julian Castrillón García
% Brahian Steven Cortés

clc,clearvars,clear workspace, close all

Sujeto=('a. Christian Gaviria\nb. Julian Castrillón\nc. Brahian Cortés\n');
disp('Seleccione sujeto:')
fprintf(Sujeto)
Usuario=input(':','s');

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

Actividad=('a. Abrir boca\nb. Apretar dientes\nc. Tirar beso\n');
disp('Seleccione actividad:')
fprintf(Actividad)
Tarea=input(':','s');

switch Tarea
    case 'a'
        ind=1;
    case 'b'
        ind=2;
    case 'c'
        ind=3;
end

Canal=('1. Fonendoscopio\n2. Cigomatica_R\n3. Cigomatica_L\n4. Orbicular_Sup\n5. Orbicular_Inf\n6. Suprahio_R\n7. Suprahio_L\n8. Infrahio_R\n9. Infrahio_L\n');
disp('Seleccione canales:')
fprintf(Canal)
Channel=input(':');

if ind==1
    for i=1:length(Channel)
        boca(i,:)=data(datastart(Channel(i),1):dataend(Channel(i),1));
    end
    
    subplot(311)
    plot(boca(1,:))
    title(['El canal utilizado es: ',num2str(Channel(1))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    subplot(312)
    plot(boca(2,:))
    title(['El canal utilizado es: ',num2str(Channel(2))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    subplot(313)
    plot(boca(3,:))
    title(['El canal utilizado es: ',num2str(Channel(3))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    
elseif ind==2
    for j=1:length(Channel)
        dientes(j,:)=data(datastart(Channel(j),2):dataend(Channel(j),2));
    end
    
    subplot(311)
    plot(dientes(1,:))
    title(['El canal utilizado es: ',num2str(Channel(1))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    subplot(312)
    plot(dientes(2,:))
    title(['El canal utilizad es: ',num2str(Channel(2))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    subplot(313)
    plot(dientes(3,:))
    title(['El canal utilizado es: ',num2str(Channel(3))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    
elseif ind==3
    for k=1:length(Channel)
        beso(k,:)=data(datastart(Channel(k),3):dataend(Channel(k),3));
    end
    
    subplot(311)
    plot(beso(1,:))
    title(['El canal utilizado es: ',num2str(Channel(1))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
    subplot(312)
    plot(beso(2,:))
    title(['El canal utilizado es: ',num2str(Channel(2))])
    xlabel 'Tiempo [s]', ylabel 'Ampli  tud [V]', axis tight, grid on
    subplot(313)
    plot(beso(3,:))
    title(['El canal utilizado es: ',num2str(Channel(3))])
    xlabel 'Tiempo [s]', ylabel 'Amplitud [V]', axis tight, grid on
end
