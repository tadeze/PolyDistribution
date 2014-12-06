
%Compute the ML
clear all
rng(0);  

m=20;
n=20;

MSE1=zeros(10,10);
MSE2=zeros(10,10);

for a1=1:10
    for a2=1:10
        disp([a1 a2]);
        alphaG=[a1 a2];
        mse=zeros(200, 2);
        for iter = 1:200
            % initialize alpha randomly
            alpha=randi(10,[1,2]);
            
            % Generate data
            n_1 = genDataBetaBinomial(alphaG, n, m);
            n_2 = n - n_1;

%             % initialize alpha from MOM
%             % Calculate first and second order moments from the data
%             m1 = mean(n_1);
%             m2 = mean(n_1.^2);
%             % Estimate alpha1 and alpha2 using MOM estimators
%             alpha1 = (n*m1 - m2) / (n * (m2/m1 - m1 - 1) + m1);
%             alpha2 = (n - m1) * (n - m2/m1) / (n * (m2/m1 - m1 - 1) + m1);
%             alpha = [alpha1 alpha2];

            ep=0.001;
            conv=[1 1];
            cnt = 0;
            while(conv(1) > ep || conv(2) > ep)
                if(cnt > 1000)
                    break;
                end
                cnt = cnt + 1;
                alpha1 = alpha;
                den= m * calcPsi(n, sum(alpha));
                num1=0;
                num2=0;
                for i = 1:m
                    num1 = num1 + calcPsi(n_1(i), alpha(1));
                    num2 = num2 + calcPsi(n_2(i), alpha(2));
                end
                alpha = alpha .* [num1 num2] / den;
                conv = abs(alpha1-alpha);
            end
%             disp([alphaG ; alpha1 ;alpha]);
%             disp('');
            mse(iter,:)=(alpha-alphaG).^2;
        end
        meanMSE=mean(mse);
        MSE1(a1,a2)=meanMSE(1);
        MSE2(a1,a2)=meanMSE(2);
    end
end
csvwrite('momInit.MSE.ML.alpha1.csv', MSE1);
csvwrite('momInit.MSE.ML.alpha2.csv', MSE2);
