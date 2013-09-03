% one target neuron with normalization

gama=[ 0 0.25 0.5 0.75 1];
color='brgck';
p1=1/2;
p0=1/2;
p11=gama/4;
p00=gama/4+gama/4;
p01=1/2+gama/4;
p10=1;

inputs=zeros(2*length(gama),1000);
ur_num=zeros(1,length(gama));
ul_num=zeros(1,length(gama));
cs_num=zeros(1,length(gama));
cd_num=zeros(1,length(gama));


for j=1:length(gama)
    for i=1:1000
         x=rand;
        if x<p11(j)
        inputs(2*j-1,i)=1;
        inputs(2*j,i)=1;
        elseif x<p00(j)
        inputs(2*j-1,i)=0;
        inputs(2*j,i)=0;
         elseif x<p01(j)
        inputs(2*j-1,i)=0;
        inputs(2*j,i)=1;
        else
        inputs(2*j-1,i)=1;
        inputs(2*j,i)=0;
        end
    end
    
    % mean values of U_r and U_L
    ur_num(j)=sum(inputs(2*j-1,:))/1000;
    ul_num(j)=sum(inputs(2*j,:))/1000;
    cs_num(j)=p1-ur_num(j)^2;
    cd_num(j)=p11(j)-ur_num(j)*ul_num(j);
    
end

%Covariance matrix analytic solution for 5 gamma values
cs_an=1/4;
cd_an=0.25*(gama-1);
Cov_an_1=[cs_an cd_an(1); cd_an(1) cs_an];
Cov_an_2=[cs_an cd_an(2); cd_an(2) cs_an];
Cov_an_3=[cs_an cd_an(3); cd_an(3) cs_an];
Cov_an_4=[cs_an cd_an(4); cd_an(4) cs_an];
Cov_an_5=[cs_an cd_an(5); cd_an(5) cs_an];
% ShowEigen(Cov_an)

%Covariance matrix numerical solution for 5 gamma values
Cov_num_1=[cs_num(1) cd_num(1); cd_num(1) cs_num(1)];
Cov_num_2=[cs_num(2) cd_num(2); cd_num(2) cs_num(2)];
Cov_num_3=[cs_num(3) cd_num(3); cd_num(3) cs_num(3)];
Cov_num_4=[cs_num(4) cd_num(4); cd_num(4) cs_num(4)];
Cov_num_5=[cs_num(5) cd_num(5); cd_num(5) cs_num(5)];

dt=0.1;


wR=zeros(length(gama),1000);
wL=zeros(length(gama),1000);

wR(:,1)=0.56;
wL(:,1)=0.29;


wplus=zeros(length(gama),1000);
wminus=zeros(length(gama),1000);
wplus(:,1)=wR(:,1)+wL(:,1);
wminus(:,1)=wR(:,1)-wL(:,1);


figure;
for j=1:length(gama)
    
    for i=1:999
    wR(j,i+1)=wR(j,i)+dt * 1/2* (cs_an*wR(j,i)+cd_an(j)*wL(j,i)-cd_an(j)*wR(j,i)-cs_an*wL(j,i));

    wL(j,i+1)=wL(j,i)+dt * 1/2 *(cd_an(j)*wR(j,i)+cs_an*wL(j,i)-cs_an*wR(j,i)-cd_an(j)*wL(j,i));

    wplus(j,i+1)= 0;
    wminus(j,i+1)= wminus(j,i)+ dt *(wminus(j,i)*(cs_an-cd_an(j)));
     
    wR(wR<0)=0;
    wR(wR>1)=1;
    wL(wL<0)=0;
    wL(wL>1)=1;
    
    end
    
    
    hold on
    plot(wL(j,:),wR(j,:),'color',color(j), 'LineWidth',3)
    axis([0 1 0 1])
    
end
set(gca,'FontSize',16);
xlabel('w_L','FontSize',25);
ylabel('w_R','FontSize',25);
legend('gama=0','gama=0.25','gama=0.5','gama=0.75','gama=1');
hold off


wR_new=zeros(5,1000);
wL_new=zeros(5,1000);
initials_wR=[0.70 0.58 0.50 0.40 0.30];
initials_wL=[0.26 0.35 0.40 0.60 0.75];
wplus_new=zeros(5,1000);
wminus_new=zeros(5,1000);


for j=1:length(initials_wR)
    
    wR_new(j,1)=initials_wR(j);
    wL_new(j,1)=initials_wL(j);    
    wplus_new(j,1)=wR_new(j,1)+wL_new(j,1);
    wminus_new(j,1)=wR_new(j,1)-wL_new(j,1);
    
    for i=1:999
    
      
    wR_new(j,i+1)=wR_new(j,i)+dt * 1/2* (cs_an*wR_new(j,i)+cd_an(3)*wL_new(j,i)-cd_an(3)*wR_new(j,i)-cs_an*wL_new(j,i));

    wL_new(j,i+1)=wL_new(j,i)+dt * 1/2 *(cd_an(3)*wR_new(j,i)+cs_an*wL_new(j,i)-cs_an*wR_new(j,i)-cd_an(3)*wL_new(j,i));

    
    wplus_new(j,i+1)= 0;
    wminus_new(j,i+1)= wminus_new(j,i)+ dt *(wminus_new(j,i)*(cs_an-cd_an(3)));
     
    wR_new(wR_new<0)=0;
    wR_new(wR_new>1)=1;
    wL_new(wL_new<0)=0;
    wL_new(wL_new>1)=1;
    
    end
    
   
    hold on
    plot(wL_new(j,:),wR_new(j,:),'color',color(j), 'LineWidth',3)
    axis([0 1 0 1])
    
end
set(gca,'FontSize',16);
xlabel('w_L','FontSize',25);
ylabel('w_R','FontSize',25);
title('\gamma=0.5,  Different Initial Points','FontSize',25);
legend('I.P=0.26,0.70','I.P= 0.35,0.58','I.P=0.40,0.50','I.P=0.60,0.75','I.P=0.75,0.30');
hold off


% another trial with initial points 
% this time many initials at gamma=0.5

n=30; % number of initial points
new_intl_wR=0.25+(0.75-0.25)*rand(1,n);
new_intl_wL=0.25+(0.75-0.25)*rand(1,n);
wR_n=zeros(n,1000);
wL_n=zeros(n,1000);

for j=1:n
    
    wR_n(j,1)=new_intl_wR(j);
    wL_n(j,1)=new_intl_wL(j);    
    
    for i=1:999
    
    wR_n(j,i+1)=wR_n(j,i)+dt * 1/2* (cs_an*wR_n(j,i)+cd_an(3)*wL_n(j,i)-cd_an(3)*wR_n(j,i)-cs_an*wL_n(j,i));

    wL_n(j,i+1)=wL_n(j,i)+dt * 1/2 *(cd_an(3)*wR_n(j,i)+cs_an*wL_n(j,i)-cs_an*wR_n(j,i)-cd_an(3)*wL_n(j,i));
     
    wR_n(wR_n<0)=0;
    wR_n(wR_n>1)=1;
    wL_n(wL_n<0)=0;
    wL_n(wL_n>1)=1;
    
    end
    
   
    hold on
    plot(wL_n(j,:),wR_n(j,:),'LineWidth',3)
    axis([0 1 0 1])
    
 end
set(gca,'FontSize',16);
title('Different Initial Points at \gamma =0.5','FontSize',25)
xlabel('w_L','FontSize',25);
ylabel('w_R','FontSize',25);
hold off

Comp_wplus=wplus_new(4,:)-wplus_new(3,:);
Comp_wminus=wminus_new(4,:)-wminus_new(3,:);

sum(diff(Comp_wplus));  %-5.5511e-017
sum(diff(Comp_wminus)); %9.3782e+014


