function [Xt,Vt,VAF,MSD] = splittingScheme(params,seed)
    % Reading the parameters from the structure
    del_t = params.del_t;
    Nt = params.Nt;
    d = params.d;
    Np = params.Np;
    Nk = params.Nk;
    forceopt = params.forceopt;
    M = params.M;
    
    kB = params.kB;
    Temp = params.Temp;
    c = params.c;
    Tau = params.Tau;
    
    Xt = params.Xt;
    Vt = params.Vt;
    S = params.S;
    
    randn('seed',seed);                                              % Seeding the random number generator to generate the same set of numbers
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
    
    MSD = meanSquareDisp(Xt);                                       % Mean Square Displacement
%     VAF = normalizedVAF(Vt,Nt);
    VAF = normalizedVAFMatrix(Vt,Nt);                               % Normalized Velocity Correlation Function

end