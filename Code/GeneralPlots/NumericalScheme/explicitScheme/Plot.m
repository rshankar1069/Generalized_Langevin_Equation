figure(1);
hold on;
plot(linspace(0,T,Nt+1),Xt,"LineWidth",2,"Color","k","LineStyle",":");
plot(linspace(0,T,Nt+1),Vt,"LineWidth",2,"Color","r","LineStyle",":");
xlabel("$t$","Interpreter","latex","FontSize",14);
title("Explicit Euler Integration Scheme","Interpreter","latex","FontSize",16);

figure(2);
errorbar(linspace(0,T,Nt+1),normVAF/max(abs(normVAF)),stderr,"LineWidth",1.5,"Color","b");