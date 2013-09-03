function xi = one_response( ri )

% compute responses to individual stimulus from average response
% assuming Poisson noise
%
% p(xi|ri) = ri^xi * exp(-ri) / xi!
%
% ln p(xi|ri) = xi * ln ri - ri - ln xi!
%
% Matlab: log p = xi * log(ri) - ri - gammaln(xi+1)
%
% here we use poissinv.m from the statistics tool package.
% It converts uniformly distributed random numbers 
% into Poisson-distributed random numbers.   Specifically,
% poissinv returns the inverse of the Poisson cdf, in other 
% words, the upper end of the response range that occurs 
% with a probability pr.  This probability is choosen from 
% a uniform random distribution with 0<= pr <= 1.

% get uniformly distributed random seeds
pr = rand(size(ri));

% obtain Poisson-distributed random numbers, with expected
% value ri

xi = poissinv(pr, ri);
