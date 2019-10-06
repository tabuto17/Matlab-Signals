%% Brahian Cortes       - 1020440471

clearvars, clc, close all;
syms x(n) y(n); %Variables simbólicas
nHz = input('Ingrese vector [bm ... b1 b0]: '); l_n=length(nHz);% Ingreso vector polinomio del numerador (bi)
b=fliplr(nHz);                                                  % Variable para invertir el orden del vector nHz
dHz = input('Ingrese vector [an ... a1 a0]: '); l_d=length(dHz);% Ingreso vector polinomio del denominador (ai)
a=fliplr(dHz);                                                  % Variable para invertir el orden del vector dHz
xn = input('Ingrese la señal de entrada aleatoria: ');          % Señal de entrada x(n) en forma de vector de datos
Ts = input('Ingresar periodo de muestreo en segundos: ');       % Periodo de muestreo (T)
%% Dinámicos
N=length(xn); n_1=0:N-1;                                          % Numero de muestras N de la señal x[n] y contador de tiempo
nT=n_1*Ts; Fs=1./nT;                                              % Timepo variable en segundos nT y Frecuencia de muestreo Fs   
%% Funcion de transferencia
% Cantidad de datos del Numerador(b) y Denominador(a)                                      
EqY = 0;   EqX = 0;                                              % Vector vacio

  for i = 1:l_n                                                  % Definir la longitud del vector b  
      EqY = EqY + (nHz(i)*y(n+i-l_n));                           % Componentes del numerador 
  end

  for j = 1:l_d
      EqX = EqX + (dHz(j)*x(n+j-l_d));                           % Componentes del denominador
  end
disp('Ecuación en diferencias:')                                 % Mostrar ecuacion en diferencias
E_dif = EqY == EqX;                                              % Ecuación en diferencias
pretty(E_dif)  

% Función de Transferencia
Hz = tf(nHz,dHz,-1)                                              %Transformada z , -1 para que no sea transformada laplace sino Tz
