student_populations = linspace(1,50,50) ; % input generation
student_probabilities = zeros(1, 50) ; % store calculations from function
target_probabilities = [] ;% empty dynamic array to store possible probs ; FOR DEBUG
target_populations = [] ; % dynamic array to store possible populations
%% Determining Populations With Probabilities Close to 0.5 
% take error to be 10%
upper_bound = 0.5 * 1.1; % 0.5 + 10% 
lower_bound = 0.5 * 0.9; % 0.5 - 10%
%% Loop and function call with 0.5 check
count = 1;
for pop=student_populations
    calculation = student_prob(pop);
    student_probabilities(pop) = calculation;
    if (calculation >= lower_bound && calculation <= upper_bound)
        target_probabilities(count) = calculation;
        target_populations(count) = pop;
        count = count + 1;
    end
end
%% Plotting Student Probabilities vs Student Populations
figure(1)
stem(student_populations, student_probabilities)
title('Probability of at Least Two Same Birthdays In A Population vs Population Size');
xlabel('Number of Students'), ylabel('Probability of at Least Two Same Birthdays');
grid on, legend('Birthday Probability vs Population Size');
