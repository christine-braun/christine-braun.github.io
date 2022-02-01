function [loglikeval] = loglike3_answer(p,t)
% Log likelihood function for data 1 
%   inputs: p - paramerters of weibull alpha & beta 
%           t - data on unemployment duration 
%   outputs: loglikeval - the negative value of the likelihood function

% assign parameters
alpha = p(1);

%likelihood function
loglikeval = -sum( log(alpha) + (alpha-1).*log(t) - (t).^alpha );
end

