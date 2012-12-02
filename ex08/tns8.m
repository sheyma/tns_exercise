N = 1000;
v = 30;  % Average spike rate (Hz)
hist_steps = 100;

xi = rand(1, N);
ti = -(1/v) * log(1-xi); % spike intervals (s)

xi = sort(xi);
ti = sort(ti);

% calc step vectors
dx = 1/hist_steps;
Dx = 0+dx:dx:1;
dt = max(ti)/(hist_steps);
Dt = 0+dt:dt:max(ti);

% plot hist figures
figure(1);
subplot(1,2,1)
hist(xi, hist_steps);
[n_xi m] = hist(xi, hist_steps);
subplot(1,2,2)
hist(ti, hist_steps);
[n_ti k] = hist(ti, hist_steps);

% sum up percentiles
% [n_xi m] = hist(xi, 100);
% [n_ti k] = hist(ti, 100);

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
bar(Dx, (n_xi/N)/dx)   % Probability Density
subplot(1,2,2)
bar(Dt , (n_ti/N)/(dt))


Px=(n_xi/N)/dx;  % Probability Density for x
Pt=((n_ti/N)/(dt)); % Pron Denst for spike int

Sk=[];
for i=1:hist_steps
    Sk(i)=1-sum(Pt(1:i))*dt;      % Survivor Function
end

figure(5);
subplot(1,2,1)
plot(Dt,Sk)
axis([0 Dt(length(Dt)) 0 1 ])
subplot(1,2,2)
haz=Pt./Sk;
plot(Dt, haz)