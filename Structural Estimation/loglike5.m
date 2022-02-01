function [loglikeval] = loglike5(p,data)
% Log likelihood function for data 1 
%   inputs: p - paramerters of weibull alpha & beta 
%           t - data on unemployment duration 
%   outputs: loglikeval - the negative value of the likelihood function

% assign parameters
alpha = 
nu1 = 

% assign data
t = data(:,1);


% individual contribution condition on nu
f1 =  nu1.*
f2 =  
f3 =  

%likelihood function
loglikeval = -sum()
end

