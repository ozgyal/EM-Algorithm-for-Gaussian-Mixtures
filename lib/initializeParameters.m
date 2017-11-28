function [mu, sigma, alpha] = initializeParameters(data, componentNo)
%This function initializes parameters.

% Find cluster centers and assign them as initial means
[idx,C] = kmeans(data,componentNo);
mu = C;

% Initialize covariance matrix
for i=1:componentNo
	sigma(:,:,i) = eye(2);
end

% Initialize alpha
alpha = repmat(1/componentNo, componentNo,1);
end

