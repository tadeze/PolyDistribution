
clear all;
rng(2);

m = 200; % number of observation
n = 200; % length of each observation, number of trials for binomial

MSE_al = zeros(10,10);
MSE_a2 = zeros(10,10);
for a1 = 1:10
    for a2 = 1:10
        % Beta params
        alpha = [a1 a2];

        for iter = 1:200
            % Generate data from beta binomial
            n_1 = genDataBetaBinomial(alpha, n, m);

            % Calculate first and second order moments from the data
            m1 = mean(n_1);
            m2 = mean(n_1.^2);

            % Estimate alpha1 and alpha2 using MOM estimators
            alpha1 = (n*m1 - m2) / (n * (m2/m1 - m1 - 1) + m1);
            alpha2 = (n - m1) * (n - m2/m1) / (n * (m2/m1 - m1 - 1) + m1);

            % Calculate MSE for alpha1 and alpha2
            MSE_al(a1,a2) = MSE_al(a1,a2) + (alpha1 - alpha(1))^2;
            MSE_a2(a1,a2) = MSE_a2(a1,a2) + (alpha2 - alpha(2))^2;
            %disp((alpha1 - alpha(1))^2);
        end
        MSE_al(a1,a2) = MSE_al(a1,a2) / 200;
        MSE_a2(a1,a2) = MSE_a2(a1,a2) / 200;
    end
end

csvwrite('MSE.MOM.alpha1.m200.csv', MSE_al);
csvwrite('MSE.MOM.alpha2.m200.csv', MSE_a2);
