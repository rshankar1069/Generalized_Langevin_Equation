clear all; clc; close all;
%% Input file for the GLE Simulation - Explicit Euler Scheme

kB = physconst("Boltzmann");                % Boltzmann constant
Temp = 300;                                 % Temperature (in Kelvin)
T = 10;                                     % Total time for which the simulation is run
Np = 1;                                  % Number of particles considered for the simulation
Nt = 100;                                  % Number of time steps to consider
del_t = T/Nt;                               % Time-step size used in the Euler scheme
d = 1;                                      % Number of spatial dimensions to consider for each particle
Nk = 1;                                     % Number of modes to consider for the Prony Series
m = 1;                                      % Mass of one individual particle
M = m*eye(d*Np,d*Np);                       % Mass matrix involving all the particles
S = zeros(d*Np,Nk);                         % Initial value of the composite variable

posmag = 0.01;
velmag = 0.01;                              % Velocity Magnitude Scaling
Vt = velmag*ones(d*Np,Nt+1);                % Velocity matrices for all time steps, particles and dimensions
Xt = posmag*ones(d*Np,Nt+1);                % Position matrices for all time steps, particles and dimensions

randn('seed',100);                          % Seeding the random number generator to generate the same set of numbers

scalaropt= 'yes';                           % Choose between 'yes'/'no' to decide on scalar/vector Tau and c
forceopt = 0;                               % Conservative force option 0/1 to choose between no force and harmonic oscillator force

switch(scalaropt)
    case 'yes'
        TauMag = 0.25;                                                     % Scaling value for Tau
        cMag = 0.25;                                                       % Scaling value for c
        Tau = TauMag*ones(Nk,1);                                        % Tau value used in the Prony series 
        c = cMag*ones(Nk,1);                                            % c value used in the Prony series
        for i=2:(Nt+1)
            del_W = sqrt(del_t)*randn(d*Np,Nk);                         % Random number generation for the Wiener Process
            Fc = conservativeForce(Xt(:,i-1),forceopt,M);               % Conservative Force Calculation
            Vt(:,i) = (M\Fc)*del_t ...
                    + (M\sum(S,2))*del_t ...
                    + Vt(:,i-1);                                        % Velocity Update Step
            for k=1:Nk
                S(:,k) = S(:,k) + S(:,k)*(1/Tau(k))*del_t ...
                - Vt(:,i-1)*(c(k)/Tau(k))*del_t ...
                + (1/Tau(k))*sqrt(2*kB*Temp*c(k))*del_W(:,k);           % Composite variable Update Step
            end              
            Xt(:,i) = Xt(:,i-1) + Vt(:,i-1)*del_t;                      % Position Update Step
        end
    case 'no'
        rand('seed',100);                                               % Seeding the Uniform distribution
        Tau = rand(Nk,1);                                               % Tau value used in the Prony series 
        c = rand(Nk,1);                                                 % c value used in the Prony series
        for i=2:(Nt+1)
            del_W = sqrt(del_t)*randn(d*Np,Nk);                         % Random number generation for the Wiener Process
            Fc = conservativeForce(Xt(:,i-1),forceopt,M);               % Conservative Force Calculation
            Vt(:,i) = (M\Fc)*del_t ...
                    + (M\sum(S,2))*del_t ...
                    + Vt(:,i-1);                                        % Velocity Update Step
            for k=1:Nk
                S(:,k) = S(:,k) + S(:,k)*(1/Tau(k))*del_t ...
                - Vt(:,i-1)*(c(k)/Tau(k))*del_t ...
                + (1/Tau(k))*sqrt(2*kB*Temp*c(k))*del_W(:,k);           % Composite variable Update Step
            end
            Xt(:,i) = Xt(:,i-1) + Vt(:,i-1)*del_t;                      % Position Update Step
        end
    otherwise
        disp('Invalid Option');
        quit(1);
end

% Normalized VAF calculation

normVAF = normalizedVAF(Vt,Nt);

% Error Bar Calculation

stderr = errorCalc(Vt);

Plot;