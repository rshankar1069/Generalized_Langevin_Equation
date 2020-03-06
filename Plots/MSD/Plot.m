clear all; clc; close all;

exact = load("exact.mat");
Nk1 = load("Nk_1.mat");
Nk2 = load("Nk_2.mat");
Nk4 = load("Nk_4.mat");
Nk6 = load("Nk_6.mat");
Nk8 = load("Nk_8.mat");

rand('seed',42);

colors = rand(5,3);

hold on;
plot(exact.t,normalize(exact.MSD),"LineWidth",3,"Color","k");
plot(linspace(0,Nk1.T,Nk1.Nt+1),normalize(Nk1.MSD),"LineWidth",2.5,"Color",colors(1,:),"LineStyle","-.");
plot(linspace(0,Nk2.T,Nk2.Nt+1),normalize(Nk2.MSD),"LineWidth",2.5,"Color",colors(2,:),"LineStyle","-.");
plot(linspace(0,Nk4.T,Nk4.Nt+1),normalize(Nk4.MSD),"LineWidth",2.5,"Color",colors(3,:),"LineStyle","-.");
plot(linspace(0,Nk6.T,Nk6.Nt+1),normalize(Nk6.MSD),"LineWidth",2.5,"Color",colors(4,:),"LineStyle","-.");
plot(linspace(0,Nk8.T,Nk8.Nt+1),normalize(Nk8.MSD),"LineWidth",2.5,"Color",colors(5,:),"LineStyle","-.");

grid on;
grid minor;

title("Harmonic Potential Well - MSD","Interpreter","latex","FontSize",16);
xlabel("$t$","Interpreter","latex","FontSize",14);
ylabel("Normalized MSD","Interpreter","latex","FontSize",14);
legend("Exact","$N_{k}=1$","$N_{k}=2$","$N_{k}=4$","$N_{k}=6$","$N_{k}=8$","Interpreter","latex","FontSize",14);