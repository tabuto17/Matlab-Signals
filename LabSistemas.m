% Christian Camilo Gaviria Castro
% Julian Castrillón García
% Brahian Steven Cortés

clc,clearvars,clear workspace, close all

Sys=input('Seleccione la interconexión: paralelo (P) o cascada (S): ','s');
t=linspace(0,10);

switch Sys
    
    case {'P','p'}
        N=input('Ingrese la cantidad de subsistemas a analizar: ');
        Den=cell(N,1);
        Num=cell(N,1);
        Nums=cell(N,1);
        Dens=cell(N,1);
        Hs=cell(N,1);
        syms s %variable simbólica
        
        for i=1:N
            Num{i}=input(['Ingrese coeficientes del numerador del sistema ',num2str(i),' en forma de vector:']);
            Den{i}=input(['Ingrese coeficientes del denominador del sistema ',num2str(i),' en forma de vector:']);
            Nums{i}=poly2sym([Num{i}],s); %de vectorial a polinómica
            Dens{i}=poly2sym([Den{i}],s);
            Hs{i}=Nums{i}/Dens{i};
            disp(' ');
            disp(['Respuesta al impulso ', num2str(i),':'])
            ht=ilaplace(Hs{i})
        end
        
        f=0;
        for i=1:N
            f=f+Hs{i};
        end
        
        [numf,denf]=numden(f);
        numf=sym2poly(numf); %sobreescribir la variable en un vector.
        denf=sym2poly(denf);
        
        A=input('Ingrese el vector de entrada arbitraria: ');
        disp(' ');
        
        subplot(311)
        FT=tf(numf,denf);
        impulse(FT,t), grid on
        subplot(312)
        step(FT,t), grid on
        subplot(313)
        Co=conv(A,impulse(FT,t));
        t1=linspace(0,10,length(Co));
        plot(t1,Co), axis tight, grid on
        title 'Arbitrary Response'
        xlabel 'Time(seconds)', ylabel 'Amplitude'
        
        Pol=roots(denf);  Pol=round(Pol,4);
        R=real(Pol);      I=imag(Pol);
        RR=find(R>0);   II=find(I~=0);
        Re=R(RR);       Im=I(II);      U=unique(Pol);
        
        if length(Pol)>length(U)
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Inestable')
        elseif (Re>0)
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Inestable')
        elseif sum((R)==0)>=1;
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Marginalmente Estable')
        else
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Estable')
        end
        
    case {'S','s'}
        N=input('Ingrese la cantidad de subsistemas a examinar: ');
        Den=cell(N,1);
        Num=cell(N,1);
        Nums=cell(N,1);
        Dens=cell(N,1);
        Hs=cell(N,1);
        syms s
        
        for i=1:N
            Num{i}=input(['Ingrese coeficientes del numerador del sistema ',num2str(i),' en forma de vector:']);
            Den{i}=input(['Ingrese coeficientes del denominador del sistema ',num2str(i),' en forma de vector:']);
            Nums{i}=poly2sym([Num{i}],s);
            Dens{i}=poly2sym([Den{i}],s);
            Hs{i}=Nums{i}/Dens{i};
            disp(' ');
            disp(['Respuesta al impulso ', num2str(i),':'])
            ht=ilaplace(Hs{i})
        end
        
        Hs1=1;
        Hs2=1;
        
        for i=1:N
            Hs1=conv(Hs1,Num{i}); %convolución entre los vectores de entrada
            Hs2=conv(Hs2,Den{i});
        end
        
        B=input('Ingrese el vector de entrada arbitraria: ');
        disp(' ');
        
        FT=tf(Hs1,Hs2);
        subplot(311)
        impulse(FT,t), grid on
        subplot(312)
        step(FT,t), grid on
        subplot(313)
        Co=conv(B,impulse(FT,t));
        t1=linspace(0,10,length(Co));
        plot(t1,Co), axis tight, grid on
        title 'Arbitrary Response'
        xlabel 'Time(seconds)', ylabel 'Amplitude'
        
        Pol=pole(FT);  Pol=round(Pol,4);
        R=real(Pol);      I=imag(Pol);
        RR=find(R>0);   II=find(I~=0);
        Re=R(RR);       Im=I(II);      U=unique(Pol);
        
        if length(Pol)>length(U)
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Inestable')
        elseif (Re>0)
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Inestable')
        elseif sum((R)==0)>=1;
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Marginalmente Estable')
        else
            disp(['El Sistema Global : ', evalc('FT')])
            disp('Es Estable')
        end
        
    otherwise
        disp ('Sistema no identificado.')
end
