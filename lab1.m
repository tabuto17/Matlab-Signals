% Christian Camilo Gaviria Castro
% Julian Castrillón García
% Brahian Steven Cortés

clc,clear vars,clear workspace, close all

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
            disp(['Esta es la respuesta al impulso ', num2str(i),':'])
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
        
        subplot(311)
        Tf=tf(numf,denf);
        impulse(Tf,t), grid on
        subplot(312)
        step(Tf,t), grid on
        subplot(313)
        Co=conv(A,impulse(Tf,t));
        t1=linspace(0,10,length(Co));
        plot(t1,Co), axis tight, grid on
        title 'Arbitrary Response'
        xlabel 'Time(seconds)', ylabel 'Amplitude'
        
        P=roots(denf);
        R=real(P);      I=imag(P);
        RR=find(R>0);   II=find(I~=0);
        Re=R(RR);       Im=I(II);      U=unique(Im);
        
        if (Re>0)
            disp('Sistema Inestable')
        elseif I==0 %cuando no hay imaginarios.
            disp('Sistema Estable')
        else sum(U)==0 %sumatoria de imaginarios repetidos.
            disp('Sistema Marginalmente Estable')
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
            disp(['Esta es la respuesta al impulso ', num2str(i),':'])
            ht=ilaplace(Hs{i})
        end
        
        Hs1=1;
        Hs2=1;
        
        for i=1:N
            Hs1=conv(Hs1,Num{i}); %convolución entre los vectores de entrada
            Hs2=conv(Hs2,Den{i});
        end
        
        B=input('Ingrese el vector de entrada arbitraria: ');
        
        f=tf(Hs1,Hs2);
        subplot(311)
        impulse(f,t), grid on
        subplot(312)
        step(f,t), grid on
        subplot(313)
        Co=conv(B,impulse(f,t));
        t1=linspace(0,10,length(Co));
        plot(t1,Co), axis tight, grid on
        title 'Arbitrary Response'
        xlabel 'Time(seconds)', ylabel 'Amplitude'
        
        P=pole(f);
        R=real(P);      I=imag(P);
        RR=find(R>0);   II=find(I~=0);
        Re=R(RR);       Im=I(II);       U=unique(Im);
        
        if (Re>0)
            disp('Sistema Inestable')
        elseif I==0 %cuando no hay imaginarios.
            disp('Sistema Estable')
        else sum(U)==0 %sumatoria de imaginarios repetidos.
            disp('Sistema Marginalmente Estable')
        end
        
    otherwise
        disp ('Sistema no identificado.')
end
