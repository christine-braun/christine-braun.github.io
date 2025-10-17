%% Ramsey Model with Discrete Labor Choice
% This code solves the Ramsey growth model where households can choose
% to work (h = h_bar) or not work (h = 0)

%% 1. Parameters
beta = 0.96;      % Discount factor
sigma = 2.0;      % Risk aversion
alpha = 0.33;     % Capital share
delta = 0.1;     % Depreciation rate
h_bar = 0.7;      % Hours worked when working
chi = 1.3;        % Disutility of work

%% 2. Numerical setup
N = 200;                    % Number of grid points
k_min = 0.1;               % Minimum capital
k_max = 12;                % Maximum capital
k_grid = linspace(k_min, k_max, N)'; % Capital grid

tol = 1e-6;                % Convergence tolerance
max_iter = 1000;           % Maximum iterations

%% 3. Initialize value function and policy functions
V = zeros(N, 1);           % Value function
V_W = zeros(N, 1);         % Value when working
V_N = zeros(N, 1);         % Value when not working
g_k = zeros(N, 1);    % Capital policy function
g_h = zeros(N, 1);    % Labor policy function
g_c = zeros(N, 1);    % Consumption policy function

%% 4. Utility function

utility = @(c,h) 
%% 5. Value Function Iteration
for iter = 1:max_iter
    V_old = V;
    
    % Loop over current capital states
    for i = 1:N
        
        %============= IF WORKING ===========================
        % output
        output =
        % consumption
        c_W = 
        % value function
        [V_W(i),max_W_indx] = 
        % policy function
        g_k_W =
        % get consumption policy function
        g_c_W = 
        
        %============= IF NOT WORKING ========================
        % output
        output = 
        % consumption
        c_N = 
        % value function
        [V_N(i),max_N_indx] = 
        % policy function
        g_k_N = 
        % get consumption policy function
        g_c_N = 
        
        % Choose the better option


    end
    
    % Check convergence
    diff = max(abs(V - V_old));
    
end

%% 7. Find threshold capital level (where labor choice switches)
% Find where h_policy switches from 0 to h_bar
threshold_idx = 
k_bar = 

%% 8. Find steady state
% Steady state is where k' = k
ss_idx = 

k_ss = 
h_ss = 
c_ss = 
    
k_ss_theory = 

%% 9. Plotting

% value function
plot(  )
xlabel('Captial (k)');
ylabel('Value Function');
title('Value Functions');
legend('V^W','V^N','Location','SouthEast')

% capital
plot(  )
xlabel('Captial (k)');
ylabel('g_k');
title('Capital');

% labor
plot(   )
xlabel('Captial (k)');
ylabel('g_h');
title('Labor');


