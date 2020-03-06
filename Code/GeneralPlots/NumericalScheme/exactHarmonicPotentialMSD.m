clear all; clc; close all;

Nt = 1000;
x0 = 0;
v0 = 0.01;
freq = 1.4;
kB = physconst("boltzmann");
Temp = 300;
m = 1;
T = 10;
del_t = T/Nt;
t = linspace(0,T,Nt+1);

NJ = 50;
NK = 50;

Gamma = 1;
Lambda = 0.5;

MSD = zeros(1,Nt+1);
% Calculating I(t) terms

for n=1:(Nt+1)
    sum_K_I = 0;
    sum_K_G = 0;
    
    y = -Gamma*t(n)^(2-Lambda);
    
    for k=0:NK-1
        sum_J_I = 0;
        sum_J_G = 0;
        
        ALPHA_I = 2-Lambda;
        BETA_I = 3+Lambda*k;
        ALPHA_G = 2-Lambda;
        BETA_G = 2+Lambda*k;
        
        for j=0:NJ-1
            sum_J_I = sum_J_I + (factorial(j+k)/factorial(j))*(y^(j))/(gamma(ALPHA_I*(j+k)+BETA_I));
            sum_J_G = sum_J_G + (factorial(j+k)/factorial(j))*(y^(j))/(gamma(ALPHA_G*(j+k)+BETA_G));
        end
        
        sum_K_I = sum_K_I + ((-1)^k/factorial(k))*(freq^(2*k))*(t(n)^(2*(k+1)))*sum_J_I;
        sum_K_G = sum_K_G + ((-1)^k/factorial(k))*(freq^(2*k))*(t(n)^(2*k+1))*sum_J_G;
    end
    MSD(n) = ((2*kB*Temp)/m)*sum_K_I - 2*x0*v0*(freq^2)*sum_K_G*sum_K_I + ...
            (v0^2 - (kB*Temp)/m)*sum_K_G^2 + (freq^2)*((x0^2)*(freq^2) - (kB*Temp)/m)*sum_K_I^2;
end