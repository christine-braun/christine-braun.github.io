function [log_like] = log_like_GM_answer(p,x,pi_hat)
%Returns the value of the log likelihood function
%   inputs: p - parameters, x- data, pi_hat - estimated probailities
%   output: log_like - negative log likelihood value
%--------------------------------------------------------------------------

% assign parameters
mu1 = p(1);
sigma1 = p(2);
mu2 = p(3);
sigma2 = p(4);
pi = p(5);

% log likelihood function
log_like = -sum(pi_hat.*(log(max(normpdf(x,mu1,sigma1),eps)) + log(max(pi,eps))) + (1-pi_hat).*(log(max(normpdf(x,mu2,sigma2),eps)) + log(max(1-pi,eps))));
   
end

