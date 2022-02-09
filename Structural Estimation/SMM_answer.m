function [ssd] = SMM_answer(p,data,N,N_sim,W,wr)
% calculate the sum of squared difference between data and simulated data
% moments
%   inputs: p - parameters
%           r - discountrate
%           data - data matrix
%           N - number of obs 
%           N_sim - number of obs to simulate
%           W - weighting matrix
%   outputs: ssd - sum of squared difference of moments

% get g function
g = g_function_sim_answer(p,N_sim,data,wr);

% calculates ssd
ssd = ((1./N).*sum(g,2))'*W*((1./N).*sum(g,2));

end

