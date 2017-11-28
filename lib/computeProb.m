function [prob] = computeProb(data, compNo, mu, sigma, alpha)
%This function calculates the p(x|theta_j) for each component.
    % It returns a matrix named prob which includes probabilities 
    % of each sample given component.
    
    n = size(data,1);
    prob = zeros(n, compNo);
    for j=1:compNo
        prob(:,j) = alpha(j,:) * (mvnpdf(data, mu(j,:), sigma(:,:,j)));
    end
    
end