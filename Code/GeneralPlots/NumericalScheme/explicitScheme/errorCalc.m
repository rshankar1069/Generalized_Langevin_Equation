%% Function to calculate the error in sampling the data

function [stderr] = errorCalc(Vt)
stderr = std(Vt,0,1);
end
