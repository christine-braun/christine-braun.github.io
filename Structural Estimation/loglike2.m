function [loglikeval] = loglike2(p,finalData,wR)
% Log likelihood function for data 1 
%   inputs: p - vector of parameters
%           final Data - data matrix 
%   outputs: loglikeval - the negative value of the likelihood function

% extract parameters from vector p
lambda = p(1);

% extract data from data matrix
u = finalData(:,1);

% create wage distributuion function
G = @(w) logncdf(w,mu,sigma);
g = @(w) lognpdf(w,mu,sigma);

% create each part of the likelihood function
ln_unemp = log(lambda) + log(1-G(wR)) 
ln_emp = 

% final log likelihood value
loglikeval = -sum();

end
