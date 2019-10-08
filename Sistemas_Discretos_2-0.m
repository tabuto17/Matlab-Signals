% Brahian Cortes  - 1020440471
% Diego Uribe - 
%%
clearvars, clc, close all;
syms x(n) y(n); %Variables simbólicas
nHz = input('Ingrese vector [bm ... b1 b0]: '); l_n=length(nHz);% Ingreso vector polinomio del numerador (bi)
b=fliplr(nHz);                                                  % Variable para invertir el orden del vector nHz
dHz = input('Ingrese vector [an ... a1 a0]: '); l_d=length(dHz);% Ingreso vector polinomio del denominador (ai)
a=fliplr(dHz);                                                  % Variable para invertir el orden del vector dHz
xn = input('Ingrese la señal de entrada aleatoria: ');          % Señal de entrada x(n) en forma de vector de datos
Ts = input('Ingresar periodo de muestreo en segundos: ');       % Periodo de muestreo (T)

%% Dinámicos

N=length(xn); n_1=0:N-1;                                        % Numero de muestras N de la señal x[n] y contador de tiempo
nT=n_1*Ts; Fs=1./nT;                                            % Timepo variable en segundos nT y Frecuencia de muestreo Fs 

%% Ecuación de diferencias 

EqY = 0;   EqX = 0;                                              % Vector vacio
  for i = 1:l_n                                                  % Definir la longitud del vector b  
      EqY = EqY + (nHz(i)*y(n+i-l_n));                           % Componentes del numerador 
  end

  for j = 1:l_d
      EqX = EqX + (dHz(j)*x(n+j-l_d));                           % Componentes del denominador
  end
disp('Ecuación en diferencias:')                                 % Mostrar ecuacion en diferencias
E_dif = EqY == EqX;  pretty(E_dif)                               % Ecuación en diferencias

%% Función de Transferencia

Hz = tf(nHz,dHz,Ts,'variable','z^-1')                            % Transformada z^-1 para que se muestre en Tz
Rhz = (abs(roots(dHz))');                                        % Raices de la función de transferencia

%% Estabilidad

Es = find(Rhz > 1); Ma_1 = find(Rhz==1); Ma_2 = find(Rhz==-1); Ins = find(Rhz < 1);
Est = Rhz(Es); Mar_1 = Rhz(Ma_1); Mar_2 = Rhz(Ma_2); Ine = Rhz(Ins);

if (Est > 1)
    subplot(121),zplane(nHz,dHz,'k'),title('Sistema inestable'),xlabel('Eje real'),...
    ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')
elseif (Mar_1 == 1)
    subplot(121),zplane(nHz,dHz,'k'),title('Sistema marginalmente estable '),xlabel('Eje real'),...
        ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')
elseif (Mar_2 == -1)
    subplot(121),zplane(nHz,dHz,'k'),title('Sistema marginalmente estable '),xlabel('Eje real'),...
        ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')
elseif (Ine < 1)
    subplot(121),zplane(nHz,dHz,'k'),title('Sistema estable'),xlabel('Eje real'),...
    ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')
end

%% Respuesta al impulso 
syms z;                                             % Variable simbolica z para definir el numerador y denominador de H(z)
Hznum = poly2sym(nHz,z); Hzden=poly2sym(dHz,z);     % Polinomio del numerador de Función de Transferencia
Hz = Hznum/Hzden;                                   % Funcion de Transferencia H(z)
iHz = iztrans(Hz,n_1); hn = double(iHz);            % Inversa de H(z) con el contador de tiempo y parte real (comando double)
subplot(322), stem(nT,real(hn),'r','LineWidth',1),...
    grid minor, xlabel 'Tiempo [s]', ylabel 'h[n]',...
    title 'Respuesta al Impulso h[n]'
%% Señal de Entrada (Aleatoria)
subplot(324), stem(nT,xn,'g','LineWidth',1),...
    grid minor, xlabel 'Tiempo [s]',...
    ylabel 'x[n]', title 'Señal de entrada x[n]'
%% Respuesta de Estado Cero y[n]
yn=filter(nHz,dHz,xn);                            % Respuesta de Estado Cero y[n]
subplot(326), stem(nT,yn,'m','LineWidth',1),...
    grid minor, xlabel 'Tiempo [s]',...
    ylabel 'y[n]', title 'Respuesta de Estado Cero y[n]'
%% Respuesta en Frecuencia
w = linspace(-pi,pi,N); wnorm=w/(2*pi);                 % Frecuencia digital en radianes (Rad) y Normalizada (Ciclos/Muestra)                                  
wlin = (wnorm.*Fs)/2*pi;                                % Frecuencia Lineal (Hz)
Hw = (polyval(nHz,exp(1i*w))./polyval(dHz,exp(1i*w)));  % DTFT de H[n]
ESDh = abs(Hw).^2;                                      % ESD de h[n]
figure (2)
stem(wlin,20*log10(ESDh), 'b','LineWidth',2) , title('Densidad Espectral de Energia de h[n]'),...
    xlabel('Frecuencia (Hz)'), ylabel('|H(\omega)|_{Hz}'),...
    grid minor, axis tight


