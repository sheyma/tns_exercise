% Exercise 07 - Part 1 - Indirect Actor

% rt=1;
% bt=1;
close all;
number_r(1)=0;
number_b(1)=0;
N=1000;
Nr=0;
Nb=0;
cum_r=zeros(1,2*N);
cum_b=zeros(1,2*N);
beta=20;                     % constant for choice variability
eps=1;
mr=zeros(1,2*N);            % action value for red flower
mb=zeros(1,2*N);            % action value fot blue flower
m_ave=zeros(1,2*N);         % average action value
P_r=zeros(1,2*N);           % probability to visit red flower
P_b=zeros(1,2*N);           % probability to visit blue flower
 

% CHANGING REWARDS-------------

% first phase
r_b1=1;
r_r1=3;
for i=1:N
    
    m_ave(i)=0.5*(mb(i)+mr(i));
    
    P_r(i)=1/(1+exp(beta*(m_ave(i)-mr(i))));
    P_b(i)=1/(1+exp(beta*(m_ave(i)-mb(i))));
    
    a=rand;
    
   
        if a<P_r(i)
        delta=(r_r1+randn)-mr(i);
        mr(i+1)=mr(i)+eps*delta;
        Nr=Nr+1;
        
%         number_r(rt+1)=number_r(rt)+1;
        else
        delta=(r_b1+randn)-mb(i);
        mb(i+1)=mb(i)+eps*delta;
        Nb=Nb+1;
%         number_b(bt+1)=number_b(bt)+1;
        end
    cum_r(i)=Nr;
    cum_b(i)=Nb;

end


% second phase
r_b2=3;
r_r2=1;
for i=N:2*N-1
    
    m_ave(i)=0.5*(mb(i)+mr(i));
    
    P_r(i+1)=1/(1+exp(beta*(m_ave(i+1)-mr(i+1))));
    P_b(i+1)=1/(1+exp(beta*(m_ave(i+1)-mb(i+1))));
    
    a=rand;
    
%     if i<(2*N) && rt<1000
    if a<P_r(i) 
        delta=(r_r2+randn)-mr(i);
        mr(i+1)=mr(i)+eps*delta;
        Nr=Nr+1;
%         number_r(rt+1)=number_r(rt)+1;
%         number_b(rt+1)=number_b(rt);
    else
        delta=(r_b2+randn)-mb(i);
        mb(i+1)=mb(i)+eps*delta;
        Nb=Nb+1;
%         number_b(rt+1)=number_b(rt)+1;
%         number_r(rt+1)=number_r(rt);

    end
% 
%     rt=rt+1;

    cum_r(i+1)=Nr;
    cum_b(i+1)=Nb;

    
end


figure(1);
hold on
set(gca,'FontSize',16)
plot(1:2*N, mr,'r','LineWidth',2)
plot(1:2*N,mb,'LineWidth',2)
xlabel('Number of trials N=2000','FontSize',16);
ylabel('m_r and m_b','FontSize',16);
title('Action Values','FontSize',16);
hold off

figure(2);
hold on
set(gca,'FontSize',16,'LineWidth',2)
plot(1:2*N, P_r,'r','LineWidth',2)
plot(1:2*N,P_b,'LineWidth',2)
axis([1 2000 0 1.2]);
xlabel('Number of trials N=2000','FontSize',16);
ylabel('P_r and P_b','FontSize',16);
title('Probabilities','FontSize',16);
hold off

figure(3);
hold on
set(gca,'FontSize',16)
plot(1:2*N, cum_r,'r','LineWidth',3)
plot(1:2*N, cum_b, 'b','LineWidth',3)
xlabel('Number of trials N=2000','FontSize',16);
ylabel('R_r and R_b','FontSize',16);
title('Cumulative Total Rewards','FontSize',16);
hold off