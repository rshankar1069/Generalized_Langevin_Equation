%% Input file for the GLE Simulation - Explicit Euler Scheme
function [params] = inputParameters(noModes,nominalOpt)
    params.kB = physconst("Boltzmann");                                     % Boltzmann constant
    params.Temp = 1e-6/params.kB;                                                      % Temperature (in Kelvin)
    params.T = 100;                                                          % Total time for which the simulation is run
    params.Np = 100;                                                       % Number of particles considered for the simulation
    params.Nt = 10000;                                                       % Number of time steps to consider
    params.del_t = params.T/params.Nt;                                      % Time-step size used in the Euler scheme
    params.d = 1;                                                           % Number of spatial dimensions to consider for each particle
    if(nominalOpt == 1)
        params.Nk = noModes+1;                                                          % Number of modes to consider for the Prony Series
    elseif(nominalOpt == 0)
        params.Nk = noModes+1;
    end
    params.m = 1;                                                           % Mass of one individual particle
    params.M = params.m*eye(params.d*params.Np,params.d*params.Np);         % Mass matrix involving all the particles
    params.S = zeros(params.d*params.Np,params.Nk);                         % Initial value of the composite variable

    params.posmag = 0.00;                                                   % Position Magnitude Scaling
    params.velmag = 0.01;                                                   % Velocity Magnitude Scaling
    params.Vt = params.velmag*ones(params.d*params.Np,params.Nt+1);         % Velocity matrices for all time steps, particles and dimensions
    params.Xt = params.posmag*ones(params.d*params.Np,params.Nt+1);         % Position matrices for all time steps, particles and dimensions
    params.forceopt = 1;                                                    % Option to choose the option for the conservative force

    params.NEps = 5;
    params.EPS = logspace(0,-params.NEps,params.NEps+1);                    % Perturbation parameter for sensitivity analysis
    params.Gamma = 1;                                                       % Gamma value used for Harmonic Potential Well
    params.Lambda = 0.5;                                                    % Lambda value used for Harmonic Potential Well
    
    if(nominalOpt == 1)
        [params.c,params.Tau] = ...
        parameterFitting(params.Nk-1,params.Gamma,params.Lambda,params.T,params.Nt);           % Parameter fitting for Memory Kernel resulting from Simple Harmonic Oscillator
        params.c(end+1) = 0;
        params.Tau(end+1) = 1;
    elseif(nominalOpt == 0)
        [params.c,params.Tau] = ...
        parameterFitting(params.Nk,params.Gamma,params.Lambda,params.T,params.Nt);           % Parameter fitting for Memory Kernel resulting from Simple Harmonic Oscillator
    end
end