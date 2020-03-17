%% Function to calculate the Normalized PAF

function [normVAF] = normalizedPAF(Xt,Nt)
normVAF = zeros(1,Nt+1);
for i=1:(Nt+1)
    normVAF(:,i) = mean(Xt(:,i).*Xt(:,1),1)/mean(Xt(:,1).*Xt(:,1),1);
end
end