%% Value Function Iteration - Optimizing over Next Period Assets
% EC9A2 Problem Set 1 - Question 3 solution

%% Parameters
beta = 0.9;     % Discount factor
r = 0.05;       % Interest rate  
y = 1;          % Income per period
tol = 1e-6;     % Convergence tolerance

%% Set up asset grid
N_a = 500;           % Number of grid points
a_min = 0;        % Minimum assets
a_max = 50;         % Maximum assets
a_grid = linspace(a_min, a_max, N_a)';

%% Initialize value function and policy
V0 = zeros(N_a, 1);          % Initial value function guess
V1 = zeros(N_a, 1);          % Updated value function
g_a = zeros(N_a, 1);           % Next period assets policy g_a(a)
g_c = zeros(N_a, 1);           % Consumption policy g_c(a)

%% Main Value Function Iteration Loop
iter = 0;
max_iter = 1000;
diff = inf;

while diff > tol && iter < max_iter
    iter = iter + 1;
    
    for j = 1:N_a
       % consumption: replace with small number (eps) if less than 0
       c = max((1+r)*a_grid(j) + y - a_grid,eps);
       % find the max and argmax
       [V1(j), max_idx] = max(log(c) + beta * V0);
       % get asset policy function
       g_a(j) = a_grid(max_idx);
       % get consumption policy function
       g_c(j) = (1+r).*a_grid(j) + y - g_a(j);

    end
    % Check convergence
    diff = max(abs(V1 - V0));
    V0 = V1;
    
end

%% Create plots

% Plot 1: Value Function 
figure;
plot(a_grid, V1, 'LineWidth', 2);
xlabel('Assets (a)');
ylabel('Value Function V(a)');
title('Value Function');

% Plot 2: Consumption Policy function
figure;
plot(a_grid, g_c, 'LineWidth', 2);
xlabel('Current Assets (a)');
ylabel('Consumption g_c(a)');
title('Consumption Policy Function');

% Plot 3: Asset Policy Function
figure;
plot(a_grid, g_a, 'LineWidth', 2);
xlabel('Current Assets (a)');
ylabel('Next Period Assets g_a(a)');
title('Asset Policy Function');
