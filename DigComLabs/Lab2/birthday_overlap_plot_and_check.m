student_population = linspace(1,50,50);
prob_array = zeros(length(student_population),1)
for i = student_population
    prob_array(i) = birthday_overlap(i);
end

figure(1)
stem(student_population, prob_array);
title('Plot of Probability of Mathematical Expression of Any Birthday Overlap vs Population')
xlabel('Student Population (n)'); ylabel('Probability of Any Birthday Overlap')
