function [loglikeval] = loglike5_EM_answer(p,data,pi_hat)
% Log likelihood function for data 1 
%   inputs: p - paramerters of weibull alpha & beta 
%           data - matrix of data
%   outputs: loglikeval - the negative value of the likelihood function

% assign parameters
alpha = p(1);
v1 = p(2);
v2 = p(3);
v3 = p(4);
pi1 = p(5);
pi2 = p(6);
pi3 = p(7);
beta = p(8:end);

% assign estimated probabilities
pi1_hat = pi_hat(:,1);
pi2_hat = pi_hat(:,2);
pi3_hat = pi_hat(:,3);

% assign data
t = data(:,1);
x = data(:,2:end);

% individual contribution
f1 =  v1.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v1.*exp(x*beta').*(t.^alpha));
f2 =  v2.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v2.*exp(x*beta').*(t.^alpha));
f3 =  v3.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v3.*exp(x*beta').*(t.^alpha));

%likelihood function
loglikeval = -sum(pi1_hat.*log(f1)+pi1_hat.*log(pi1) + pi2_hat.*log(f2)+pi2_hat.*log(pi2) + pi3_hat.*log(f3)+pi3_hat.*log(pi3));
end

