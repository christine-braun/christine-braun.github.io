function [loglikeval] = loglike1_answer(h,t)
% Log likelihood function for data 1 
%   inputs: h - hazard rate 
%           t - data on unemployment duration 
%   outputs: loglikeval - the negative value of the likelihood function

loglikeval = -sum(log(h.*exp(-h.*t)));
end

