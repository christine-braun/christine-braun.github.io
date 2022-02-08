%   File: SE3_main.m
%   Purpose: estimate duration data through GMM following
%            structural estimation lectures
%
%==========================================================================

%% Data 4: Part 1 - GMM with W = identity matrix

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data4.csv');

% create number of observations vector
N = 

% find estimate of reservation wage
wR_hat = 

% create the lower bound for the parameters
lb = 

% weighting matix
W = 

% set an initial guess
init_guess = 

% test to make sure g_function works and returns a (5 X 10000) matrix
g_test = g_function(init_guess,data,wR_hat);

% estimate
[GMM_ests1,ssd1] = fmincon( ,init_guess,[],[],[],[],lb);

% Find Jacobian for standard error
J1 = jacobianest( ,GMM_ests1);

% caluclate Omega matrix
g1_est = 
Omega_hat = 

% standard error 
std1 = 

%%  Part 2 - Calculate efficient weighting matrix

% find efficient weighting matrix 
W_hat = 

% estimate with efficient weighting matrix
[GMM_ests2,ssd2] = fmincon( ,GMM_ests1,[],[],[],[],lb);
J2 = jacobianest( ,GMM_ests2);

% calculate omega matrix
g2_est = g1(GMM_ests2,data4,wR_hat);
Omega2_hat = (1./Ns).*(g2_est*g2_est');

% standard errors 
std2 = 

% find estimate of b
b_est = 
