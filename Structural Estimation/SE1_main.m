%   File: SE_main.m
%   Purpose: estimate duration data through maximum likelihood following
%            structural estimation lectures
%
%==========================================================================

%% Data 1

% read in data (make sure the csv file is in the same director as this
% file)
t = csvread('data1.csv');

% create the lower bound for the parameters
lb = 

% set an initial guess
init_guess = 

% estimate
[ests1,loglikeval1,~,~,~,~,H1] = fmincon(@(h) loglike1(h,t),init_guess,[],[],[],[],lb);

% standard error
str1 = sqrt();

%% Data 2

% read in data (make sure the csv file is in the same director as this
% file)
data2 = ;

% find consistent estimator of reservation wage
wR_hat = 

% create lower bound for parameters (should be a vector of 4 values, make
% sure they are in the same order as you have them in the likelihood
% function)
lb = 

% set an initial guess
init_guess = 

% estimate 
[ests2,loglikeval2,~,~,~,~,H2] = fmincon(@(p) loglike2(p,data2),init_guess,[],[],[],[],lb);

% standard error
str2 = sqrt();

