% Christian Camilo Gaviria Castro - C.C. 1017229318
% Julian Castrillón García - C.C. 1216719761
% Brahian Steven Cortés - C.C. 1020440471

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
            disp(['Esta es la respuesta al impulso ', num2str(i),':'])
            ht=ilaplace(Hs{i})
        end
        
        f=0;
        for i=1:N
            f=f+Hs{i};
        end
        
        [numf,denf]=numden(f);
        numf=sym2poly(numf); %sobreescribir en un vector.
        denf=sym2poly(denf);
        
        A=input('Ingrese el vector de entrada arbitraria: ');
        
        subplot(311)
        Tf=tf(numf,denf);
        xlabel 'Armónico',ylabel 'tiempo'
        title 'Respuesta al impulsos'
        Im=impulse(Tf,t);
        plot(t,Im)
        grid on
        subplot(312)
        St=step(Tf,t);
        plot(t,St)
        grid on
        subplot(313)
        Co=conv(A,Im);
        t1=linspace(0,10,length(Co));
        plot(t1,Co)
        grid on
        
        Poc=roots(denf);
        R=real(Poc);            I=imag(Poc);
        RR=find(R>0);         II=find(I~=0);
        Re=R(RR);               Im=I(II);        U=unique(Im);
        
        if isempty(R) && isempty(I)
            disp('Error en el sistema ingresado, Ingrese nuevamente')
        elseif (Re>0)
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
            %             N=Num{n};
            %             D=Den{n};
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
        Im=impulse(f,t);
        subplot(311)
        plot(t,Im)
        subplot(312)
        St=step(f,t);
        plot(t,St)
        subplot(313)
        Co=conv(B,Im);
        t1=linspace(0,10,length(Co));
        plot(t1,Co)
        
        Poc=pole(f);
        R=real(Poc);            I=imag(Poc);
        RR=find(R>0);         II=find(I~=0);
        Re=R(RR);               Im=I(II);        U=unique(Im);
        
        if isempty(R) && isempty(I)
            disp('Error en el sistema ingresado, Ingrese nuevamente')
        elseif (Re>0)
            disp('Sistema Inestable')
        elseif I==0 %cuando no hay imaginarios.
            disp('Sistema Estable')
        else sum(U)==0 %sumatoria de imaginarios repetidos.
            disp('Sistema Marginalmente Estable')
        end
        
    otherwise
        disp ('Sistema no identificado.')
end
