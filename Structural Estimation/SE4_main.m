%   File: SE4_main.m
%   Purpose: estimate duration data through SMM following
%            structural estimation lectures
%
%==========================================================================

%% Data 4: Part 1 - simulate data and check against theoretical moments

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data4.csv');

% find estimate of reservation wage
wR_hat = 

% choose some values of the parameters
lambda_guess = 
delta_guess = 
mu_guess = 
sigma_guess = 

guess = [lambda_guess,delta_guess,mu_guess,sigma_guess];

% number of observations to simulate
Ns = \

% simulate data
data_sim = simulate_data_answer();

% theoretical moments using guessed values
urate_theory = 
udur_theory = 
edur_theory = 
expWage_theory = 

% data moments
urate_sim = 
udur_sim = 
edur_sim = 
expWage_sim = 

%% Data 4: Part 2 - SMM with W = identity matrix

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data4.csv');

% calculate sample means of moments 
u = 
tu = 
w = 
te = 
w2 = 

% create number of observations vector
N = 

% find estimate of reservation wage
wR_hat = 

% create the lower bound for the parameters
lb = 

% weighting matix
W1 = 

% set an initial guess
init_guess = 

% estimate
[SMM_ests1,ssd1] = fmincon(@(p) SMM_answer(),init_guess,[],[],[],[],lb,ub);

% Find Jacobian for standard error
J1 = jacobianest( );

% caluclate Omega matrix
g1_est = g_function_sim_answer();
Omega_hat = 

% standard error 
std1 =

%%  Part 3 - Calculate efficient weighting matrix and re-estimate

% find efficient weighting matrix 
W2 = 

% estimate with efficient weighting matrix
[SMM_ests2,ssd2] = fmincon(@(p) SMM_answer(),SMM_ests1,[],[],[],[],lb,ub);
J2 = jacobianest();

% calculate omega matrix
g2_est = g_function_sim_answer();
Omega2_hat = 

% standard errors 
std2 =

% find estimate of b
b_est = 


