%% Binomial Probability Function 
function prob=binomial_prob(M,k,p)
    binomial_coeff = nchoosek(M,k);
    prob=binomial_coeff * (p^k) * (1 - p)^(M-k) ;
end