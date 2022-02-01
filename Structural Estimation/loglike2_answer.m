function [loglikeval] = loglike2_answer(p,finalData,wR)
% Log likelihood function for data 1 
%   inputs: p - vector of parameters
%           final Data - data matrix 
%   outputs: loglikeval - the negative value of the likelihood function

% extract parameters from vector p
lambda = p(1);
mu = p(2);
sigma = p(3);
delta = p(4);

% extract data from data matrix
u = finalData(:,1);
t = finalData(:,2);
w = finalData(:,3);

% create wage distributuion function
G = @(w) logncdf(w,mu,sigma);
g = @(w) lognpdf(w,mu,sigma);

% create each part of the likelihood function
ln_unemp = log(lambda) + log(1-G(wR)) - lambda.*(1-G(wR)).*t + log(delta) - log(delta + lambda.*(1-G(wR)));
ln_emp = log(lambda) + log(1-G(wR)) + log(max(g(w),eps)) - log(1-G(wR)) - log(delta + lambda.*(1-G(wR)));

% final log likelihood value
loglikeval = -sum(u.*ln_unemp + (1-u).*ln_emp);

end
