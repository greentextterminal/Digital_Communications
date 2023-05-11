function [mean_result, cov_result] = linear_func_of_rand_vars(a, b)
    p = 0.5;
    M = 10;
    % X component
    X_trials = rand(1,M)<p ;
    X_successes = sum(X_trials) ;
    X_mean = a * X_successes / M ;
    % Y component
    Y_trials = rand(1,M)<p ;
    Y_successes = sum(Y_trials) ;
    Y_mean = b * Y_successes / M ;
    % Z Mean Result
    mean_result = X_mean + Y_mean ;
    % Cov Result
    % Var(X+Y)=Var(X)+Var(Y)
    % independent trials, therefore correlation coefficient is 0
    cov_result = a^2 * var(X_trials) + b^2 * var(Y_trials) ;
end