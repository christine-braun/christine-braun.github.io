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
k_ss_theory = (alpha / (rho + delta))^(1/(1-alpha));
c_ss_theory = k_ss_theory^alpha - delta*k_ss_theory;

%% Setup grid
N = 200;                    % Number of grid points
k_min = 0.25 * k_ss_theory;       % Minimum capital
k_max = 2.0 * k_ss_theory;        % Maximum capital
k_grid = linspace(k_min, k_max, N)';

%% Initialize value function
V_old = zeros(N, 1);
V_new = zeros(N, 1);

% TODO: Better initial guess?
V_old = (k_grid.^alpha).^(1-sigma)./((1-sigma).*(1-beta));
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
        c = max((1-delta)*k_grid(i) + f(k_grid(i)) - k_grid,0);
        % - Find maximum
        [V_new(i),max_idx] = max(u(c) + beta.*V_old);
        % - Store optimal policy functions
        g_k(i) = k_grid(max_idx);
        g_c(i) = c(max_idx);
        
    end
    
    % Check convergence
    diff = max(abs(V_new - V_old));
    V_old = V_new;
    
end

%% Plot results
% TODO: Create plots

% value function
plot(k_grid,V_new,'Linewidth',2)
xlabel('Captial (k)');
ylabel('Value Function');
title('Value Function');

% capital
plot(k_grid,g_k,k_grid,k_grid,'Linewidth',2)
xlabel('Captial (k)');
ylabel('g_k');
title('Capital');

% consumption
plot(k_grid,g_c,'Linewidth',2)
xlabel('Captial (k)');
ylabel('g_c');
title('Consumption');


%% Find numerical steady state
% TODO: Find where k' = k

ss_idx = find(abs(g_k - k_grid) ==0);
k_ss = mean(k_grid(ss_idx));
c_ss = mean(g_c(ss_idx));

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
    c_path(t) =   interp1(k_grid,g_c,k_current);
    k_path(t+1) = interp1(k_grid,g_k,k_current);
    
end

% consumption path
plot(1:T,c_path,'Linewidth',2)
xlabel('Time');
ylabel('c');
title('Consumption');

% capital path
plot(0:T,k_path,'Linewidth',2)
xlabel('Time');
ylabel('k');
title('Capital');


