%   File: SE2_main_answer.m
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
lb = [0];

% set an initial guess
init_guess = 1;

% estimate
[ests3,loglikeval3,~,~,~,~,H3] = fmincon(@(p) loglike3_answer(p,t),init_guess,[],[],[],[],lb);

% standard error
str3 = sqrt(diag(H3^(-1)));

%% Data 3: Part 2 - weibull hazard with covariates

% create data matrix to input into likelihood fuction
educDummy = dummyvar(data(:,3));
finalData = [data(:,1:2),educDummy(:,2:3)];

% create the lower bound for the parameters
lb = [0,-inf,-inf,-inf];

% set an initial guess
init_guess = [ests3,0,0,0];

% estimate
[ests4,loglikeval4,~,~,~,~,H4] = fmincon(@(p) loglike4_answer(p,finalData),init_guess,[],[],[],[],lb);

% standard error
str4 = sqrt(diag(H4^(-1)));

%% Data 3: Part 3 - weibull hazard with covariates and mixing dist.

% % create the lower bound for the parameters
% lb = 
% 
% % create Aeq and beq matricies
% Aeq = 
% beq = 
% 
% % set an initial guess
% init_guess = 
% 
% % estimate
% [ests5,loglikeval5,~,~,~,~,H5] = fmincon(@(p) loglike5(p,FinalData),init_guess,[],[],Aeq,beq,lb);
% 
% % standard error
% str5 = sqrt();