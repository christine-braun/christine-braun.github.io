function [data] = simulate_data_answer(p,N_sim,wr)
% Simulate data from search model using parameters p
%   inputs: p - vector of parameters
%           N - number of observations to estimate
%   outputs: data = [unemployment dummy, unemp. dur., wage, emp. dur.]

% set seed
rng(7890);

% assign parameters
lambda = p(1);
delta = p(2);
mu = p(3);
sigma = p(4);

% wage distributions
F = @(w) logncdf(w,mu,sigma);

% unemployment rate
urate = delta./(delta + lambda.*(1-F(wr)));

% unemployed draw
udraw = unifrnd(0,1,N_sim,1);
unemp = udraw < urate;

% unemployment duration
tudraw = unifrnd(0,1,N_sim,1);
tu = expinv(tudraw,1./(lambda.*(1-F(wr))));
tu(unemp==0) = 0;

% wage draw
wdraw = unifrnd(F(wr),1,N_sim,1);
w = logninv(wdraw,mu,sigma);
w(unemp==1) = 0;

% employment duration
tedraw = unifrnd(0,1,N_sim,1);
te = expinv(tedraw,1./delta);
te(unemp==1) = 0;

% create data matrix
data = [unemp,tu,w,te];
end

