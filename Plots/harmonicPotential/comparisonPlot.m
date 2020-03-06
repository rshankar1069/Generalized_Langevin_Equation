clear all; clc; close all;
darkgreen = [0.00,0.60,0.08];
%% Plot to compare exact soln. with numerical soln. for different Nk

Nk1 = load("Nk_1.mat");
Nk2 = load("Nk_2.mat");
Nk4 = load("Nk_4.mat");
Nk6 = load("Nk_6.mat");
Nk8 = load("Nk_8.mat");
exact = load("exactHarmonic.mat");

figure(1);
hold on;
plot(exact.t,exact.Cv,"LineWidth",4,"Color","k");
plot(linspace(0,Nk1.T,Nk1.Nt+1),Nk1.normVAF,"LineWidth",2,"Color","r");
plot(linspace(0,Nk2.T,Nk2.Nt+1),Nk2.normVAF,"LineWidth",2,"Color","b");
plot(linspace(0,Nk4.T,Nk4.Nt+1),Nk4.normVAF,"LineWidth",2,"Color",darkgreen);
plot(linspace(0,Nk6.T,Nk6.Nt+1),Nk6.normVAF,"LineWidth",2,"Color","m");
plot(linspace(0,Nk8.T,Nk8.Nt+1),Nk8.normVAF,"LineWidth",2,"Color","c");

labels = ["Exact","$N_{k} = 1$","$N_{k} = 2$","$N_{k} = 4$","$N_{k} = 6$","$N_{k} = 8$"];

ylim([-2,1.2]);
title("Harmonic Potential Well - VAF","Interpreter","latex","FontSize",16);
xlabel("$t$","Interpreter","latex","FontSize",14);
ylabel("Normalized VAF","Interpreter","latex","FontSize",14);
legend(labels,"Interpreter","latex","FontSize",14,"Location","southeast","NumColumns",2);
grid on;
grid minor;

figure(2);
hold on;
plot(linspace(0,Nk1.T,Nk1.Nt+1),abs(Nk1.normVAF-exact.Cv),"LineWidth",2,"Color","r");
plot(linspace(0,Nk2.T,Nk2.Nt+1),abs(Nk2.normVAF-exact.Cv),"LineWidth",2,"Color","b");
plot(linspace(0,Nk4.T,Nk4.Nt+1),abs(Nk4.normVAF-exact.Cv),"LineWidth",2,"Color",darkgreen);
plot(linspace(0,Nk6.T,Nk6.Nt+1),abs(Nk6.normVAF-exact.Cv),"LineWidth",2,"Color","m");
plot(linspace(0,Nk8.T,Nk8.Nt+1),abs(Nk8.normVAF-exact.Cv),"LineWidth",2,"Color","c");

labels = ["$N_{k} = 1$","$N_{k} = 2$","$N_{k} = 4$","$N_{k} = 6$","$N_{k} = 8$"];

ylim([-0.5,1.3]);
title("Harmonic Potential Well - Pointwise Error","Interpreter","latex","FontSize",16);
xlabel("$t$","Interpreter","latex","FontSize",14);
ylabel("$|y^{n}-y(t^{n})|$","Interpreter","latex","FontSize",14);
legend(labels,"Interpreter","latex","FontSize",14,"Location","southeast","NumColumns",3);
grid on;
grid minor;