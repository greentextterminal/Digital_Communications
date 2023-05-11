M1 = 20; M2 = 40; M3 = 60; Mp = 3;
k1_values = linspace(0, M1, M1 + 1);
k2_values = linspace(0, M2, M2 + 1);
k3_values = linspace(0, M3, M3 + 1);
%% Binomial PMF Results
bino_prob_for_k1 = zeros(1, length(k1_values));
bino_prob_for_k2 = zeros(1, length(k2_values));
bino_prob_for_k3 = zeros(1, length(k3_values));
%% Poisson PMF Results
poiss_prob_for_k1 = zeros(1, length(k1_values));
poiss_prob_for_k2 = zeros(1, length(k2_values));
poiss_prob_for_k3 = zeros(1, length(k3_values));
%% Finding p given Mp
p1 = Mp / M1;
p2 = Mp / M2;
p3 = Mp / M3;
%% Looping and Calculating Probability Result for Binomial PMF
count1 = 1; count2 = 1; count3 = 1;
for k1 = k1_values
    binom_pmf_result1 = binomial_prob(M1, k1, p1);
    bino_prob_for_k1(count1) = binom_pmf_result1;
    count1 = count1 + 1;
end

for k2 = k2_values
    binom_pmf_result2 = binomial_prob(M2, k2, p2);
    bino_prob_for_k2(count2) = binom_pmf_result2;
    count2 = count2 + 1;
end

for k3 = k3_values
    binom_pmf_result3 = binomial_prob(M3, k3, p3);
    bino_prob_for_k3(count3) = binom_pmf_result3;
    count3 = count3 + 1;
end
%% Looping and Calculating Probability Results for Poisson
count1 = 1; count2 = 1; count3 = 1;
for k1 = k1_values
    poisson_pmf_result1 = poisson_prob(Mp, k1);
    poiss_prob_for_k1(count1) = poisson_pmf_result1;
    count1 = count1 + 1;
end

for k2 = k2_values
    poisson_pmf_result2 = poisson_prob(Mp, k2);
    poiss_prob_for_k2(count2) = poisson_pmf_result2;
    count2 = count2 + 1;
end

for k3 = k3_values
    poisson_pmf_result3 = poisson_prob(Mp, k3);
    poiss_prob_for_k3(count3) = poisson_pmf_result3;
    count3 = count3 + 1;
end
%% Plots For M = 20
figure(1)
hold on
plot(k1_values, bino_prob_for_k1)
plot(k1_values, poiss_prob_for_k1)
title('Binomial/Possion Probabilities at k for M=20'), xlabel('k'), ylabel('Binomial/Possion Probabilities for M=20')
legend('Binomial PMF For M=20', 'Possion PMF For M=20'), grid on
%% Plots for M = 40
figure(2)
hold on
plot(k2_values, bino_prob_for_k2)
plot(k2_values, poiss_prob_for_k2)
title('Binomial/Possion Probabilities at k for M=40'), xlabel('k'), ylabel('Binomial/Possion Probabilities for M=40')
legend('Binomial PMF For M=40', 'Possion PMF For M=40'), grid on
%% Plots for M = 60
figure(3)
hold on 
plot(k3_values, bino_prob_for_k3)
plot(k3_values, poiss_prob_for_k3)
title('Binomial/Possion Probabilities at k for M=60'), xlabel('k'), ylabel('Binomial/Possion Probabilities for M=60')
legend('Binomial PMF For M=60', 'Possion PMF For M=60'), grid on