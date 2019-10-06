clear, clc, close all;
syms x(n) y(n); %Variables simbolicas
ai= input('Ingresar coeficientes del denominador[# # ..] : '); % Coeficientes numerador
bi = input('Ingresar coeficientes del numerador[# # ..] : '); % Coeficientes denominador
x_n = input('Ingrese la señal de entrada: '); %Parametro para la señal de entrada
T = input('Ingresar periodo de muestreo: ');%Parametro para la función de tranferencia de sistemas discretos
Fs = 1/T; %Frecuencia de muestreo

%% Ecuacion en diferencias
Eq_y = 0; ly = length(ai);
for i = 1:ly
    Eq_y =  Eq_y + (ai(i))*y(n+i-ly);%Componentes del denominador
end
Eq_x = 0; lx=length(bi);
 for j = 1:lx
     Eq_x = Eq_x + (bi(j)*x(n+j-lx));%Componentes del numerador
 end
Eq_en_diferencias = Eq_y == Eq_x; pretty(Eq_en_diferencias)

%% Función de tranferencia
Ai = ai(length(ai):-1:1);Bi = bi(length(bi):-1:1);
H_z = tf(Bi,Ai,T,'variable','z^-1')
Raices = (abs(roots(Ai))'); %Raices de la función de transferencia

R_menor_a_1 = 0; R_igual_a_1 = 0; 

for i=1:length(Raices)
    if Raices(i) == 1                             
        R_igual_a_1 = R_igual_a_1 + 1;                            
    end
    if Raices(i) < 1                             
        R_menor_a_1 = R_menor_a_1 + 1;                                                      
    end
end

if R_menor_a_1 ==  length(Raices)
   subplot(121),zplane(Bi,Ai,'k'),title('Sistema estable'),xlabel('Eje real'),...
   ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')

elseif R_igual_a_1 == length(Raices)
        subplot(121),zplane(Bi,Ai,'k'),title('Sistema marginalmente estable '),xlabel('Eje real'),...
        ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')
else 
    subplot(121),zplane(Bi,Ai,'k'),title('Sistema inestable'),xlabel('Eje real'),...
    ylabel('Eje imaginario'),legend('Zeros','Polos'),grid('minor')
end    

%% Respuesta al impulso
h = impz(Bi,Ai,length(x_n),Fs);
H_n = 0:T:(length(h) - 1)*T;
subplot(322),stem(H_n,h,'k','LineWidth',2'),title('Respuesta al impulso'),xlabel('Tiempo [s]'),...
    ylabel('h[n]'),grid('minor')

%% Señal de entrada
n = 0:T:(length(x_n) - 1)*T;
subplot(324),stem(n,x_n,'k','LineWidth',2),xlabel('Tiempo [s]'),...
    ylabel('x[n]'),title('Señal de entrada'),grid('minor')

%% Respuesta de estado cero
syms ('z')
Hz_numerador = poly2sym(Ai,z);                            
Hz_denominador = poly2sym(Bi,z);                            
Hz = Hz_numerador/Hz_denominador; 
k = 0:(length(x_n) - 1);inversa_Hz = iztrans(Hz,k);hn = double(inversa_Hz);
subplot(326),Y_s = conv(x_n,hn);...
ys = filter(Bi,Ai,x_n);n_z = 0:T:(length(ys)-1)*T;     
    stem(n_z,ys,'k','lineWidth',2),xlabel('Tiempo [s]'),...
     ylabel('ys[n]'),title('Estado cero'),grid('minor')
%% Respuesta en frencuencia
figure (2)
w = linspace(-pi,pi,length(x_n));    
Hw=(polyval(Bi,exp(1i*w))./polyval(Ai,exp(1i*w)));
ESDh = abs(Hw).^2;                                  
wl = (w.*Fs)/2*pi;stem(wl,20*log10(ESDh),'k','LineWidth',2)                             
title('Densidad Espectral de Energia de h[n]')
xlabel('Frecuencia (Hz)'),ylabel('|H(\omega)|_{Hz}'),grid('minor')
