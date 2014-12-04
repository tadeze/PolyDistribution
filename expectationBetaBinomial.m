
clear all;
rng(0);

m = 20; % number of observation
n = 20; % length of each observation, number of trials for binomial

FIM = cell(10,10);
invFIM = cell(10,10);

for alpha1 = 1:10
    for alpha2 = 1:10
        % Beta params
        alpha = [alpha1 alpha2];

        % Generate data from beta binomial
        n_1 = genDataBetaBinomial(alpha, n, m);
        n_2 = n - n_1;

        % calculate E[shi'(n_1+alpha(1))] and E[shi'(n_2+alpha(2))]
        niter = 200;
        expect1 = 0;
        expect2 = 0;
        for iter = 1:niter
            tn_1 = genDataBetaBinomial(alpha, n, 1);
            tn_2 = n - tn_1;
        %    prob = betaBinomialPDF(n, tn_1, alpha);
            expect1 = expect1 + psi(1, tn_1 + alpha(1));% * prob;
            expect2 = expect2 + psi(1, tn_2 + alpha(2));% * prob;
        end
        expect1 = expect1 / niter;
        expect2 = expect2 / niter;

        % calculate negative expected double derivatives
        d2logp_da12 =   psi(1, sum(alpha)) - psi(1, n + sum(alpha)) + expect1 - psi(1, alpha(1));
        d2logp_da1a2 =   psi(1, sum(alpha)) - psi(1, n + sum(alpha));
        d2logp_da22 =   psi(1, sum(alpha)) - psi(1, n + sum(alpha)) + expect2 - psi(1, alpha(2));

        FIM11 = -m * d2logp_da12;
        FIM12 = -m * d2logp_da1a2;
        FIM22 = -m * d2logp_da22;

        F = [FIM11 FIM12; FIM12 FIM22];
        % disp(F)
        FIM{alpha(1), alpha(2)} = F;

        iFIM = pinv(F);
        %disp(invFIM);
        invFIM{alpha(1), alpha(2)} = iFIM;
    end
end
