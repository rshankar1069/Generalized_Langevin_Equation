%% Input file for the GLE Simulation - Explicit Euler Scheme

kB = physconst("Boltzmann");                % Boltzmann constant
Temp = 300;                                 % Temperature (in Kelvin)
T = 10;                                     % Total time for which the simulation is run
Np = 100;                                    % Number of particles considered for the simulation
Nt = 10000;                                 % Number of time steps to consider
del_t = T/Nt;                               % Time-step size used in the Euler scheme
d = 1;                                      % Number of spatial dimensions to consider for each particle
Nk = 1;                                     % Number of modes to consider for the Prony Series
m = 1;                                      % Mass of one individual particle
M = m*eye(d*Np,d*Np);                       % Mass matrix involving all the particles
S = zeros(d*Np,Nk);                         % Initial value of the composite variable

velmag = 0.01;                               % Velocity Magnitude Scaling
Vt = velmag*ones(d*Np,Nt+1);                % Velocity matrices for all time steps, particles and dimensions
Xt = zeros(d*Np,Nt+1);                      % Position matrices for all time steps, particles and dimensions

randn('seed',100);                          % Seeding the random number generator to generate the same set of numbers

% Fc = 0 (No Conservative Force acting on the particles)

freq = 1;
%Fc = @(x) -M*freq^2*x;
Fc = @(x) 0*x;

% For the simplified model we consider Tau = 0.5 and c = 0.5

Tau = 1;
c = 1;

for i=2:(Nt+1)
    del_W = sqrt(del_t)*randn(d*Np,Nk);         % Random number generation for the Wiener Process
    Vt(:,i) = (M\Fc(Xt(:,i-1)))*del_t ...
            + (M\sum(S,2))*del_t ...
            + Vt(:,i-1);                        % Velocity Update Step
    S = S + (1/Tau)*S*del_t ...
        - (c/Tau)*repmat(Vt(:,i-1),1,Nk)*del_t ...
        + (1/Tau)*sqrt(2*kB*Temp*c)*del_W;      % Composite variable Update Step
    Xt(:,i) = Xt(:,i-1) + Vt(:,i-1)*del_t;      % Position Update Step
end

% Normalized VAF calculation

normVAF = zeros(1,Nt+1);

for i=1:(Nt+1)
    normVAF(:,i) = mean(Vt(:,i).*Vt(:,1),1)/mean(Vt(:,1).*Vt(:,1),1);
end

figure(1);
hold on;
plot(linspace(0,T,Nt+1),Xt,"LineWidth",2,"Color","k","LineStyle",":");
plot(linspace(0,T,Nt+1),Vt,"LineWidth",2,"Color","r","LineStyle",":");
xlabel("$t$","Interpreter","latex","FontSize",14);
title("Explicit Euler Integration Scheme","Interpreter","latex","FontSize",16);

figure(2);
plot(linspace(0,T,Nt+1),normVAF/max(abs(normVAF)),"LineWidth",2,"Color","b");