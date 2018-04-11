% Christian Camilo Gaviria Castro - C.C.
% Julian Castrillón García - C.C.
% Brahian Cortés - C.C.

clc,clearvars,close  all

system=input('Seleccione la interconexión: paralelo (P) o cascada (S): ','s');

switch system
    
    case 'P'
       Ssys=input('Ingrese la cantidad de subsistemas a examinar: ');
       Den=cell(Ssys,1);
       Num=cell(Ssys,1);
       Nums=cell(Ssys,1);
       Dens=cell(Ssys,1);
       Hs=cell(Ssys,1);
       %ht=cell(Ssystem,1);
       syms x(s) y(s) % variables simbolicas
       
       for W=1:Ssys
           Num{W}=input(['Ingrese el numerador ',num2str(W),' en forma de vector:']);
           Den{W}=input(['Ingrese el denominador ',num2str(W),' en forma de vector:']);
           Nums{W}=poly2sym([Num{W}],s);
           Dens{W}=poly2sym([Den{W}],s);
           Hs{W}=Nums{W}/Dens{W};
           ht=ilaplace(Hs{W})
       end
            
       H=0;
       for i=1:Ssys;
           H(i+0)= H(i)+Hs{W}
       end
      
    case 'S'
       Ssys=input('Ingrese la cantidad de subsistemas a examinar: ');
       Den=cell(Ssys,1);
       Num=cell(Ssys,1);
       Nums=cell(Ssys,1);
       Dens=cell(Ssys,1);
       Hs=cell(Ssys,1);
       %ht=cell(Ssistem,1);
       syms x(s) y(s)
        for W=1:Ssys
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
        
        
      