
% Generate data from beta binomial
function n_1 = genDataBetaBinomial(alpha, n, m)
    % get m probabilities from beta distribution B(alpha_1, alpha_2)
    p = betarnd(alpha(1), alpha(2), [1 m]);

    % get m samples from binomial(n, p_i)
    n_1 = binornd(n, p, [1 m]);
end
