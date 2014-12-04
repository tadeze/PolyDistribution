
% calculate probability density
function prob = betaBinomialPDF(n, n_1, alpha)
    n_2 = n - n_1;
    prob = factorial(n)/(factorial(n_1) * factorial(n_2));

    prob = prob * (gamma(sum(alpha)) / gamma(n + sum(alpha))) * ...
        (gamma(n_1 + alpha(1)) / gamma(alpha(1))) * (gamma(n_2 + alpha(2)) / gamma(alpha(2)));
end
