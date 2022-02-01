function [loglikeval] = loglike5_answer(p,data)
% Log likelihood function for data 1 
%   inputs: p - paramerters of weibull alpha & beta 
%           t - data on unemployment duration 
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

% assign data
t = data(:,1);
x = data(:,2:end);

% individual contribution
f1 =  v1.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v1.*exp(x*beta').*(t.^alpha));
f2 =  v2.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v2.*exp(x*beta').*(t.^alpha));
f3 =  v3.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v3.*exp(x*beta').*(t.^alpha));

%likelihood function
loglikeval = -sum(log(pi1.*f1 + pi2.*f2 + pi3.*f3))
end

