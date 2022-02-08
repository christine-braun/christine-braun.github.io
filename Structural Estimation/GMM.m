function [ssd] = GMM(p,wr,W,data,N)
%GMM estimator for data 4
%   inputs: p - vector of parameters
%           wr - estimate of reservation wage
%           W - weighting Matrix
%           data - matrix of data
%           N - number of observations

% find g
g = g_function(p,data,wr);

% sum of squared difference
ssd = 

end

