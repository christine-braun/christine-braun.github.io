%% Ramsey Model - Value Function Iteration
% Problem Set 3 solution

%% Parameters
beta = 0.96;    % Discount factor
sigma = 2;      % CRRA parameter
alpha = 0.33;   % Capital share
delta = 0.1;    % Depreciation rate

%% Utility and production functions
u = @(c) (c.^(1-sigma))/(1-sigma);  % CRRA utility
f = @(k) k.^alpha;                   %  production

%% Analytical steady state
rho = (1/beta) - 1;
k_ss_theory = 
c_ss_theory = 

%% Setup grid
N = 200;                    % Number of grid points
k_min =      % Minimum capital
k_max =        % Maximum capital
k_grid = linspace(k_min, k_max, N)';

%% Initialize value function
V_new = zeros(N, 1);

% TODO: Better initial guess?
V_old =
%% Value function iteration
tol = 1e-6;
max_iter = 1000;
iter = 0;
diff = inf;

% Storage for policy functions
g_c = zeros(N, 1);
g_k = zeros(N, 1);

while diff > tol && iter < max_iter
    iter = iter + 1;
    
    % Loop over each state
    for i = 1:N
        
        % TODO: Find optimal consumption/capital choice
        % - Calculate consumption at each point in the k grid
        c =
        % - Find maximum
        [V_new(i),max_idx] = max( .  );
        % - Store optimal policy functions
        g_k(i) = 
        g_c(i) = 
        
    end
    
    % Check convergence
    diff = 
    V_old = V_new;
    
end

%% Plot results
% TODO: Create plots

% value function
plot(  )
xlabel('Captial (k)');
ylabel('Value Function');
title('Value Function');

% capital
plot(   )
xlabel('Captial (k)');
ylabel('g_k');
title('Capital');

% consumption
plot(   )
xlabel('Captial (k)');
ylabel('g_c');
title('Consumption');


%% Find numerical steady state
% TODO: Find where k' = k

ss_idx = 
k_ss = 
c_ss = 

%% Simulate consumption and capital 

T = 50;                    % Number of periods
k0 = 0.5 * k_ss;           % Initial capital (50% of steady state)

% Initialize paths
k_path = zeros(T+1, 1);
c_path = zeros(T, 1);
k_path(1) = k0;

% Simulate using policy functions
for t = 1:T
    % Current capital
    k_current = k_path(t);
    
    % Use policy functions (interpolate)
    c_path(t) =   
    k_path(t+1) = 
    
end

% consumption path
plot(   )
xlabel('Time');
ylabel('c');
title('Consumption');

% capital path
plot(   )
xlabel('Time');
ylabel('k');
title('Capital');


