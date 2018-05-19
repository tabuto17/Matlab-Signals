% Christian Camilo Gaviria Castro - 
% Julian Castrillón García -
% Brahian Steven Cortés -

clc,clearvars,clear workspace, close all

a=('a. Christian Gaviria');
b=('b. Julian Castrillón');
c=('c. Brahian Cortés');
disp('Seleccione sujeto:')
disp(a)
disp(b)
disp(c)
S=input(':');

switch S
    case a %Christian Gaviria
        d=('d. Praxias');
        e=('e. Fonendoscopio');
        f=('f. Deglución');
        disp('Seleccione experimiento:')
        disp(d)
        disp(e)
        disp(f)
        E=input(':');
        
        switch E
            case d
                load('cristiangaviria-praxis.mat')
            case e
                load('cristiangaviria-fonendoscopio.mat')
            case f
                load('cristiangaviria-deglucion.mat')
        end
        
        g=('g. Abrir boca');
        h=('h. Apretar dientes');
        i=('i. Tirar beso');
        disp('Seleccione actividad:')
        disp(g)
        disp(h)
        disp(i)
        A=input(':');
        
        switch A
            case g
                boca=(data(datastart(:,1):dataend(:,1)));
            case h
                dientes=(data(datastart(:,2):dataend(:,2)));
            case i
                beso=(data(datastart(:,3):dataend(:,3)));
        end
        
%         aa=('1. Fonendoscopio');
%         bb=('2. Cigomatica_R');
%         cc=('3. Cigomatica_L');
%            ('4. Orbicular_Sup');
%            ('5. Orbicular_Inf');
%            ('6. Suprahio_R');
%            ('7. Suprahio_L');
%            ('8. Infrahio_R');
%            ('9. Infrahio_L');         
%         disp('Seleccione canales:')
%         A=input(':');
end
