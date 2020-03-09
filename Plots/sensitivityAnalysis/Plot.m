load("soln.mat");

figure(1);
hold on;
plot(params.EPS,VAR1,"LineWidth",2,"Color","k","LineStyle","--","Marker","o","MarkerSize",10);
plot(params.EPS,VAR2,"LineWidth",2,"Color","r","LineStyle","--","Marker","square","MarkerSize",10);
plot(params.EPS,params.EPS.^2*(1e-5),"LineWidth",2,"Color","k");
plot(params.EPS,ones(length(params.EPS),1)*(1e-5),"LineWidth",2,"Color","r");

set(gca,"yscale","log");
set(gca,"xscale","log");
ylim([1e-30 1e20]);

title("Var[$D(Z_{t})$] for Normalized VAF","Interpreter","latex","FontSize",16);
xlabel("$\varepsilon$","Interpreter","latex","FontSize",14);
ylabel("Var[$D(Z_{t})$]","Interpreter","latex","FontSize",14);
grid on;
grid minor;

LegendNames = ["Coupled Noise","Decoupled Noise","$\mathcal{O}(\varepsilon^{2})$","$\mathcal{O}(1)$"];
legend(LegendNames,"Interpreter","latex","FontSize",14);

figure(2);
hold on;
plot(params.EPS,Coupled_Variance,"LineWidth",2,"Color","k","LineStyle","--","Marker","o","MarkerSize",10);
plot(params.EPS,Decoupled_Variance,"LineWidth",2,"Color","r","LineStyle","--","Marker","square","MarkerSize",10);
plot(params.EPS,ones(length(params.EPS),1)*(1e-5),"LineWidth",2,"Color","k");
plot(params.EPS,params.EPS.^(-2)*(1e-5),"LineWidth",2,"Color","r");

set(gca,"yscale","log");
set(gca,"xscale","log");
ylim([1e-30 1e20]);

title("Var[$\Delta_{c}$] for Normalized VAF","Interpreter","latex","FontSize",16);
xlabel("$\varepsilon$","Interpreter","latex","FontSize",14);
ylabel("Var[$\Delta_{c}$]","Interpreter","latex","FontSize",14);
grid on;
grid minor;

LegendNames = ["Coupled Noise","Decoupled Noise","$\mathcal{O}(M^{-1})$","$\mathcal{O}(\varepsilon^{-2} M^{-1})$"];
legend(LegendNames,"Interpreter","latex","FontSize",14);