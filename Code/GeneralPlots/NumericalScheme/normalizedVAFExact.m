c = [1 0.5 0.25];
Tau = [1 0.5 0.25];
Omega = sqrt(c./Tau - 1./(4*Tau.^2));
t = logspace(-2,1,1000);
normVAF = zeros(length(t),3);
for k=1:3
    if (Omega(k) == 0)
        normVAF(:,k) = exp(-t/(2*Tau(k))).*(1+t/(2*Tau(k)));
    else
        normVAF(:,k) = exp(-t/(2*Tau(k))).*(cos(Omega(k)*t) + (1/(2*Tau(k)*Omega(k)))*sin(Omega(k)*t));
    end
end
hold on;
plot(t,normVAF,"LineWidth",2.5,"LineStyle","-");
ylim([-0.2 1]);