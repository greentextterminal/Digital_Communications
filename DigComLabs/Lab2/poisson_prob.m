function prob=poisson_prob(Mp, k)
    % lambda is Mp
    prob = Mp^k / factorial(k) * exp(-Mp);
end