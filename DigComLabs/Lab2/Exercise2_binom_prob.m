M1 = 10; p1 = 0.5; 
M2 = 20; p2 = 0.7;
k1_values = linspace(0,M1,M1+1);
k2_values = linspace(0,M2,M2+1);
prob1_for_k1 = zeros(1, length(k1_values));
prob2_for_k2 = zeros(1, length(k2_values));
%% Binomial Probability Function Call Loop 
count1 = 1;
for k1=k1_values
    bin_prob1 = binomial_prob(M1,k1,p1);
    prob1_for_k1(count1) = bin_prob1;
    count1 = count1 + 1;
end

count2 = 1;
for k2=k2_values
    bin_prob2 = binomial_prob(M2,k2,p2);
    prob2_for_k2(count2) = bin_prob2;
    count2 = count2 + 1;
end
%% Creating the Plots
figure(1)
plot(k1_values, prob1_for_k1) , grid on
title('Binomial Probability for M=10 and p=0.5') 
xlabel('k'), ylabel('Probabilities of k Successes for M=10 and p=0.5')

figure(2)
plot(k2_values, prob2_for_k2) , grid on
title('Binomial Probability for M=20 and p=0.7')
xlabel('k'), ylabel('Probabilities of k Successes for M=20 and p=0.7')