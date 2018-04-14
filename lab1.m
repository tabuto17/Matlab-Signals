% Christian Camilo Gaviria Castro - C.C.
% Julian Castrillón García - C.C.
% Brahian Steven Cortés - C.C.

clc,clearvars,clear workspace, close all

system=input('Seleccione la interconexión: paralelo (P) o cascada (S): ','s');
t=linspace(0,10); %si se deben definir los saltos ?

switch system
    
    case {'P','p'}
        Sys=input('Ingrese la cantidad de subsistemas a analizar: ');
        Den=cell(Sys,1);
        Num=cell(Sys,1);
        Nums=cell(Sys,1);
        Dens=cell(Sys,1);
        Hs=cell(Sys,1);
        syms x(s) y(s) % variables simbólicas
        
        for W=1:Sys;
            Num{W}=input(['Ingrese coeficientes del numerador del sistema ',num2str(W),' en forma de vector:']);
            Den{W}=input(['Ingrese coeficientes del denominador del sistema ',num2str(W),' en forma de vector:']);
            Nums{W}=poly2sym([Num{W}],s);
            Dens{W}=poly2sym([Den{W}],s);
            Hs{W}=Nums{W}/Dens{W};
            disp(['Esta es la respuesta al impulso ', num2str(W),':'])
            ht=ilaplace(Hs{W})
            %pretty(ht)
        end
        
        Tfun=0;
        for W=1:Sys
            Tfun=Tfun+Hs{W};
        end
        disp('Sistema de transferencia total: ')
        Tfun
        
        [numTfun,denTfun]=numden(Tfun);
        numTfun=sym2poly(numTfun);
        denTfun=sym2poly(denTfun);
        
        A=input('Ingrese el vector de entrada arbitraria: ');
        
        subplot(311)
        Tfun=tf(numTfun,denTfun); %transfer
        R=impulse(Tfun,t);
        plot(t,R)
        subplot(312)
        Res=step(Tfun,t);
        plot(t,Res)
        subplot(313)
        Ans=conv(A,R);
        t1=linspace(0,10,length(Ans));
        plot(t1,Ans)
        
        
    case {'S','s'}
        Sys=input('Ingrese la cantidad de subsistemas a examinar: ');
        Den=cell(Sys,1);
        Num=cell(Sys,1);
        Nums=cell(Sys,1);
        Dens=cell(Sys,1);
        Hs=cell(Sys,1);
        syms x(s) y(s)
        
        for W=1:Sys;
            Num{W}=input(['Ingrese coeficientes del numerador del sistema ',num2str(W),' en forma de vector:']);
            Den{W}=input(['Ingrese coeficientes del denominador del sistema ',num2str(W),' en forma de vector:']);
            Nums{W}=poly2sym([Num{W}],s);
            Dens{W}=poly2sym([Den{W}],s);
            N=Num{W};
            D=Den{W};
            Hs{W}=Nums{W}/Dens{W};
            nu=Num{W};
            
            disp(['Esta es la respuesta al impulso ', num2str(W),':'])
            ht=ilaplace(Hs{W})
        end
        
        HS1=1;
        for W=1:Sys;
            HS1=conv(HS1,Num{W});
        end
        
        HS2=1;
        for W=1:Sys;
            HS2=conv(HS2,Den{W});
        end
        
        A=input('Ingrese el vector de entrada arbitraria: ');
        
        subplot(311)
        km=tf(HS1,HS2)
        R=impulse(km,t);
        plot(t,R)
        %         subplot(312)
        %         Res=step(Tfun,t);
        %         plot(t,Res)
        %         subplot(313)
        %         Ans=conv(A,R);
        %         t1=linspace(0,10,length(Ans));
        %         plot(t1,Ans)
        
    otherwise
        disp ('Sistema no identificado')
end
