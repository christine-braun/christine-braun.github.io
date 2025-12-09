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
utility = @(c,h) (c.^(1-sigma))./(1-sigma) - chi * h;

%% 5. Value Function Iteration
iter = 0;
diff = inf;

while diff > tol && iter < max_iter
    iter = iter + 1;
    V_old = V;
    
    % Loop over current capital states
    for i = 1:N
        
        %============= IF WORKING ===========================
        % output
        output = k_grid(i)^alpha * (h_bar)^(1-alpha);
        % consumption
        c_W = max(output + (1-delta)*k_grid(i) - k_grid,0);
        % value function
        [V_W(i),max_W_indx] = max(utility(c_W,h_bar) + beta.*V_old);
        % policy function
        g_k_W = k_grid(max_W_indx);
        % get consumption policy function
        g_c_W = c_W(max_W_indx);
        
        %============= IF NOT WORKING ========================
        % output
        output = k_grid(i)^alpha * (0)^(1-alpha);
        % consumption
        c_N = max(output + (1-delta)*k_grid(i) - k_grid,0);
        % value function
        [V_N(i),max_N_indx] = max(utility(c_N,0) + beta.*V_old);
        % policy function
        g_k_N = k_grid(max_N_indx);
        % get consumption policy function
        g_c_N = c_N(max_N_indx);
        
        % Choose the better option
        if V_W(i) >= V_N(i)
            V(i) = V_W(i);
            g_k(i) = g_k_W;
            g_h(i) = h_bar;
            g_c(i) = g_c_W;
        else
            V(i) = V_N(i);
            g_k(i) = g_k_N;
            g_h(i) = 0;
            g_c(i) = g_c_N;
        end
    end
    
    % Check convergence
    diff = max(abs(V - V_old));
    
end

%% 7. Find threshold capital level (where labor choice switches)
% Find where h_policy switches from 0 to h_bar
threshold_idx = find(g_h == 0, 1, 'first');
k_bar = k_grid(threshold_idx);

%% 8. Find steady state
% Steady state is where k' = k
ss_idx = find(abs(g_k - k_grid) ==0);

k_ss = mean(k_grid(ss_idx));
h_ss = mean(g_h(ss_idx));
c_ss = mean(g_c(ss_idx));
    
k_ss_theory = (alpha * h_ss^(1-alpha) / (1/beta - (1-delta)))^(1/(1-alpha));

%% 9. Plotting

% value function
figure;
plot(k_grid,V_W,'-',k_grid,V_N,'--','Linewidth',1)
xlabel('Captial (k)');
ylabel('Value Function');
title('Value Functions');
legend('V^W','V^N','Location','SouthEast')

% capital
figure;
plot(k_grid,g_k,k_grid,k_grid,'Linewidth',2)
xlabel('Captial (k)');
ylabel('g_k');
title('Capital');

% labor
figure;
plot(k_grid,g_h,'Linewidth',2)
xlabel('Captial (k)');
ylabel('g_h');
title('Labor');


