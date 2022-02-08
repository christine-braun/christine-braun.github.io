%   File: SE3_main_answer.m
%   Purpose: estimate duration data through GMM following
%            structural estimation lectures
%
%==========================================================================

%% Data 4: Part 1 - GMM with W = identity matrix

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data4.csv');

% create number of observations vector
N = [size(data,1);size(data(data(:,1)==1),1);size(data(data(:,1)==0),1);size(data(data(:,1)==0),1);size(data(data(:,1)==0),1)];

% find estimate of reservation wage
wR_hat = min(data(data(:,3)>0,3));

% create the lower bound for the parameters
lb = [0,0,-inf,0];

% weighting matix
W1 = eye(5);

% set an initial guess
init_guess = [1,1,0.5,0.5];

% test to make sure g_function works and returns a (5 X 10000) matrix
g_test = g_function_answer(init_guess,data,wR_hat);

% estimate
[GMM_ests1,ssd1] = fmincon(@(p) GMM_answer(p,wR_hat,W1,data,N),init_guess,[],[],[],[],lb);

% Find Jacobian for standard error
J1 = jacobianest(@(p) (1./N).*sum(g_function_answer(p,data,wR_hat),2),GMM_ests1);

% caluclate Omega matrix
g1_est = g_function_answer(GMM_ests1,data,wR_hat);
Omega_hat = (1./N).*(g1_est*g1_est');

% standard error 
std1 =sqrt(diag((J1'*W1*J1)^(-1)*J1'*W1*Omega_hat*W1*J1*(J1'*W1*J1)^(-1))./10000);

%%  Part 2 - Calculate efficient weighting matrix and re-estimate

% find efficient weighting matrix 
W2 = ((1./N).*(g1_est*g1_est'))^(-1);

% estimate with efficient weighting matrix
[GMM_ests2,ssd2] = fmincon(@(p) GMM_answer(p,wR_hat,W2,data,N),GMM_ests1,[],[],[],[],lb);
J2 = jacobianest(@(p) (1./N).*sum(g_function_answer(p,data,wR_hat),2) ,GMM_ests2);

% calculate omega matrix
g2_est = g_function_answer(GMM_ests2,data,wR_hat);
Omega2_hat = (1./N).*(g2_est*g2_est');

% standard errors 
std2 =sqrt(diag((J2'*W2*J2)^(-1)*J2'*W2*Omega2_hat*W2*J2*(J2'*W2*J2)^(-1))./10000); 

% find estimate of b
b_est = wR_hat - (GMM_ests2(1)./(0.05+GMM_ests2(2)).*integral(@(w) (w - wR_hat).*lognpdf(w,GMM_ests2(3),GMM_ests2(4)),wR_hat,inf));


