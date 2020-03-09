inputParams;

% Specify the index for the mode of 'c' to be perturbed

index = 1;
couplingOpt = 1;
Delta_Central_Coupled = centralDifference(params,index,couplingOpt);
couplingOpt = 0;
Delta_Central_Decoupled = centralDifference(params,index,couplingOpt);

Coupled_Variance = var(Delta_Central_Coupled.VAF.*(2*params.EPS),0,1);
Decoupled_Variance = var(Delta_Central_Decoupled.VAF.*(2*params.EPS),0,1);