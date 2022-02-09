function [data] = simulate_data( )
% Simulate data from search model using parameters p
%   inputs: 
%   outputs: data = [unemployment dummy, unemp. dur., wage, emp. dur.]

% set seed
rng(8473);

% assign parameters
lambda = 

% wage distributions
F = @(w) 

% unemployed draw


% unemployment duration


% wage draw


% employment duration


% create data matrix
data = [unemp,tu,w,te];

end

