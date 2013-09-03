% THEORETICAL NEUROSIENCE - ASSIGNMENT 8 - SEYMA BAYRAK
% ASSIGNMENT A & B

%--------------------------------------------------------------------------

% ASSIGNMENT A

N = 100000;                     % number of elements of xi and ti vector
v = 30;                         % average spike rate (Hz)
hist_steps = 100;

xi = rand(1, N);                % N number of random variables betwn. [0 1] 
ti = -(1/v) * log(1-xi);        % N spike intervals (s)

% Sorting elements of both xi and ti vectors
xi = sort(xi);
ti = sort(ti);

% Dividing xi and ti vectors into 100 intervals / percentiles
dx = 1/hist_steps;              % Increment steps among xi elements
Dx = 0+dx:dx:1;                 % Grouping xi values in percentiles
dt = max(ti)/(hist_steps);      % Increment steps among ti elements
Dt = 0+dt:dt:max(ti);           % Grouping ti values in percentiles

% Plotting histogram figures
figure(1);
subplot(1,2,1)
hist(xi, hist_steps);
title('Histogram of N terms of random numbers, xi')
xlabel('100 equal intervals between 0 and 1')
ylabel('Number of counts per interval')
[n_xi m] = hist(xi, hist_steps); % n_xi is a vector for # of counts / int.
subplot(1,2,2)
hist(ti, hist_steps);
title('Histogram of N terms of spike intervals, ti')
xlabel('100 equal intervals between 0 and max(ti)')
ylabel('Number of counts per interval')
[n_ti k] = hist(ti, hist_steps); % n_ti is a vector for # of counts / int.

% Confirmation of total number of counts = N
a=sum(n_xi);   fprintf('Sum of all counts at xi vector is %8.0f \n',a);
b=sum(n_ti);   fprintf('Sum of all counts at ti vector is %8.0f \n',b);

% Cumulative sum of elements of "counting number vectors; n_xi and n_ti"
c_xi = cumsum(n_xi);
c_ti = cumsum(n_ti);

% Plotting cumulative sums of xi and ti
figure(2);
subplot(1,2,1)
bar(Dx, c_xi, 'r');               % displaying values in a vector as bars
title('Cumulative sum of elements of xi ')
xlabel('100 equal intervals between 0 and 1')
ylabel('Each count number is cumulatively summed')
subplot(1,2,2)
bar(Dt, c_ti, 'r');
title('Cumulative sum of elements of spike intervals, ti ')
xlabel('100 equal intervals between 0 and max(ti)')
ylabel('Each count number is cumulatively summed')

%Plotting proportion of # of counts against their corresp. intervals 
figure(3);
subplot(1,2,1)
plot(Dx, n_xi/N, 'g');             % n_xi/N means count as a fraction of N
title('Proportion of count numbers against intervals')
xlabel('100 equal intervals between 0 and 1')
ylabel('The count in each interval as fraction of total count, N')
subplot(1,2,2);
plot(Dt, n_ti/N, 'g');             % n_ti/N means count as a fraction of N
title('Proportion of count numbers against intervals')
xlabel('100 equal intervals between 0 and max(ti)')
ylabel('The count in each interval as fraction of total count, N')

% Confirmation that sum of count fractions are 1 !
a1=sum(n_xi/N);  
fprintf('Sum of proportional counts of xi is %1.0f \n',a1)
a2=sum(n_ti/N);
fprintf('Sum of proportional counts of ti is %1.0f \n',a2)

% Probability Density = Proportion of Events per unit range of values
Px=(n_xi/N)/dx;                 % Probability Density for x
Pt=(n_ti/N)/dt;                 % Probability Density for spike interval

% Plotting Probability Density against value
figure(4);
subplot(1,2,1)
plot(Dx, Px,'r')  % prop. of events (=counts) per unit int. range
title('Probability Density of xi')
xlabel('100 equal intervals between 0 and 1')
ylabel('Proportion of count numbers per unit range of values')
subplot(1,2,2)
plot(Dt,Pt,'r') % prop. of events (=counts) per unit int. range
title('Probability Density of ti')
xlabel('100 equal intervals between 0 and max(ti)')
ylabel('Proportion of count numbers per unit range of values')

% Confirmation that area under probability desnsity graphs are equal to 1!
A1=sum(Px)*dx;
fprintf('Area under probability density graph of xi is %1.0f \n',A1)
A2=sum(Pt)*dt;
fprintf('Area under probability density graph of ti is %1.0f \n',A2)

%--------------------------------------------------------------------------

% ASSIGNMENT B.1

% Computing the survivior function, Sk --   NUMERICAL APPROACH
Sk=zeros(1,hist_steps);
for i=1:hist_steps
    Sk(i)=1-sum(Pt(1:i))*dt;       % Here dt=ti(max)/100  
end

% Computing the hazard function, haz -- NUMERICAL APPROACH
foo=0.7*hist_steps;                % hack "numerical probs"
haz=Pt(1:foo)./Sk(1:foo);          % only first 70 elem. of Sk & Pt are OK

figure(5);
subplot(1,2,1)
plot(Dt,Sk)
axis([0 Dt(length(Dt)) 0 1 ])
title('Survivor Function Computed Numerically')
xlabel('N inter spike intervals, ti')
ylabel('Survivor function corresponding to ti values')
subplot(1,2,2)
plot(Dt(1:foo), haz)
title('Hazard Function Computed Numerically')
xlabel('inter spike intervals, ti, only 70 % of its elements')
ylabel('Hazard Function corresponding to first 70% of ti')

% Confirmation that average value of hazard function is around v=30  !
ave=sum(haz)/length(haz);
fprintf('Average value of Hazard Function is %f \n',ave);

% ASSIGNMENT B.2

% Assume that hazard function is CONSTANT and equals to v=30;
haz_constant=v;

% Computing the survivor function, St --    ANALYTIC APPROACH
St=exp(-v*Dt);

% Probability Int. Distribution function, Ptt -- ANALYTIC APPROACH
Ptt=haz_constant*St;

% Plotting both numerical & analytical solutions on same graphs
figure(6);
subplot(1,2,1)
hold on
plot(Dt,Sk,'b','LineWidth',3)
plot(Dt,St, '--r')
axis([0 Dt(length(Dt)) 0 1 ])
title('Survivor Functions; Numerically & Analytically')
xlabel('N inter spike intervals, ti')
ylabel('Survivor Functions')
subplot(1,2,2)
plot(Dt,Pt,Dt,Ptt, '--r')
title('Probability Distributions; Numerically & Analytically')
xlabel('N inter spike intervals, ti')
ylabel('Probability Distributions')


%-------------------------------------------------------------------------


