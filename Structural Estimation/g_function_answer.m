function [g] = g_function_answer(p,data,wr)
% the moment function 
%   inputs: p - parameters
%           data - matrix of observed data
%           wr - estimate of reservation wage
%   outputs: g - matrix (m X N) where m is the number of moments
%                    E[g] = 0

% assign parameters
lambda = p(1);
delta = p(2);
mu = p(3);
sigma = p(4);

% assign data
u = data(:,1);
tu = data(:,2);
w = data(:,3);
te = data(:,4);

% wage distributuion
F = @(w) logncdf(w,mu,sigma);
f = @(w) lognpdf(w,mu,sigma);

% create moments
urate = delta./(delta + lambda.*(1-F(wr)));
uduration = 1./(lambda.*(1-F(wr)));
eduration = 1./delta;
ExpWage = exp(mu+(sigma.^2)./2).*(normcdf((mu+sigma.^2-log(wr))./sigma)./(1-normcdf((log(wr)-mu)./sigma)));
ExpWage2 = exp(2.*mu+2.*(sigma.^2)).*(normcdf((mu+2.*sigma.^2-log(wr))./sigma)./(1-normcdf((log(wr)-mu)./sigma)));

% create g vector
g = [u - urate,tu-uduration,te-eduration,w-ExpWage,(w.^2) - ExpWage2];
g(tu==0,2) = 0;
g(w==0,3) = 0;
g(w==0,4) = 0;
g(w==0,5) = 0;
g = g';

end

