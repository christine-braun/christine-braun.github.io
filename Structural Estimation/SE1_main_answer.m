%   File: SE1_main_answer.m
%   Purpose: estimate duration data through maximum likelihood following
%            structural estimation lectures
%
%==========================================================================

%% Data 1

% read in data (make sure the csv file is in the same director as this
% file)
t = csvread('data1.csv');

% create the lower bound for the parameters
lb = 0;

% set an initial guess
init_guess = 0.3;

% estimate
[ests1,loglikeval1,~,~,~,~,H1] = fmincon(@(h) loglike1_answer(h,t),init_guess,[],[],[],[],lb);

% standard error
str1 = sqrt(diag(H1^(-1)));

%% Data 2

% read in data (make sure the csv file is in the same director as this
% file)
data2 = csvread('data2.csv');

% find consistent estimator of reservation wage
wR_hat = min(data2(data2(:,3)>0,3));

% create lower bound for parameters (should be a vector of 4 values, make
% sure they are in the same order as you have them in the likelihood
% function)
lb = [0,-inf,0,0];

% set an initial guess
init_guess = [0.3,1,0.2,8];

% estimate 
[ests2,loglikeval2,~,~,~,~,H2] = fmincon(@(p) loglike2_answer(p,data2,wR_hat),init_guess,[],[],[],[],lb);

% standard error
str2 = sqrt(diag(H2^(-1)));

% find estimate of b
b_est = wR_hat - (ests2(1)./(0.05+ests2(4)).*integral(@(w) (w - wR_hat).*lognpdf(w,ests2(2),ests2(3)),wR_hat,inf));
