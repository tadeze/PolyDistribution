
clear all;

rng(0);

numIter = 200;

m = 20; % number of observation
n = 20; % length of each observation, number of trials for binomial

MSE_al = zeros(10,10);
MSE_a2 = zeros(10,10);
for a1 = 1:10
    for a2 = 1:10
        % Beta params
        alpha = [a1 a2];

        skip = 0;
        for iter = 1:numIter
            % Generate data from beta binomial
            n_1 = genDataBetaBinomial(alpha, n, m);

            % Calculate first and second order moments from the data
            m1 = mean(n_1);
            m2 = mean(n_1.^2);

            % Estimate alpha1 and alpha2 using MOM estimators
            if (n * (m2/m1 - m1 - 1) + m1) <= 0
                skip = skip + 1;
                continue;
            end
            alpha1 = (n*m1 - m2) / (n * (m2/m1 - m1 - 1) + m1);
            alpha2 = (n - m1) * (n - m2/m1) / (n * (m2/m1 - m1 - 1) + m1);

            % Calculate MSE for alpha1 and alpha2
            MSE_al(a1,a2) = MSE_al(a1,a2) + (alpha1 - alpha(1))^2;
            MSE_a2(a1,a2) = MSE_a2(a1,a2) + (alpha2 - alpha(2))^2;
        end
        MSE_al(a1,a2) = MSE_al(a1,a2) / (numIter - skip);
        MSE_a2(a1,a2) = MSE_a2(a1,a2) / (numIter - skip);
    end
end

csvwrite(strcat('MSE.MOM.alpha1.m', num2str(m), '.n', num2str(n), '.i', num2str(numIter), '.csv'), MSE_al);
csvwrite(strcat('MSE.MOM.alpha2.m', num2str(m), '.n', num2str(n), '.i', num2str(numIter), '.csv'), MSE_a2);
