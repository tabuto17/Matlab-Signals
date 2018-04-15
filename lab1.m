clc,clearvars,clear workspace, close all

system=input('Seleccione la interconexión: paralelo (P) o cascada (S): ','s');
t=linspace(0,10);

switch system
    
    case {'P','p'}
        Sys=input('Ingrese la cantidad de subsistemas a analizar: ');
        Den=cell(Sys,1);
        Num=cell(Sys,1);
        Nums=cell(Sys,1);
        Dens=cell(Sys,1);
        Hs=cell(Sys,1);
        syms s % variables simbólicas
        
        for W=1:Sys
            Num{W}=input(['Ingrese coeficientes del numerador del sistema ',num2str(W),' en forma de vector:']);
            Den{W}=input(['Ingrese coeficientes del denominador del sistema ',num2str(W),' en forma de vector:']);
            Nums{W}=poly2sym([Num{W}],s); %La syntax que debe de llevar la función de transferencia con respecto a s
            Dens{W}=poly2sym([Den{W}],s); %de vectorial a polinomica
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
        
        A=input('Ingrese el vector de entrada arbitraria: ')
        
        subplot(311)
        Tfun=tf(numTfun,denTfun); %transfer
        R2=impulse(Tfun,t);
        plot(t,R2)
        subplot(312)
        Res=step(Tfun,t);
        plot(t,Res)
        subplot(313)
        Ans=conv(A,R2);
        t1=linspace(0,10,length(Ans));
        plot(t1,Ans)
        
        Poc=roots(denTfun); %Raices del sistema
        R=real(Poc); I=imag(Poc);
        if sum(I)~=0 && (R<0)
            disp('Sistema Estable !')
        elseif isempty(I) && (R<0) %Determine whether array is empty
            disp('Sistema Estable !')
        elseif (R>0)
            disp('Sistema Inestable !')
        elseif sum(I)==0
            disp('Sistema Marginalmente Estable !')
        elseif (R<=0)
            disp('Sistema Estable !')
        else
            disp('Sistema Inestable !')
        end
        
    case {'S','s'}
        Sys=input('Ingrese la cantidad de subsistemas a examinar: ');
        Den=cell(Sys,1);
        Num=cell(Sys,1);
        Nums=cell(Sys,1);
        Dens=cell(Sys,1);
        Hs=cell(Sys,1);
        syms s
        
        for W=1:Sys
            Num{W}=input(['Ingrese coeficientes del numerador del sistema ',num2str(W),' en forma de vector:']);
            Den{W}=input(['Ingrese coeficientes del denominador del sistema ',num2str(W),' en forma de vector:']);
            Nums{W}=poly2sym([Num{W}],s);
            Dens{W}=poly2sym([Den{W}],s);
            N=Num{W};
            D=Den{W};
            Hs{W}=Nums{W}/Dens{W};
            ht=ilaplace(Hs{W})
            
            disp(['Esta es la respuesta al impulso ', num2str(W),':'])
            
        end
        
        HS1=1;
        HS2=1;
        
        for W=1:Sys
            HS1=conv(HS1,Num{W});
            HS2=conv(HS2,Den{W});
        end
        
        B=input('Ingrese el vector de entrada arbitraria: ');
        
        km=tf(HS1,HS2)
        R3=impulse(km,t);
        subplot(311)
        plot(t,R3)
        subplot(312)
        Res2=step(km,t);
        plot(t,Res2)
        subplot(313)
        Ans2=conv(B,R3);
        t2=linspace(0,10,length(Ans2));
        plot(t2,Ans2)
        
        Poc=roots(R3); %Raíces del sistema
        R=real(Poc); I=imag(Poc);
        if sum(I)~=0 && (R<0)
            disp('Sistema Estable !')
        elseif isempty(I) && (R<0) %Determine whether array is empty
            disp('Sistema Estable !')
        elseif (R>0)
            disp('Sistema Inestable !')
        elseif sum(I)==0
            disp('Sistema Marginalmente Estable !')
        elseif (R<=0)
            disp('Sistema Estable !')
        else
            disp('Sistema Inestable !')
        end
        
    otherwise
        disp ('Sistema no identificado.')
end
