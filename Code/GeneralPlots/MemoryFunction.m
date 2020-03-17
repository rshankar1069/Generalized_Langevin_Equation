clc; clear all; close all;
hold on;
t = 0:0.05:6;

% Colors
color = struct('p',[0.710,0.138,0.730],...
                'dg',[0.148,0.660,0.112]);

k = 100;
n = 1:k;
omega = n/100;
theta = omega'*t;
Psi = (1/k)*sum(cos(theta),1);
plot(t,Psi,"LineWidth",2,"Color","k");

k = 200;
n = 1:k;
omega = n/100;
theta = omega'*t;
Psi = (1/k)*sum(cos(theta),1);
plot(t,Psi,"LineWidth",2,"Color",color.p);

k = 400;
n = 1:k;
omega = n/100;
theta = omega'*t;
Psi = (1/k)*sum(cos(theta),1);
plot(t,Psi,"LineWidth",2,"Color","b");

k = 800;
n = 1:k;
omega = n/100;
theta = omega'*t;
Psi = (1/k)*sum(cos(theta),1);
plot(t,Psi,"LineWidth",2,"Color","r");

k = 1600;
n = 1:k;
omega = n/100;
theta = omega'*t;
Psi = (1/k)*sum(cos(theta),1);
plot(t,Psi,"LineWidth",2,"Color",color.dg);

grid on;
grid minor;
legend("$k=100$","$k=200$","$k=400$","$k=800$","$k=1600$","Interpreter","latex","FontSize",14);
xlabel("Time, $t$","Interpreter","latex","FontSize",14);
ylabel("$\psi(t)=k^{-1} \sum_{i=1}^{k} cos(\Omega_{i}^{(k)}t)$","Interpreter","latex","FontSize",14);