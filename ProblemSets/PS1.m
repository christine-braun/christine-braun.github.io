%% Value Function Iteration - Optimizing over Next Period Assets
% EC9A2 Problem Set 1 - Question 3

%% Parameters
beta =      % Discount factor
r =        % Interest rate  
y =          % Income per period
tol =     % Convergence tolerance

%% Set up asset grid
N_a =           % Number of grid points
a_min =        % Minimum assets
a_max =          % Maximum assets
a_grid = linspace(a_min, a_max, N_a)';

%% Initialize value function and policy
V0 = zeros(N_a, 1);          % Initial value function guess
V1 = zeros(N_a, 1);          % Updated value function
g_a = nan(N_a, 1);           % Next period assets policy g_a(a)
g_c = nan(N_a, 1);           % Consumption policy g_c(a)

%% Main Value Function Iteration Loop
iter = 
max_iter = 
diff = 

while diff > tol && iter < max_iter
    iter = iter + 1;
    
    for j = 1:N_a
       % consumption: replace with small number (eps) if less than 0
       c = max(    ,eps);
       % find the max and argmax
       [V1(j), max_idx] = 
       % get asset policy function
       g_a(j) = 
       % get consumption policy function
       g_c(j) = 

    end
    % Check convergence
    diff = 
    V0 = V1;
    
end

%% Create plots

% Plot 1: Value Function 
plot(  );
xlabel('Assets (a)');
ylabel('Value Function V(a)');
title('Value Function');

% Plot 2: Consumption Policy function
plot(   );
xlabel('Current Assets (a)');
ylabel('Consumption g_c(a)');
title('Consumption Policy Function');

% Plot 3: Asset Policy Function
plot(   );
xlabel('Current Assets (a)');
ylabel('Next Period Assets g_a(a)');
title('Asset Policy Function');
