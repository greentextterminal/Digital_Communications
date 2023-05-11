a1 = 3; b1 = 2;
a2 = -5; b2 = 7;
M = 10; p = 0.5;
k_values = linspace(0,M,M);
X_bin_prob_vals = zeros(1, length(k_values));
Y_bin_prob_vals = zeros(1, length(k_values));


% Z1 = linear_func_of_rand_vars(a1,b1)
% Z1_mean = mean(Z1)
% Z1_var = var(Z1)
% 
% Z2 = linear_func_of_rand_vars(a2,b2)
% Z2_mean = mean(Z2)
% Z2_var = var(Z2)