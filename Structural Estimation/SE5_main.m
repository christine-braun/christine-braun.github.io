%   File: SE5_main.m
%   Purpose: estimate mixture model using EM
%
%==========================================================================

%% Part 1 - Gausian Mixture model

% read in data (make sure the csv file is in the same director as this
% file)
data = csvread('data5.csv');

% inital guess
init_guess = 

% bounds
lb = 
ub = 

% estimate
diff = 1;
epsilon = 0.001;
while diff> epsilon
   % expectations
   pi_hat = 

   % maximization
   [ests1,loglikeval1,~,~,~,~,H1] = fmincon(@(p) log_like_GM_answer( ),init_guess,[],[],[],[],lb,ub);
   
   % difference
   diff = 
   
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
lb = 
ub = 

% create Aeq and beq matricies
Aeq = 
beq = 

% set an initial guess
init_guess = [1,0.2,0.4,2,1/3,1/3,1/3,0.07,0.01,0.02];

% estimate
diff = 1;
epsilon = 0.001;
while diff> epsilon
    
   % assign parameters
   alpha = init_guess(1);
   v1 = 

   % expectations
   pi1_hat = 
   pi2_hat = 
   pi3_hat = 
   
   % final pi matrix
   pi_hat = 
   
   % maximization
   [ests5_EM,loglikeval5_EM,~,~,~,~,H5_EM] = fmincon(@(p) loglike5_EM_answer( ),init_guess,[],[],Aeq,beq,lb);  
   
   % difference
   diff = 
   
   % reassign
   init_guess = ests5_EM;
end



