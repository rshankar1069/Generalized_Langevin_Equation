function [MSD] = meanSquareDisp(Xt)
    N = size(Xt,2);
    MSD = zeros(1,N);
    for i=1:(N)
        y = Xt(:,i)- Xt(:,1);
        MSD(i) = mean(y.^2);
    end
end

