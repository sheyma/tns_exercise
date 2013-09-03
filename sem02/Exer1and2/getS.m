function S = getS(x, M, sigma)

if x<0
    S = 0;
else
    S = (M*x^2)/(sigma^2+x^2);
end