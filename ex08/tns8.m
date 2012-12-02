N = 1000;
v = 30;  % Average spike rate (Hz)
hist_steps = 100;

xi = rand(1, N);
ti = -(1/v) * log(1-xi); % spike intervals (s)

xi = sort(xi);
ti = sort(ti);

% calc step vectors
dt = (max(ti)-min(ti))/hist_steps;
dx = (max(xi)-min(xi))/hist_steps;
Dt = min(ti):dt:max(ti);
Dx = min(xi):dx:max(xi);

% plot hist figures
figure(1);
hist(xi, Dx);
figure(2);
hist(ti, Dt);

% sum up percentiles
c_xi = cumsum(n_xi);
c_ti = cumsum(n_ti);

figure(3);
bar(Dx, c_xi);
figure(4);
bar(Dt, c_ti);


