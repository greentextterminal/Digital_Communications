student_populations = linspace(1,50,50) ; % input generation
student_probabilities = zeros(1, 50) ; % store calculations from function
%% Loop and function call
for pop=student_populations
    student_probabilities(pop) = student_prob(pop);
end
%% Plotting Student Probabilities vs Student Populations
figure(1)
plot(student_populations, student_probabilities)
title('Probability of at Least Two Same Birthdays In A Population vs Population Size');
xlabel('Number of Students'), ylabel('Probability of at Least Two Same Birthdays');
grid on, legend('Birthday Probability vs Population Size');