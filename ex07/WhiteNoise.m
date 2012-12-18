function s = WhiteNoise( n )

% produces a white noise array of size n x n, where each value
% is normally distributed with mean zero and variance one.

s = normrnd( 0, 1, n, n );    % using function 'normrnd'

% normalizing S to values between zero and one:

s = s-min(min(s));
s = s/max(max(s));

% S = randn( n );   % alternative function 'randn'

