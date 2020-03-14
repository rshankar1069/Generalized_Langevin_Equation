clear all;clc;
darkgreen = [0.07 0.40 0.00];

%% Underdamped case
exact = load("ExactVAF.mat");
euler = load("explicitEulerUnder.mat");
splitting = load("splittingMethodUnder.mat");

% figure(4);
% hold on;
% plot(linspace(0,euler.T,euler.Nt+1),euler.stderr,"LineWidth",2,"Color","b");
% plot(linspace(0,splitting.T,splitting.Nt+1),splitting.stderr,"LineWidth",2,"Color","r");

figure(1);
hold on;
plot(exact.t,exact.normVAF(:,1),"LineWidth",3,"Color","c");
plot(linspace(0,euler.T,euler.Nt+1), ...
    euler.normVAF, ...
    "LineWidth",2.5,"Color","r","LineStyle","-.");
plot(linspace(0,splitting.T,splitting.Nt+1), ...
    splitting.normVAF, ...
    "LineWidth",2.5,"Color","k","LineStyle","--");
ylim([-0.2 1]);
grid on;
grid minor;
title("$c=1,\; \tau = 1$","Interpreter","latex","FontSize",16);
xlabel("Time","Interpreter","latex","FontSize",14);
ylabel("Normalized VAF","Interpreter","latex","FontSize",14);
legend("Exact","Explicit Euler","Splitting Method","Interpreter","latex","FontSize",14);

clear all;

%% Critically damped case
exact = load("ExactVAF.mat");
euler = load("explicitEulerCritical.mat");
splitting = load("splittingMethodCritical.mat");

% figure(5);
% hold on;
% plot(linspace(0,euler.T,euler.Nt+1),euler.stderr,"LineWidth",2,"Color","b");
% plot(linspace(0,splitting.T,splitting.Nt+1),splitting.stderr,"LineWidth",2,"Color","r");

figure(2);
hold on;
plot(exact.t,exact.normVAF(:,2),"LineWidth",3,"Color","c");
plot(linspace(0,euler.T,euler.Nt+1), ...
    euler.normVAF, ...
    "LineWidth",2.5,"Color","r","LineStyle","-.");
plot(linspace(0,splitting.T,splitting.Nt+1), ...
    splitting.normVAF, ...
    "LineWidth",2.5,"Color","k","LineStyle","--");
ylim([-0.2 1]);
grid on;
grid minor;
title("$c=0.5,\; \tau = 0.5$","Interpreter","latex","FontSize",16);
xlabel("Time","Interpreter","latex","FontSize",14);
ylabel("Normalized VAF","Interpreter","latex","FontSize",14);
legend("Exact","Explicit Euler","Splitting Method","Interpreter","latex","FontSize",14);

clear all;

%% Overdamped case
exact = load("ExactVAF.mat");
euler = load("explicitEulerOver.mat");
splitting = load("splittingMethodOver.mat");

% figure(6);
% hold on;
% plot(linspace(0,euler.T,euler.Nt+1),euler.stderr,"LineWidth",2,"Color","b");
% plot(linspace(0,splitting.T,splitting.Nt+1),splitting.stderr,"LineWidth",2,"Color","r");

figure(3);
hold on;
plot(exact.t,exact.normVAF(:,3),"LineWidth",3,"Color","c");
plot(linspace(0,euler.T,euler.Nt+1), ...
    euler.normVAF, ...
    "LineWidth",2.5,"Color","r","LineStyle","-.");
plot(linspace(0,splitting.T,splitting.Nt+1), ...
    splitting.normVAF, ...
    "LineWidth",2.5,"Color","k","LineStyle","--");
ylim([-0.2 1]);
grid on;
grid minor;
title("$c=0.25,\; \tau = 0.25$","Interpreter","latex","FontSize",16);
xlabel("Time","Interpreter","latex","FontSize",14);
ylabel("Normalized VAF","Interpreter","latex","FontSize",14);
legend("Exact","Explicit Euler","Splitting Method","Interpreter","latex","FontSize",14);

clear all;