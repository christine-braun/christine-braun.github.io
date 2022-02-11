%   File: SE4_main_answer.m
%   Purpose: estimate duration data through SMM following
%            structural estimation lectures
%
%==========================================================================

%% Data 4: Part 1 - simulate data and check against theoretical moments

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data4.csv');

% find estimate of reservation wage
wR_hat = min(data(data(:,3)>0,3));

% choose some values of the parameters
lambda_guess = 0.7;
delta_guess = 0.2;
mu_guess = 1;
sigma_guess = 0.5;

guess = [lambda_guess,delta_guess,mu_guess,sigma_guess];

% number of observations to simulate
Ns = 10000;

% simulate data
data_sim = simulate_data_answer(guess,Ns,wR_hat);

% theoretical moments using guessed values
urate_theory = delta_guess./(delta_guess + lambda_guess.*(1-logncdf(wR_hat,mu_guess,sigma_guess)));
udur_theory = 1./(lambda_guess.*(1-logncdf(wR_hat,mu_guess, sigma_guess)));
edur_theory = 1./delta_guess;
expWage_theory = exp(mu_guess + sigma_guess.^2./2).*normcdf((mu_guess + sigma_guess.^2 - log(wR_hat))./sigma_guess)./(1-normcdf((log(wR_hat)-mu_guess)./sigma_guess));

% data moments
urate_sim = mean(data_sim(:,1));
udur_sim = mean(data_sim(data_sim(:,1)==1,2));
edur_sim = mean(data_sim(data_sim(:,1)==0,4));
expWage_sim = mean(data_sim(data_sim(:,1)==0,3));

%% Data 4: Part 2 - SMM with W = identity matrix

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data4.csv');

% calculate sample means of moments 
u = mean(data(:,1));
tu = mean(data(data(:,1)==1,2));
w = mean(data(data(:,1)==0,3));
te = mean(data(data(:,1)==0,4));
w2 = mean(data(data(:,1)==0,3).^2);

% create number of observations vector
N = [size(data,1);size(data(data(:,1)==1),1);size(data(data(:,1)==0),1);size(data(data(:,1)==0),1);size(data(data(:,1)==0),1)];

% find estimate of reservation wage
wR_hat = min(data(data(:,3)>0,3));

% create the lower bound for the parameters
lb = [0,0,-inf,0];
ub = [10,inf,inf,inf];

% weighting matix
W1 = eye(5)./[u,tu,te,w,w2];

% set an initial guess
init_guess = [1,1,0.5,0.5];

% estimate
[SMM_ests1,ssd1] = fmincon(@(p) SMM_answer(p,data,N,Ns,W1,wR_hat),init_guess,[],[],[],[],lb,ub);

% Find Jacobian for standard error
J1 = jacobianest(@(p) (1./N).*sum(g_function_sim_answer(p,Ns,data,wR_hat),2),SMM_ests1);

% caluclate Omega matrix
g1_est = g_function_sim_answer(SMM_ests1,Ns,data,wR_hat);
Omega_hat = (1./N).*(g1_est*g1_est');

% standard error 
std1 =sqrt(diag((J1'*W1*J1)^(-1)*J1'*W1*Omega_hat*W1*J1*(J1'*W1*J1)^(-1))./10000);

%%  Part 3 - Calculate efficient weighting matrix and re-estimate

% find efficient weighting matrix 
W2 = ((1./N).*(g1_est*g1_est'))^(-1);

% estimate with efficient weighting matrix
[SMM_ests2,ssd2] = fmincon(@(p) SMM_answer(p,data,N,Ns,W1,wR_hat),SMM_ests1,[],[],[],[],lb,ub);
J2 = jacobianest(@(p) (1./N).*sum(g_function_sim_answer(p,Ns,data,wR_hat),2) ,SMM_ests2);

% calculate omega matrix
g2_est = g_function_sim_answer(SMM_ests2,Ns,data,wR_hat);
Omega2_hat = (1./N).*(g2_est*g2_est');

% standard errors 
std2 =sqrt(diag((J2'*W2*J2)^(-1)*J2'*W2*Omega2_hat*W2*J2*(J2'*W2*J2)^(-1))./10000); 

% find estimate of b
b_est = wR_hat - (SMM_ests2(1)./(0.05+SMM_ests2(2)).*integral(@(w) (w - wR_hat).*lognpdf(w,SMM_ests2(3),SMM_ests2(4)),wR_hat,inf));


