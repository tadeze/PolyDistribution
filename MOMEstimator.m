
clear all;
rng(0);

m = 20; % number of observation
n = 20; % length of each observation, number of trials for binomial

MSE = zeros(10,10);
for a1 = 1:10
    for a2 = 1:10
        % Beta params
        alpha = [a1 a2];

        for iter = 1:200
            % Generate data from beta binomial
            n_1 = genDataBetaBinomial(alpha, n, m);

            % Calculate first and second order moments from data
            m1 = mean(n_1);
            m2 = mean(n_1.^2);

            % Estimate alpha1 and alpha2 using MOM estimators
            alpha1 = (n*m1 - m2) / (n * (m2/m1 - m1 - 1) + m1);
            alpha2 = (n - m1) * (n - m2/m1) / (n * (m2/m1 - m1 - 1) + m1);

            % Calculate MSE for alpha1
            MSE(a1,a2) = MSE(a1,a2) + (alpha1 - alpha(1))^2;
            %disp((alpha1 - alpha(1))^2);
        end
        MSE(a1,a2) = MSE(a1,a2) / 200;
    end
end
