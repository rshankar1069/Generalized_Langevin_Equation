clear all; clc; close all;

%% Exact Solution for Harmonic Potential VAF
T = 10;
Nt = 1000;
t = linspace(0,T,Nt+1);
Gamma = 1;
Lambda = 0.5;
freq = 1.4;

NK = 50;
NJ = 50;

Cv = VACF(t,Nt,Gamma,Lambda,freq,NK,NJ);

plot(t,Cv);

function [Cv] = VACF(t,Nt,Gamma,Lambda,freq,NK,NJ)
   for n=1:(Nt+1)
       sumK = 0;
       y = -Gamma*t(n)^(2-Lambda);
       for k=0:NK-1
           ALPHA = 2-Lambda;
           BETA = 1+Lambda*k;
           sumJ = 0;
           for j=0:NJ-1
               sumJ = sumJ + (factorial(j+k)/factorial(j))*(y^(j))/(gamma(ALPHA*(j+k)+BETA));
           end
           sumK = sumK + (((-1)^(k))/(factorial(k)))*(freq*t(n))^(2*k)*sumJ;
       end
       Cv(n) = sumK;
   end
end