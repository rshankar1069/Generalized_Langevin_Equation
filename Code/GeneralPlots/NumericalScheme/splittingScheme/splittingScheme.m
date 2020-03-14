clear all; clc; close all;
%% Input file for the GLE Simulation - Explicit Euler Scheme

kB = physconst("Boltzmann");                % Boltzmann constant
Temp = 300;                                 % Temperature (in Kelvin)
T = 10;                                     % Total time for which the simulation is run
Np = 1000;                                  % Number of particles considered for the simulation
Nt = 1000;                                  % Number of time steps to consider
del_t = T/Nt;                               % Time-step size used in the Euler scheme
d = 1;                                      % Number of spatial dimensions to consider for each particle
Nk = 8;                                     % Number of modes to consider for the Prony Series
m = 1;                                      % Mass of one individual particle
M = m*eye(d*Np,d*Np);                       % Mass matrix involving all the particles
S = zeros(d*Np,Nk);                         % Initial value of the composite variable

posmag = 0.1;                              % Position Magnitude Scaling
velmag = 0.1;                              % Velocity Magnitude Scaling
Vt = velmag*ones(d*Np,Nt+1);                % Velocity matrices for all time steps, particles and dimensions
Xt = posmag*ones(d*Np,Nt+1);                % Position matrices for all time steps, particles and dimensions

randn('seed',100);                          % Seeding the random number generator to generate the same set of numbers

scalaropt= 'no';                           % Choose between 'yes'/'no' to decide on scalar or vector Tau and c
forceopt = 1;                               % Conservative force option 0/1 to choose between no force and harmonic oscillator force

switch(scalaropt)
    case 'yes'
        TauMag = 0.25;                                                  % Scaling value for Tau
        cMag = 0.25;                                                    % Scaling value for c
        Tau = TauMag*ones(Nk,1);                                        % Tau value used in the Prony series 
        c = cMag*ones(Nk,1);                                            % c value used in the Prony series
        theta = exp(-del_t./Tau);                                        % Theta value for the Splitting Scheme
        alpha = sqrt((1-theta).^2/del_t);                                % Alpha value for the Splitting Scheme
        for i=2:(Nt+1)
            del_W = sqrt(del_t)*randn(d*Np,Nk);                         % Random number generation for the Wiener Process
            Fc = conservativeForce(Xt(:,i-1),forceopt,M);               % Conservative Force Calculation
            Vt(:,i) = Vt(:,i-1) ...
            + (del_t/2)*(M\Fc) ...
            + (del_t/2)*(M\sum(S,2));                                   % Advance Velocity by Half Step
            Xt(:,i) = Xt(:,i-1) + del_t*Vt(:,i);                        % Advance Position by Full Step
            for k=1:Nk
                S(:,k) = theta(k)*S(:,k) ...
                - (1-theta(k))*c(k)*Vt(:,i) ...
                + alpha(k)*sqrt(2*kB*Temp*c(k))*del_W(:,k);             % Advance Composite variable by Full Step
            end              
            Vt(:,i) = Vt(:,i) ...
            + (del_t/2)*(M\Fc) ...
            + (del_t/2)*(M\sum(S,2));                                   % Advance Velocity by Half Step
        end
    case 'no'
        rand('seed',100);                                               % Seeding the Uniform distribution
        if(forceopt == 0)
            Tau = rand(Nk,1);                                           % Tau value used in the Prony series 
            c = rand(Nk,1);                                             % c value used in the Prony series
        elseif(forceopt == 1)
            Gamma = 1;                                                  % Gamma value used for Harmonic Potential Well
            Lambda = 0.5;                                               % Lambda value used for Harmonic Potential Well
            [c,Tau] = parameterFitting(Nk,Gamma,Lambda,T,Nt);
        else
            disp('Force option not set');
            exit(1);
        end
        theta = exp(-del_t./Tau);                                       % Theta value for the Splitting Scheme
        alpha = sqrt((1-theta).^2/del_t);                               % Alpha value for the Splitting Scheme
        for i=2:(Nt+1)
            del_W = sqrt(del_t)*randn(d*Np,Nk);                         % Random number generation for the Wiener Process
            Fc = conservativeForce(Xt(:,i-1),forceopt,M);               % Conservative Force Calculation
            Vt(:,i) = Vt(:,i-1) ...
            + (del_t/2)*(M\Fc) ...
            + (del_t/2)*(M\sum(S,2));                                   % Advance Velocity by Half Step
            Xt(:,i) = Xt(:,i-1) + del_t*Vt(:,i);                        % Advance Position by Full Step
            for k=1:Nk
                S(:,k) = theta(k)*S(:,k) ...
                - (1-theta(k))*c(k)*Vt(:,i) ...
                + alpha(k)*sqrt(2*kB*Temp*c(k))*del_W(:,k);             % Advance Composite variable by Full Step
            end              
            Vt(:,i) = Vt(:,i) ...
            + (del_t/2)*(M\Fc) ...
            + (del_t/2)*(M\sum(S,2));                                   % Advance Velocity by Half Step
        end
    otherwise
        disp('Invalid Option');
        quit(1);
end

% Normalized VAF calculation

normVAF = normalizedVAF(Vt,Nt);

% Position Correlation Function

normPAF = normalizedPAF(Xt,Nt);

% Error Bar Calculation

stderr = errorCalc(Vt);

% Mean Square Displacement (MSD) of Particles

MSD = meanSquareDisp(Xt);

Plot;