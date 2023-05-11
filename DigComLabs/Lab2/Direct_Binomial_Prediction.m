function [mean_result, cov_result] = Direct_Binomial_Predicition(a,b)
M = 10; p = 0.5; 

k_values = linspace(0,M,M+1);
X_prob_for_k = zeros(1, length(k_values));
Y_prob_for_k = zeros(1, length(k_values));
%% Loop for Binomial Function Call and Prob Array Population
count = 1;
for k=k_values
    X_var = binomial_prob(M,k,p);
    X_prob_for_k(count) = X_var;
    Y_var = binomial_prob(M,k,p);
    Y_prob_for_k(count) = Y_var;
    count = count + 1;
end
%% Mean Calculation
X_mean = a * mean(X_prob_for_k);
Y_mean = b * mean(Y_prob_for_k);
mean_result = X_mean + Y_mean;

%% Cov Calculation
cov_result = a^2 * var(X_prob_for_k) + b^2 * var(Y_prob_for_k);
end