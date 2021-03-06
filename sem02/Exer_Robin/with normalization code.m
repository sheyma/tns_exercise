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

wR(:,1)=0.22;
wL(:,1)=0.18;

% wR(1,1)=0.25;
% wR(2,1)=0.10;
% wR(3,1)=0.15;
% wR(4,1)=0.20;
% wR(5,1)=0.24;
% wL(1,1)=0.15;
% wL(2,1)=1.3;
% wL(3,1)=1.8;
% wL(4,1)=2.2;
% wL(5,1)=2.45;

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
    plot(wL(j,:),wR(j,:),'color',color(j))
    axis([0 0.5 0 0.5])
    
end
legend('gama=0','gama=0.25','gama=0.5','gama=0.75','gama=1');
hold off

wR_new=zeros(5,1000);
wL_new=zeros(5,1000);
initials_wR=[0.50 0.10 0.15 0.20 0.15];
initials_wL=[0.25 0.20 0.15 0.10 0.65];
wplus_new=zeros(5,1000);
wminus_new=zeros(5,1000);

figure;
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
    plot(wL_new(j,:),wR_new(j,:),'color',color(j))
    axis([0 1 0 1])
    
end
legend('I.P=0.25,0.50','I.P= 0.10,0.20','I.P=0.15,0.15','I.P=0.20,0.10','I.P=0.65,0.15');
hold off

Comp_wplus=wplus_new(4,:)-wplus_new(3,:);
Comp_wminus=wminus_new(4,:)-wminus_new(3,:);

sum(diff(Comp_wplus)); %-5.5511e-017
sum(diff(Comp_wminus)); %9.3782e+014

%Eigenvalues and Eig.vectors of Covariance Matrix at gamma=0.5
[V,D]=eig(Cov_an_3);

