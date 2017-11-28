function [sigma] = updateSigma(data, mu, probComp, gaussCase, sampleNo)
%This function updates sigma according to gaussian's covariance type

    if gaussCase == 1    % If it is spherical
        sig = sum(sum((data - repmat(mu, sampleNo, 1)).^2, 2) .* probComp) ...  
              / (2 * sum(probComp)); 
        sigma = eye(2) * sig;
    elseif gaussCase == 2    % If it is diagonal
        sigma = eye(2);
        for k=1:2   % For d=2
            sigma(k,k) = sum(((data(:,k) - repmat(mu(:,k), sampleNo, 1)) .^ 2) ...
                .* probComp) / sum(probComp);
        end
    else    % If it is arbitrary
        temp = zeros(2,2,sampleNo);
        for i=1:sampleNo
           temp(:,:,i) = probComp(i) * (data(i,:) - mu)' * (data(i,:) - mu);
        end
        sigma = sum(temp,3) / sum(probComp);
    end
    
end

