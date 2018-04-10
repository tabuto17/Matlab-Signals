% Christian Camilo Gaviria Castro - C.C.
% Julian Castrillón García - C.C.
% Brahian Cortés - C.C.

clc,clearvars,close  all

system=input('Seleccione la interconexión: paralelo (P) o cascada (S): ','s');

switch system
    
    case 'P'
       Ssystem=input('Ingrese la cantidad de subsistemas a examinar: ');
       Den=cell(Ssystem,1);
       Num=cell(Ssystem,1);
       Nums=cell(Ssystem,1);
       Dens=cell(Ssystem,1);
       Hs=cell(Ssystem,1);
       %ht=cell(Ssystem,1);
       syms x(s) y(s)
       for W=1:Ssystem
           Num{W}=input(['Ingrese el numerador ',num2str(W),' en forma de vector:']);
           Den{W}=input(['Ingrese el denominador ',num2str(W),' en forma de vector:']);
           Nums{W}=poly2sym([Num{W}],s);
           Dens{W}=poly2sym([Den{W}],s);
           Hs{W}=Nums{W}/Dens{W};
           ht=ilaplace(Hs{W})
       end
       
    case 'S'
       Ssystem=input('Ingrese la cantidad de subsistemas a examinar: ');
       Den=cell(Ssystem,1);
       Num=cell(Ssystem,1);
       Nums=cell(Ssystem,1);
       Dens=cell(Ssystem,1);
       Hs=cell(Ssystem,1);
       %ht=cell(Ssistem,1);
       syms x(s) y(s)
        for W=1:Ssystem
            Num{W}=input(['Ingrese el numerador ',num2str(W),' en forma de vector:']);
            Den{W}=input(['Ingrese el denominador ',num2str(W),' en forma de vector:']);
            Nums{W}=poly2sym([Num{W}],s);
            Dens{W}=poly2sym([Den{W}],s);
            Hs{W}=Nums{W}/Dens{W};
            ht=ilaplace(Hs{W})
        end
        
otherwise
       disp ('Sistema no identificado')
end
        
        
      