%% Function to calculate the Normalized VAF

function [normVAF] = normalizedVAFMatrix(Vt,Nt)
    Np = size(Vt,1);
    normVAF = zeros(Np,Nt+1);
    for i=1:(Nt+1)
        normVAF(:,i) = (Vt(:,i).*Vt(:,1))./(Vt(:,1).*Vt(:,1));
    end
end