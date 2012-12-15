function ri = ave_response(thetai, theta_true, Rvis, Rdark, sigma)

% compute average response of neurons
%
% thetai preferred positions of neurons (may be a vector)
% N = length(thetai) is the number of neurons
%
% theta_true true stimulus position
%
% Rdark + Rvs * exp( kappa * cos(thetai-theta_true) - kappa )
%
% Rdark... background response

% Rvis ... visual response
% 
% sigma = acos(1-1/kappa) ... tuning width in radians,
%                             should be large to ensure dark
%                             noise
% 
% kappa = 1/(1-cos(sigma)) ... constant

kappa = 1 / (1-cos(sigma));

ri = cos(angdiff(thetai,theta_true)) - 1;

ri = Rdark + Rvis * exp(kappa*ri);

