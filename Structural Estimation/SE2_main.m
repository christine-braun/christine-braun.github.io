%   File: SE2_main.m
%   Purpose: estimate duration data through maximum likelihood following
%            structural estimation lectures
%
%==========================================================================

%% Data 3: Part 1 - weibull hazard

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data3.csv');
t = data(:,1);

% create the lower bound for the parameters
lb = 

% set an initial guess
init_guess = 

% estimate
[ests3,loglikeval3,~,~,~,~,H3] = fmincon(@(p) loglike3(p,t),init_guess,[],[],[],[],lb);

% standard error
str3 = sqrt();

%% Data 3: Part 2 - weibull hazard with covariates

% create data matrix to input into likelihood fuction
finalData =

% create the lower bound for the parameters
lb = 

% set an initial guess
init_guess = 

% estimate
[ests4,loglikeval4,~,~,~,~,H4] = fmincon(@(p) loglike4(p,FinalData),init_guess,[],[],[],[],lb);

% standard error
str4 = sqrt();

%% Data 3: Part 3 - weibull hazard with covariates and mixing dist.

% create the lower bound for the parameters
lb = 

% create Aeq and beq matricies
Aeq = 
beq = 

% set an initial guess
init_guess = 

% estimate
[ests5,loglikeval5,~,~,~,~,H5] = fmincon(@(p) loglike5(p,FinalData),init_guess,[],[],Aeq,beq,lb);

% standard error
str5 = sqrt();