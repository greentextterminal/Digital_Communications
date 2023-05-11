M = 10; p = 0.5; a = 3; b = 2;

k_values = linspace(0,M,M+1); 
X_prob_for_k = zeros(1, length(k_values)); % X rand var
Y_prob_for_k = zeros(1, length(k_values)); % Y rand var
%% Binomial Probability Function Call Loop 
% X Component
count1 = 1;
for k1=k_values
    if k1 == 0
        bin_prob1 = 0;
    else
    bin_prob1 = sum(rand(1,M)<p) / M; % random var generation div by M to get prob
    end
    X_prob_for_k(count1) = bin_prob1;
    count1 = count1 + 1;
end

% Y Component
count2 = 1;
for k2=k_values
    if k2 == 0
        bin_prob2 = 0;
    else
    bin_prob2 = sum(rand(1,M)<p) / M; % random var generation div by M to get prob
    end
    Y_prob_for_k(count2) = bin_prob2;
    count2 = count2 + 1;
end
%% Finding Mean w/ Constants: aE[X] and bE[Y] 
X_mean = a * mean(X_prob_for_k)
Y_mean = b * mean(Y_prob_for_k)
Z_mean = X_mean + Y_mean
%% Finding Variance [ Var(X+Y)=Var(X)+Var(Y)+2Cov(X,Y) ] ; Var(X)=M*p*(1-p)







%% Creating the Plots
figure(1)
plot(k_values, X_prob_for_k) , grid on
title('X Binomial Rand. Var. Probability for M=10, p=0.5') 
xlabel('k'), ylabel('Probabilities of k Successes for M=10 and p=0.5')

figure(2)
plot(k_values, Y_prob_for_k) , grid on
title('Y Binomial Rand. Var. Probability for M=10, p=0.5')
xlabel('k'), ylabel('Probabilities of k Successes for M=10 and p=0.5')