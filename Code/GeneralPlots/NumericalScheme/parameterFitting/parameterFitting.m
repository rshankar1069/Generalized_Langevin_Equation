clear all; clc; close all;
hold on;
%% Input Parameters
Nk = [4,6,8];
Gamma = 1;
Lambda = 0.5;
T = 10;
Nt = 1000;
del_t = T/Nt;

%% Actual Memory Kernel for the Harmonic Potential

t = logspace(floor(log10(del_t/10)),floor(log10(10*Nt*del_t)),Nt);
MKactual = (Gamma/gamma(1-Lambda))*t.^(-Lambda);

ActualMermoryKernel = plot(log10(t),log10(MKactual));
ActualMermoryKernel.LineWidth = 2.5;
ActualMermoryKernel.Color = "k";
ActualMermoryKernel.LineStyle = "-";

%% Prony Series Memory Kernel for the Harmonic Potential

% rand('seed',22);
rand('seed',35);
for i = 1:length(Nk)
    nk = Nk(i);
    Tau = logspace(floor(log10(del_t/10)),floor(log10(10*Nt*del_t)),nk);
    c = zeros(nk,1);
    
    % Solving for Least Square Fitting of parameters
    t_mat = repmat(t',1,nk);
    A_mat = (1./Tau).*exp(-t_mat./Tau);
    x_vec = c;
    b_vec = MKactual';

    x_vec = (A_mat'*A_mat)\(A_mat'*b_vec);

    c = x_vec;

    % Prony series approximation of the memory kernel

    MK = zeros(Nt,nk);
    for n = 1:Nt
        for k = 1:nk
            MK(n,k) = (c(k)/Tau(k))*exp(-t(n)/Tau(k));
        end
    end

    MK = sum(MK,2);

    ColorMap = rand(3,1);
    PronySeries(i) = plot(log10(t),log10(MK));
    PronySeries(i).LineWidth = 2.5;
    PronySeries(i).LineStyle = "-.";
    PronySeries(i).Color = ColorMap;
    
    LegendName(i) = sprintf("$N_{k} = %d$",nk);
end

Legend = legend(["Exact Memory Kernel",LegendName],"Interpreter","latex","FontSize",13);

xlabel("$log_{10}(t)$","Interpreter","latex","FontSize",14);
ylabel("$log_{10}(\Gamma(t))$","Interpreter","latex","FontSize",14);
title("Harmonic Potential Memory Kernel Approximation","Interpreter","latex","FontSize",16);

grid on;
grid minor;
