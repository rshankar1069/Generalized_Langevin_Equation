c = 1;
Tau = 1;
Omega = sqrt(c/Tau - 1/(4*Tau^2));
t = logspace(-1,1,100);
if (Omega == 0)
    normVAF = exp(-t/(2*Tau)).*(1+t/(2*Tau));
else
    normVAF = exp(-t/(2*Tau)).*(cos(Omega*t) + (1/(2*Tau*Omega))*sin(Omega*t));
end
hold on;
plot(t,normVAF,"LineWidth",2,"Color","r","LineStyle","-");
ylim([-0.2 1]);