clear all; clc; close all;
inputParams;

% Specify the index for the mode of 'c' to be perturbed

timeval = linspace(0,params.T,params.Nt+1);

index = 6;
couplingOpt = 1;
Delta_Central_Coupled = centralDifference(params,index,couplingOpt);
Coupled_Sigma = std(Delta_Central_Coupled.VAF,0,1);
couplingOpt = 0;
Delta_Central_Decoupled = centralDifference(params,index,couplingOpt);
Decoupled_Sigma = std(Delta_Central_Decoupled.VAF,0,1);

hold on;
plot(timeval,mean((Delta_Central_Coupled.VAF),1),"Color","k","LineWidth",2);
plot(timeval,mean((Delta_Central_Decoupled.VAF),1),"Color","r","LineWidth",2);
fill([timeval,fliplr(timeval)], ...
    [mean((Delta_Central_Coupled.VAF),1)+2*Coupled_Sigma,fliplr(mean((Delta_Central_Coupled.VAF),1)-2*Coupled_Sigma)], ...
    "k","FaceAlpha",0.2);
fill([timeval,fliplr(timeval)], ...
    [mean((Delta_Central_Decoupled.VAF),1)+2*Decoupled_Sigma,fliplr(mean((Delta_Central_Decoupled.VAF),1)-2*Decoupled_Sigma)], ...
    "r","FaceAlpha",0.2);

xlabel("$t$","Interpreter","latex","FontSize",14);
ylabel("$\mathcal{S}(t,\theta;f)$","Interpreter","latex","FontSize",14);
legend("Coupled Noise","Decoupled Noise","Interpreter","latex","FontSize",14);