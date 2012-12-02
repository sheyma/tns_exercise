N = 100000;
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
subplot(1,2,1)
hist(xi, Dx);
subplot(1,2,2)
hist(ti, Dt);

% sum up percentiles
n_xi = histc(xi, Dx);
n_ti = histc(ti, Dt);

c_xi = cumsum(n_xi);
c_ti = cumsum(n_ti);

figure(2);
subplot(1,2,1)
bar(Dx, c_xi);
subplot(1,2,2)
bar(Dt, c_ti);


figure(3);
subplot(1,2,1)
plot(Dx, c_xi/N);
subplot(1,2,2);
plot(Dt, c_ti/N);


figure(4);
subplot(1,2,1)
plot(Dx, (n_xi/N)/dx)

subplot(1,2,2)
plot(Dt , (n_ti/N)/(dt))
