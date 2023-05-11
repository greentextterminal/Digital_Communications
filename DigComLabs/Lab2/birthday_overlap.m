%% Expression for probability of any birthday overlap 
function prob_result = birthday_overlap(n)
    term1 =exp(gammaln(365+1)-gammaln(365-n+1));
    term2 = 1 / 365^n;
    prob_result = 1 - term1 * term2;
end
