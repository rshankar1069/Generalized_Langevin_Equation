function [Delta_central] = centralDifference(params,index,couplingOpt)

%     epsilon = params.EPS;
    epsilon = 0.01;
    NSamples = 10000;
    for i=1:NSamples
        for k=1:length(epsilon)
            if(couplingOpt == 1)
                % Forward Perturbation
                params.c(index) = params.c(index) + epsilon(k);
                [~,~,VAF_plus,MSD_plus] = splittingScheme(params,i);

                % Backward Perturbation
                params.c(index) = params.c(index) - 2*epsilon(k);
                [~,~,VAF_minus,MSD_minus] = splittingScheme(params,i);
            elseif(couplingOpt == 0)
                % Forward Perturbation
                params.c(index) = params.c(index) + epsilon(k);
                [~,~,VAF_plus,MSD_plus] = splittingScheme(params,i);

                % Backward Perturbation
                params.c(index) = params.c(index) - 2*epsilon(k);
                [~,~,VAF_minus,MSD_minus] = splittingScheme(params,i*2.5);
            end

            % Resetting the c value to original fit
            params.c(index) = params.c(index) + epsilon(k);

            % Calculating Central Difference for the sensitivity Analysis
            Delta_central.MSD(i,k) = (MSD_plus(end) - MSD_minus(end))/(2*epsilon(k));
%             Delta_central.VAF(i,k) = (VAF_plus(end) - VAF_minus(end))/(2*epsilon(k));
%             Delta_central.VAF(i,:) = (VAF_plus - VAF_minus)/(2*epsilon(k));
%             Delta_central.VAF(i,:) = (VAF_plus - VAF_minus);
            Delta_central.VAF(i,:) = (VAF_plus - VAF_minus)/(2*epsilon(k));
        end
        fprintf("+++ Iteration %d +++\n",i);
    end
    
end