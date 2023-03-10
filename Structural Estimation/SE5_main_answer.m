%   File: SE5_main_answer.m
%   Purpose: estimate mixture model using EM
%
%==========================================================================

%% Part 1 - Gausian Mixture model

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data5.csv');

% inital guess
init_guess = [1,1,0,1,0.5];

% bounds
lb = [-inf,0,-inf,0,0];
ub = [inf,inf,inf,inf,1];

% estimate
diff = 1;
epsilon = 0.001;
while diff> epsilon
   % expectations
   pi_hat = init_guess(5).*normpdf(data,init_guess(1),init_guess(2))./(init_guess(5).*normpdf(data,init_guess(1),init_guess(2))+(1-init_guess(5)).*normpdf(data,init_guess(3),init_guess(4)));

   % maximization
   [ests1,loglikeval1,~,~,~,~,H1] = fmincon(@(p) log_like_GM_answer(p,data,pi_hat),init_guess,[],[],[],[],lb,ub);
   
   % difference
   diff = max(abs(ests1-init_guess))
   
   % reassign
   init_guess = ests1;
end

% standard errors
std1 = sqrt(diag(inv(H1)));

%% Part 2 - Mixed Proportional Hazard Model with EM Alogithm

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data3.csv');

% create data matrix to input into likelihood fuction
educDummy = dummyvar(data(:,3));
finalData = [data(:,1:2),educDummy(:,2:3)];

% assign data
t = finalData(:,1);
x = finalData(:,2:end);

% create the lower bound for the parameters
lb = [0,0,0,0,0,0,0,-inf,-inf,-inf];
ub = [inf,inf,inf,inf,1,1,1,inf,inf,inf];

% create Aeq and beq matricies
Aeq = [0,0,0,0,1,1,1,0,0,0];
beq = 1;

% set an initial guess
init_guess = [1,0.2,0.4,2,1/3,1/3,1/3,0.07,0.01,0.02];

% estimate
diff = 1;
epsilon = 0.001;
while diff> epsilon
    
   % assign parameters
   alpha = init_guess(1);
   v1 = init_guess(2);
   v2 = init_guess(3);
   v3 = init_guess(4);
   pi1 = init_guess(5);
   pi2 = init_guess(6);
   pi3 = init_guess(7);
   beta = init_guess(8:end);

   % expectations
   pi1_hat = pi1*v1.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v1.*exp(x*beta').*(t.^alpha));
   pi2_hat = pi2*v2.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v2.*exp(x*beta').*(t.^alpha));
   pi3_hat = pi3*v3.*exp(x*beta').*alpha.*(t.^(alpha-1)).*exp(-v3.*exp(x*beta').*(t.^alpha));
   
   % final pi matrix
   pi_hat = [pi1_hat./(pi1_hat+pi2_hat+pi3_hat),pi2_hat./(pi1_hat+pi2_hat+pi3_hat),pi3_hat./(pi1_hat+pi2_hat+pi3_hat)];
   
   % maximization
   [ests5_EM,loglikeval5_EM,~,~,~,~,H5_EM] = fmincon(@(p) loglike5_EM_answer(p,finalData,pi_hat),init_guess,[],[],Aeq,beq,lb);  
   
   % difference
   diff = max(abs(ests5_EM-init_guess))
   
   % reassign
   init_guess = ests5_EM;
end



