noModes = [1,2,3,4,5,6,7,8];
coupled_var = zeros(length(noModes),1);
decoupled_var = zeros(length(noModes),1);

for i=1:length(noModes)
    params_nominal = inputParameters(noModes(i),1);
    params_perturbed = inputParameters(noModes(i),0);
    [~,~,coupled_nominal.VAF,coupled_nominal.MSD] = splittingScheme(params_nominal,i);
    [~,~,coupled_perturbed.VAF,coupled_perturbed.MSD] = splittingScheme(params_perturbed,i);
    coupled_var(i) = var(coupled_perturbed.VAF(:,end)-coupled_nominal.VAF(:,end),0,1);
    [~,~,decoupled_nominal.VAF,decoupled_nominal.MSD] = splittingScheme(params_nominal,i);
    [~,~,decoupled_perturbed.VAF,decoupled_perturbed.MSD] = splittingScheme(params_perturbed,i+10);
    decoupled_var(i) = var(decoupled_perturbed.VAF(:,end)-decoupled_nominal.VAF(:,end),0,1);
    fprintf("Iteration %d\n",i);
end

figure(1);
hold on;
plot(noModes,coupled_var,"LineWidth",2,"Color","k","Marker","o","MarkerSize",10,"MarkerFaceColor","k");
plot(noModes,decoupled_var,"LineWidth",2,"Color","r","Marker","square","MarkerSize",10,"MarkerFaceColor","r");
ylabel("Var$[D(Z_{t})]$","Interpreter","latex","FontSize",14);
xlabel("$N_{k}$","Interpreter","latex","FontSize",14);
title("Var$[D(Z_{t})]$ for Normalized VAF","Interpreter","latex","FontSize",16);
ylim([10^-5 10^-3]);
set(gca,"yscale","log");
grid on;
grid minor;

legend("Coupled Noise","Decoupled Noise","Interpreter","latex","FontSize",14);