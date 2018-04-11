clc,close all
t=linspace(0,.2,1e3);
alfa=input('Ingrese el valor de alfa: ');
A=input('Ingrese la amplificación: ');
d=input('Ingrese el retardo: ');
h=@(t) exp(-alfa*t).*sin(2*pi*10*t+pi/6);
plot(t,h(t),t,A*h(t-d))
xlabel 'Tiempo [s]',ylabel 'Amplitud'
grid on
legend('señal original','señal procesada')
%h0=h(0);
%h200=h(.2);
%h150=h(.15);



