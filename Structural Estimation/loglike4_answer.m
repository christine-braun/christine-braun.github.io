function [loglikeval] = loglike4_answer(p,data)
% Log likelihood function for data 1 
%   inputs: p - paramerters of weibull alpha & beta 
%           t - data on unemployment duration 
%   outputs: loglikeval - the negative value of the likelihood function

% assign parameters
alpha = p(1);
beta = p(2:end);

% assign data
t = data(:,1);
x = data(:,2:end);

%likelihood function
loglikeval = -sum(  log(alpha) + x*beta' + (alpha-1).*log(t) - (t).^alpha.*exp(x*beta'));
end

