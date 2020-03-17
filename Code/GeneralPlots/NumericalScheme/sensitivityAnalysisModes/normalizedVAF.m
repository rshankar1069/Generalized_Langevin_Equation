%% Function to calculate the Normalized VAF

function [normVAF] = normalizedVAF(Vt,Nt)
normVAF = zeros(1,Nt+1);
for i=1:(Nt+1)
    normVAF(:,i) = mean(Vt(:,i).*Vt(:,1),1)/mean(Vt(:,1).*Vt(:,1),1);
end
end