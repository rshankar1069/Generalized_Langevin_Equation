noModes = [1,2,3,4,5,6,7,8];
SStarCoupled = zeros(length(noModes),length(noModes));
SStarDecoupled = zeros(length(noModes),length(noModes));

for i=1:length(noModes)
    for j=1:length(noModes)
        if(i < j)
            params_N1 = inputParameters(noModes(i),1);
            params_N2 = inputParameters(noModes(j),0);
        elseif(i > j)
            params_N1 = inputParameters(noModes(i),0);
            params_N2 = inputParameters(noModes(j),1);
        elseif(i == j)
            params_N1 = inputParameters(noModes(i),0);
            params_N2 = inputParameters(noModes(j),0);
        end
        [~,~,coupled_N1.VAF,coupled_N1.MSD] = splittingScheme(params_N1,i+j);
        [~,~,coupled_N2.VAF,coupled_N2.MSD] = splittingScheme(params_N2,i+j);
        coupled_DZ = mean(coupled_N1.VAF(:,2:end)-coupled_N2.VAF(:,2:end),1);
        coupled_sigma = std(coupled_N1.VAF(:,2:end)-coupled_N2.VAF(:,2:end),0,1);
        SStarCoupled(i,j) = sum((coupled_DZ.^2)./coupled_sigma);
        
        [~,~,decoupled_N1.VAF,decoupled_N1.MSD] = splittingScheme(params_N1,i+j);
        [~,~,decoupled_N2.VAF,decoupled_N2.MSD] = splittingScheme(params_N2,i+j+10);
        decoupled_DZ = mean(decoupled_N1.VAF(:,2:end)-decoupled_N2.VAF(:,2:end),1);
        decoupled_sigma = std(decoupled_N1.VAF(:,2:end)-decoupled_N2.VAF(:,2:end),0,1);
        SStarDecoupled(i,j) = sum((decoupled_DZ.^2)./decoupled_sigma);
    end
end

SStarCoupled = triu(SStarCoupled,1);
SStarDecoupled = triu(SStarDecoupled,1);

LegendNames = ["$N_{2}=1$","$N_{2}=2$","$N_{2}=3$","$N_{2}=4$","$N_{2}=5$","$N_{2}=6$","$N_{2}=7$","$N_{2}=8$"];

figure(1);
bar(SStarCoupled(1:7,1:7));
legend(LegendNames,"Interpreter","latex","FontSize",14);
xlabel("$N_{1}$","Interpreter","latex","FontSize",14);
ylabel("$\mathcal{S}^{*} = \sum_{t} |E[D(Z_{t})]|^{2} / \sigma_{t}$","Interpreter","latex","FontSize",14);

figure(2);
bar(SStarDecoupled(1:7,1:7));
legend(LegendNames,"Interpreter","latex","FontSize",14);
xlabel("$N_{1}$","Interpreter","latex","FontSize",14);
ylabel("$\mathcal{S}^{*} = \sum_{t} |E[D(Z_{t})]|^{2} / \sigma_{t}$","Interpreter","latex","FontSize",14);