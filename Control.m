%% Programa para comparara diferentes modelos para P,PI,PID

%Parametros
Tup = 1;
th = 4.57;
A = 1;
tfn = 160;
pruido = 0;
tao = 28.22;
kp = 1.747;
num = kp;
den = [tao 1];

%=========================================================================%
% -------------------- Zigler Nichols PID  -------------------------------%
%%Ganancias Proporcionales
Kc1 = (tao/(kp*th));
Kc2 = ((0.9*tao)/(kp*th))*0.1; 
Kc3 = ((1.2*tao)/(kp*th))*0.1;
%%Tiempos integrales
Ti2 = 3.33*th;
Ti3 = 2*th;
%%Tiempo derivativo 
Td3 = 0.5*th; 
%%Simulink
sim('ModelosCom');
%%Graficacion
figure;
r = DataOut.signals(1).values;
y = DataOut.signals(2).values;
p1 = DataOut.signals(3).values;
pi1 = DataOut.signals(4).values;
pid1 = DataOut.signals(5).values;

plot(tout,r,tout,y,tout,p1,tout,pi1,tout,pid1,'LineWidth',1);
title('Zigler')
legend('r(t)','y(t)','p','pi','pid');
grid;

%=========================================================================%
% ----------------------------- IAE PID ----------------------------------%
%%Ganancias Proporcionales
Kc1 = (0.902/kp)*((th/tao)^-0.985);
Kc2 = ((0.984/kp)*((th/tao)^-0.986))*0.1; 
Kc3 = ((1.435/kp)*((th/tao)^-0.921))*0.1;
%%Tiempos integrales
Ti2 = (tao/0.608)*((th/tao)^0.707); 
Ti3 = (tao/0.878)*((th/tao)^0.749);
%%Tiempo derivativo 
Td3 = (0.482*tao)*((th/tao)^1.137); 
%%Simulink
sim('ModelosCom');

figure;
r = DataOut.signals(1).values;
y = DataOut.signals(2).values;
p2 = DataOut.signals(3).values;
pi2 = DataOut.signals(4).values;
pid2 = DataOut.signals(5).values;

plot(tout,r,tout,y,tout,p2,tout,pi2,tout,pid2,'LineWidth',1);
title('IAE')
legend('r(t)','y(t)','p','pi','pid');
grid;

 
%======================= GRAFICAS - COMPARAR =============================%
figure;
subplot(3,1,1)
plot(tout,r,tout,p1,tout,p2,'LineWidth',1)
title('(P) Zigler vs IAE')
legend('r(t)','Zigler','IAE');
grid;
%-------------------------------------------------------------------------%
subplot(3,1,2)
plot(tout,r,tout,pi1,tout,pi2,'LineWidth',1)
title('(PI) Zigler vs IAE')
legend('r(t)','Zigler','IAE');
grid;
%-------------------------------------------------------------------------%
subplot(3,1,3)
plot(tout,r,tout,pid1,tout,pid2,'LineWidth',1)
title('(PID) Zigler vs IAE')
legend('r(t)','Zigler','IAE');
grid;
%-------------------------------------------------------------------------%
