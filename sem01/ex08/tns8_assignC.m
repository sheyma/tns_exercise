% THEORETICAL NEUROSIENCE - EEXERCISE 8 - SEYMA BAYRAK
% ASSIGNMENT C

%--------------------------------------------------------------------------

% Poisson Process with Absolute Refractory Period 

N=100000;
x=rand(1,N);                    % N terms of random numbers betw. [0 1]
v=25;                           % average spike rate (Hz)
delta=0.02;                     % absolute refractory period (s)
lambda=1/(1/v - delta);
t=delta-(1/lambda)*log(x);      % spike interval with ref. per. (s)

% Sorting and then dividing x and t into 100 sub-intervals
x=sort(x);
t=sort(t);
step=100;

step_x=1/step;
X=0+step_x:step_x:1;

step_t=max(t)/step;
T=0+step_t:step_t:max(t);

[mx kx]=hist(x,step);           % mx is a vector for # of counts per x int.
[mt kt]=hist(t,step);           % mt is a vector for # of counts per t int.

PK=(mt/N)/step_t;               % Prob. dist. for counts per t vector int.

% computing the survivor function, numerically
SK=zeros(1,step);
for i=1:step
    SK(i)=1-sum(PK(1:i))*step_t;
end


% computing survivor and prob. dist. functions, analytically
hazard=zeros(1,step);
SKK=zeros(1,step);
PKK=zeros(1,step);
for i=1:step;
    if t(i)>delta
        hazard(i)=lambda;           % haz. fun. is a constant for t>0.02 s
        SKK(i)=exp(-lambda*T(i));
        PKK(i)=hazard(i)*SKK(i);
    else
        hazard(i)=0;                % haz. fun. is zero for t<=0.02 s
        SKK(i)=1;
        PKK(i)=0;
    end
end

figure(7);
subplot(1,2,1)
plot(T,SK,T,SKK,'--r')
axis([0 T(length(T)) 0 1 ])
title('Survivor Functions; Numerically & Analytically')
xlabel('N inter spike intervals, ti')
ylabel('Survivor Functions')
subplot(1,2,2)
plot(T,PK,T,PKK,'--r')
title('Probability Distributions; Numerically & Analytically')
xlabel('N inter spike intervals, ti')
ylabel('Probability Distributions')

% Confirmation that area under prob. dist. graph =1 !
area1=sum(PK)*step_t;
fprintf('Area under probab. dist. function (in Assn.C) is %.0f \n',area1);

% Confitmation that area under surv. func. is around 1/v=0.040 !
area2=sum(SK)*step_t;
fprintf('Area under survivor function (in Assn.C) is %.4f \n',area2);

%--------------------------------------------------------------------------

