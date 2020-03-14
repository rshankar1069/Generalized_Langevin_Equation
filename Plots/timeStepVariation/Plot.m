t1 = load("1e_1.mat");
t2 = load("1e_2.mat");
t3 = load("1e_3.mat");
t4 = load("1e_4.mat");
t5 = load("1e_5.mat");

figure(1);
hold on;
plot(linspace(0,t1.T,t1.Nt+1),t1.normVAF,"LineWidth",2,"Color","k");
plot(linspace(0,t2.T,t2.Nt+1),t2.normVAF,"LineWidth",2,"Color","r");
plot(linspace(0,t3.T,t3.Nt+1),t3.normVAF,"LineWidth",2,"Color","b");
plot(linspace(0,t4.T,t4.Nt+1),t4.normVAF,"LineWidth",2,"Color","g");
plot(linspace(0,t5.T,t5.Nt+1),t5.normVAF,"LineWidth",2,"Color","m");
% xlim([0 10]);
ylim([-0.2 1]);
grid on;
grid minor;
title("$c=0.25,\; \tau = 0.25$","Interpreter","latex","FontSize",16);
xlabel("Time","Interpreter","latex","FontSize",14);
ylabel("Normalized VAF","Interpreter","latex","FontSize",14);
legendNames = ["$\delta t = 10^{-1}$","$\delta t = 10^{-2}$","$\delta t = 10^{-3}$", ...
                "$\delta t = 10^{-4}$","$\delta t = 10^{-5}$"];
legend(legendNames,"Interpreter","latex","FontSize",14,"Location","southwest");