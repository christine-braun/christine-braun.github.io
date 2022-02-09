function [g] = g_function_sim_answer(p,N_sim,data,wr)
% creates difference of moments
%   inputs: p - parameters
%           r - discount rate
%           N_sim - number of obs to simulate
%           data - observed data matrix
%   outputs: g - difference between data and data_sim

% get simulated data
data_sim = simulate_data_answer(p,N_sim,wr);

% assign data mometns
u = data(:,1);
tu = data(:,2);
w = data(:,3);
te = data(:,4);
w2 = data(:,3).^2;

u_sim = mean(data_sim(:,1));
tu_sim = mean(data_sim(data_sim(:,1)==1,2));
w_sim = mean(data_sim(data_sim(:,1)==0,3));
te_sim = mean(data_sim(data_sim(:,1)==0,4));
w2_sim = mean(data_sim(data_sim(:,1)==0,3).^2);

% create g function should be (5 X 10000)
g = [u-u_sim,tu-tu_sim,te-te_sim,w-w_sim,w2-w2_sim];
g(u==0,2) = 0;
g(u==1,3) = 0;
g(u==1,4) = 0;
g(u==1,5) = 0;
g = g';

end

