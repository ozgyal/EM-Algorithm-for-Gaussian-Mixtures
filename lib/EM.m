function [mu, sigma, alpha, logLH, ite, logLHArray] = EM(data, compNo, gaussCase, iteNo, mu, sigma, alpha)
%This function runs EM algorithm and finds final log likelihood and
%parameters.
    logLHArray = zeros(1,iteNo);
    logLHPrev = -inf;
    threshold = 0.01; % Stopping criterion 
    sampleNo = size(data,1);
    for ite=1:iteNo
        % Compute p(x|theta_j) for each component. 
        prob = computeProb(data, compNo, mu , sigma, alpha);
        
        % Compute log likelihood
        logLH = sum(log(sum(prob,2)));
        logLHArray(ite) = logLH;
        
        % Control the stopping criterion
        if((logLH - logLHPrev) < threshold)
            break;
        else
            logLHPrev = logLH;
        end
        
        % Update parameters if gaussians are not converged.
        % For each component
        for j=1:compNo
            % Calculate p(component|x_i,theta)
            probComp = prob(:,j) ./ sum(prob,2);
            
            % Update alpha 
            alpha(j,:) = mean(probComp);
            
            % Update mu
            mu(j,:) = (sum(data .* repmat(probComp, 1, 2))) / sum(probComp); 
           
            % Update sigma
            sigma(:,:,j) = updateSigma(data, mu(j,:), probComp, gaussCase, sampleNo);
        end       
    end
end
