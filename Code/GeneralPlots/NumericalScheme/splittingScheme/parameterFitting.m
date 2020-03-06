function [c,Tau] = parameterFitting(Nk,Gamma,Lambda,T,Nt)
    del_t = T/Nt;

    %% Actual Memory Kernel for the Harmonic Potential

    t = logspace(floor(log10(del_t/10)),floor(log10(10*Nt*del_t)),Nt);
    MKactual = (Gamma/gamma(1-Lambda))*t.^(-Lambda);
    
    %% Prony Series Memory Kernel for the Harmonic Potential
    
    Tau = logspace(floor(log10(del_t/10)),floor(log10(10*Nt*del_t)),Nk);

    % Solving for Least Square Fitting of parameters
    t_mat = repmat(t',1,Nk);
    A_mat = (1./Tau).*exp(-t_mat./Tau);
    b_vec = MKactual';

    c = (A_mat'*A_mat)\(A_mat'*b_vec);
end