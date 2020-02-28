%% Function defined to calculate the conservative force acting on the particles

function [Fc] = conservativeForce(x,opt,M)

switch opt
    case 0
        Fc = 0*x;                   % No conservative force acting on the particles
    case 1
        freq = 1;                   % Frequency of the Harmonic Oscillating Potential
        Fc = -M*freq^2*x;           % Conservative force due to Harmonic Potential
    otherwise
        disp('Please specify any other Conservative force equation inside "conservativeForce.m"');
end

end
