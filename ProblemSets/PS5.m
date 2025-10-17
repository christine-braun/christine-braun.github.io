%% EC9A2 Problem Set 5 - Stochastic Growth Model
% Value Function Iteration Solution


%% Parameters
beta = 0.99;        % Discount factor
sigma = 2;          % Risk aversion
alpha = 0.33;       % Capital share
delta = 0.025;      % Depreciation rate
A_L = 0.95;         % Low TFP
A_H = 1.05;         % High TFP

% Transition matrix
pi_LL = 0.9;
pi_HH = 0.9;

%% Setup capital grid
% First compute deterministic steady state as reference
A_mean = 0.5*A_L + 0.5*A_H;  % Unconditional mean
k_ss_det = 

% Create capital grid
n_k = 500;                          % Number of grid points
k_min = 0.5 * k_ss_det;             % Lower bound
k_max = 1.5 * k_ss_det;             % Upper bound
k_grid = linspace(k_min, k_max, n_k)';

%% Value Function Iteration Setup
max_iter = 2000;            % Maximum iterations
tol = 1e-6;                 % Convergence tolerance

% Initialize value functions (guess)
V_H = zeros(n_k, 1);        % Value function in high state
V_L = zeros(n_k, 1);        % Value function in low state

% Initialize policy functions
g_k_H = zeros(n_k, 1);      % Policy function for capital in high state
g_k_L = zeros(n_k, 1);      % Policy function for capital in low state

g_c_H = zeros(n_k, 1);      % Policy function for consumption in high state
g_c_L = zeros(n_k, 1);      % Policy function for consumption in low state

% Utility function
u = 

% Production function high productivity
f_H = 

% Production function low productivity
f_L = 

%% Value Function Iteration

for iter = 1:max_iter
    V_H_old = V_H;
    V_L_old = V_L;
    
    % Loop over current capital stock
    for i = 1:n_k
        
        %% High productivity state
        c_H = 
        
        % - Find maximum
        [V_H(i),max_idx_H] = 
        % - Store optimal policy functions
        g_k_H(i) =
        g_c_H(i) = 
       
        
        %% Low productivity state
        c_L =
        
        % - Find maximum
        [V_L(i),max_idx_L] = 
        % - Store optimal policy functions
        g_k_L(i) =
        g_c_L(i) = 
        
    end
    
    % Check convergence
    diff_H = max(abs(V_H - V_H_old));
    diff_L = max(abs(V_L - V_L_old));
    diff = max(diff_H, diff_L);
   
end


%% Find Target Capital
% High productivity target capital
tar_idx_H = 
k_tar_H = 

% Low productivity target capital
tar_idx_L = 
k_tar_L =

%% Plot Value Functions

% value functions
plot(  )
xlabel('Captial (k)');
ylabel('Value Function');
title('Value Functions');
legend('V^H(k) - High Productivity', 'V^L(k) - Low Productivity','Location', 'best', 'FontSize', 11);

% ploicy functions
plot(  )
xlabel('Captial (k)');
ylabel('g_k');
title('Capital Policy Functions');
legend('g_k^H(k) - High Productivity', 'g_k^L(k) - Low Productivity','Location', 'best', 'FontSize', 11);



%% Simulation (Question 2c)

rng(123);  % Set random seed
T = 200;   % Simulation periods

% Initialize arrays
k_sim = zeros(T+1, 1);
A_sim = zeros(T+1, 1);
y_sim = zeros(T, 1);
c_sim = zeros(T, 1);
i_sim = zeros(T, 1);

% Start from low productivity steady state
k_sim(1) = k_tar_L;
A_sim(1) = A_L;
state_sim = ones(T, 1);  % 1 = Low, 2 = High

% Simulate TFP shocks
for t = 1:T
    % Draw random number in [0,1] 
    % We will use this to compare to the transition probabilities to
    % determine if we are staying in the state we are in to switching states
    u = rand();
    
    if state_sim(t) == 1  % Currently in low state
        if  %(write the condition here for if we stay in low, i.e. compare u to p_LL)  % Stay in low
            state_sim(t+1) =  
            A_sim(t+1) = 
        else  % Switch to high
            state_sim(t+1) =   
            A_sim(t+1) = 
        end
    else   % Currently in high state
        if  %(write the condition here for if we stay in high, i.e. compare u to p_HH)  % Stay in high
            state_sim(t+1) = 
            A_sim(t+1) = 
        else  % Switch to low
            state_sim(t+1) =  
            A_sim(t+1) = 
        end
    end
end

% Simulate economy using policy functions
for t = 1:T
    % Interpolate to find optimal k'
    if state_sim(t) == 1
        k_sim(t+1) = interp1(  );
    else
        k_sim(t+1) = interp1(  );
    end
    
    % Compute other variables
    y_sim(t) = 
    i_sim(t) = 
    c_sim(t) = 
end

%% Plot simulation results

% output
plot(  );
xlabel('Time');
ylabel('Output');
title('Output');

% consumption
plot(  );
xlabel('Time');
ylabel('Consumption');
title('Consumption');

% investment
plot(  );
xlabel('Time');
ylabel('Investment');
title('Investment');

% capital
plot(  );
xlabel('Time');
ylabel('Capital');
title('Capital');

%% Compute statistics (Question 2d)

% Means
fprintf('\nMeans:\n');
fprintf('Output:      %.4f\n', mean(   ));
fprintf('Consumption: %.4f\n', mean(   ));
fprintf('Investment:  %.4f\n', mean(   ));

% Standard deviations
fprintf('\nStandard Deviations:\n');
fprintf('Output:      %.4f\n', std(   ));
fprintf('Consumption: %.4f\n', std(   ));
fprintf('Investment:  %.4f\n', std(   ));

% Correlations
fprintf('\nCorrelations:\n');
corr_yc = corr(  );
corr_yi = corr(  );
fprintf('Corr(Y, C):  %.4f\n', corr_yc);
fprintf('Corr(Y, I):  %.4f\n', corr_yi);

% Autocorrelation of output
corr_yy = corr(  );
fprintf('Autocorr(Y): %.4f\n', corr_yy);
