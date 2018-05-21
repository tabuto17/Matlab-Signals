% Christian Camilo Gaviria Castro - 1017229318
% Julian Castrillón García -
% Brahian Steven Cortés -

clc,clearvars,clear workspace, close all

Sujeto=('a. Christian Gaviria\nb. Julian Castrillón\nc. Brahian Cortés\n');
disp('Seleccione sujeto:')
fprintf(Sujeto)
subject=input(':','s');

switch subject
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
        
        Actividad=('a. Abrir boca\nb. Apretar dientes\nc. Tirar beso\n');
        disp('Seleccione actividad:')
        fprintf(Actividad)
        Gestos=input(':','s');
        
        switch Gestos
            case 'a'
                boca=(data(datastart(:,1):dataend(:,1)));
            case 'b'
                dientes=(data(datastart(:,2):dataend(:,2)));
            case 'c'
                beso=(data(datastart(:,3):dataend(:,3)));
        end
        
        Canal=('1. Fonendoscopio\n2. Cigomatica_R\n3. Cigomatica_L\n4. Orbicular_Sup\n5. Orbicular_Inf\n6. Suprahio_R\n7. Suprahio_L\n8. Infrahio_R\n9. Infrahio_L\n');
        disp('Seleccione canales:')
        fprintf(Canal)
        Channel=input(':');
        
end
