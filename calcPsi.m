
function res = calcPsi(k, alpha)
    res = 0;
    for i = 0:(k-1)
        res = res + 1 / (i + alpha);
    end
end
