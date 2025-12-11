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
k_ss_det = ((1/beta - (1-delta))/(alpha*A_mean))^(1/(alpha-1));

% Create capital grid
n_k = 500;                          % Number of grid points
k_min = 0.5 * k_ss_det;             % Lower bound
k_max = 1.5 * k_ss_det;             % Upper bound
k_grid = linspace(k_min, k_max, n_k)';

%% Value Function Iteration Setup
diff = inf;                 % set difference
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
u = @(c) (c.^(1-sigma))/(1-sigma);

% Production function high productivity
f_H = @(k) A_H * k^alpha;

% Production function low productivity
f_L = @(k) A_L * k^alpha;

%% Value Function Iteration

while diff > tol 
    V_H_old = V_H;
    V_L_old = V_L;
    
    % Loop over current capital stock
    for i = 1:n_k
        
        %% High productivity state
        c_H = max((1-delta)*k_grid(i) + f_H(k_grid(i)) - k_grid,0);
        
        % - Find maximum
        [V_H(i),max_idx_H] = max(u(c_H) + beta.*(pi_HH.*V_H + (1-pi_HH).*V_L));
        % - Store optimal policy functions
        g_k_H(i) = k_grid(max_idx_H);
        g_c_H(i) = c_H(max_idx_H);
       
        
        %% Low productivity state
        c_L = max((1-delta)*k_grid(i) + f_L(k_grid(i)) - k_grid,0);
        
        % - Find maximum
        [V_L(i),max_idx_L] = max(u(c_L) + beta.*((1-pi_LL).*V_H + pi_LL.*V_L));
        % - Store optimal policy functions
        g_k_L(i) = k_grid(max_idx_L);
        g_c_L(i) = c_L(max_idx_L);
        
    end
    
    % Check convergence
    diff_H = max(abs(V_H - V_H_old));
    diff_L = max(abs(V_L - V_L_old));
    diff = max(diff_H, diff_L);
   
end


%% Find Target Capital
% High productivity target capital
tar_idx_H = find(abs(g_k_H - k_grid) ==0);
k_tar_H = mean(k_grid(tar_idx_H));

% Low productivity target capital
tar_idx_L = find(abs(g_k_L - k_grid) ==0);
k_tar_L = mean(k_grid(tar_idx_L));

%% Plot Value Functions

% value functions
plot(k_grid, V_H,k_grid,V_L, 'LineWidth', 2)
axis([k_grid(1),k_grid(end),-48,-41])
xlabel('Captial (k)');
ylabel('Value Function');
title('Value Functions');
legend('V^H(k) - High Productivity', 'V^L(k) - Low Productivity','Location', 'best', 'FontSize', 11);

% ploicy functions
plot(k_grid, g_k_H,k_grid,g_k_L, 'LineWidth', 2)
hold on
plot(k_grid,k_grid,'k--', 'LineWidth', 1.5)
axis([k_grid(1),k_grid(end),k_grid(1),k_grid(end)])
xlabel('Captial (k)');
ylabel('g_k');
title('Capital Policy Functions');
legend('g_k^H(k) - High Productivity', 'g_k^L(k) - Low Productivity','Location', 'best', 'FontSize', 11);
hold off


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
        if u < pi_LL  % Stay in low
            state_sim(t+1) = 1;  
            A_sim(t+1) = A_L;
        else  % Switch to high
            state_sim(t+1) = 2;  
            A_sim(t+1) = A_H;
        end
    else  % Currently in high state
        if u < pi_HH  % Stay in high
            state_sim(t+1) = 2;  
            A_sim(t+1) = A_H;
        else  % Switch to low
            state_sim(t+1) = 1;  
            A_sim(t+1) = A_L;
        end
    end
end

% Simulate economy using policy functions
for t = 1:T
    % Interpolate to find optimal k'
    if state_sim(t) == 1
        k_sim(t+1) = interp1(k_grid, g_k_L, k_sim(t));
    else
        k_sim(t+1) = interp1(k_grid, g_k_H, k_sim(t));
    end
    
    % Compute other variables
    y_sim(t) = A_sim(t) * k_sim(t)^alpha;
    i_sim(t) = k_sim(t+1) - (1-delta)*k_sim(t);
    c_sim(t) = y_sim(t) - i_sim(t);
end

%% Plot simulation results

% output
plot(1:T, y_sim, 'LineWidth', 2);
xlabel('Time');
ylabel('Output');
title('Output');

% consumption
plot(1:T, c_sim, 'LineWidth', 2);
xlabel('Time');
ylabel('Consumption');
title('Consumption');

% investment
plot(1:T, i_sim, 'LineWidth', 2);
xlabel('Time');
ylabel('Investment');
title('Investment');

% capital
plot(1:T, k_sim(1:T), 'LineWidth', 2);
xlabel('Time');
ylabel('Capital');
title('Capital');

%% Compute statistics (Question 2d)

% Means
fprintf('\nMeans:\n');
fprintf('Output:      %.4f\n', mean(y_sim));
fprintf('Consumption: %.4f\n', mean(c_sim));
fprintf('Investment:  %.4f\n', mean(i_sim));

% Standard deviations
fprintf('\nStandard Deviations:\n');
fprintf('Output:      %.4f\n', std(y_sim));
fprintf('Consumption: %.4f\n', std(c_sim));
fprintf('Investment:  %.4f\n', std(i_sim));

% Correlations
fprintf('\nCorrelations:\n');
corr_yc = corr(y_sim, c_sim);
corr_yi = corr(y_sim, i_sim);
fprintf('Corr(Y, C):  %.4f\n', corr_yc);
fprintf('Corr(Y, I):  %.4f\n', corr_yi);

% Autocorrelation of output
corr_yy = corr(y_sim(1:end-1), y_sim(2:end));
fprintf('Autocorr(Y): %.4f\n', corr_yy);
