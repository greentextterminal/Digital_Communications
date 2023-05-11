k = linspace(1,10,10);
p1 = 0.25;
p2 = 0.5;
geom_prob_for_p1 = zeros(1,10);
geom_prob_for_p2 = zeros(1,10);
%% Geometric Probability Function Call and Looping Through
for k1 = k
    prob1 = geometric_prob(k1,p1);
    geom_prob_for_p1(k1) = prob1;
end

for k2 = k
    prob2 = geometric_prob(k2,p2);
    geom_prob_for_p2(k2) = prob2;
end
%% Generating Plots
figure(1)
plot(k, geom_prob_for_p1), title('Geometric Probability at k given P=0.25')
xlabel('k'), ylabel('Geometric Probability at k for P=0.25'), grid on

figure(2)
plot(k, geom_prob_for_p2), title('Geometric Probability at k given P=0.5')
xlabel('k'), ylabel('Geometric Probability at k for P=0.5'), grid on