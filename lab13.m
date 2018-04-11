clc, clear vars
A=input('Ingrese amplitud: ');
T=input('Ingrese el periodo: ');
t0=input('Ingrese ancho del pulso: ');
w0=2*pi/T;
t=linspace(-1.5*T,1.5*T,1e3);
x=(A*t0)/T;
pos=1;
for n=1:17
    an=(4*A*sin((n*t0*w0)/2))/(T*n*w0);
    x=x+an*cos(n*w0*t);
    
    if mod(n,2)==1
        subplot(3,3,pos)
        plot(t,x), axis tight
        xlabel 'Tiempo'
        ylabel (['X_{',num2str(n),'}(t)'])
        pos=pos+1;
    end
end
figure
n=0:20;
cn=A*t0/T*sa(n*w0*t0/2);
stem(n,abs(cn))
xlabel 'Armónico',ylabel '|c_n|'
title 'Espectro de magnitud de la serie de Fourier'

% x=0;
% for n=-50:50
%     cn=A*t0/T*sa(n*w0*t0/2);
%     x=x+cn*exp(1i*n*w0*t);
% end
%     plot(t,x), axis tight, grid on
%     xlabel 'Tiempo (s)',ylabel 'Amplitud'
%     title(['Amplitud=',num2str(A),',periodo= ',num2str(T),' ancho de pulso= ', num2str(t0), 'armónico= ',num2str(n)])
%    pause 
% end