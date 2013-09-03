%"learning" an associative memory
clear all;
close all;

%number of units
N = 50;
%sparseness
alpha = 0.25;
%eigenvalue
lambda = 1.25;
%number of patterns to memorize
num_pat = 4;


%--------------------------------------------------------------------------
%determining constant c according to 7.49 p. 264
%F(I)=150tanh((20+I)/150)
c_max=100;
c_s=0:0.1:c_max;
f_s=150*tanh((20+(lambda-1-alpha*lambda).*c_s)./150) - c_s;
for i=1:length(f_s)-1
    if f_s(i)*f_s(i+1)<0  %find zero crossing
        index=i;
        i=length(f_s)-1;
    end  
end

%determine c=zeros near index
c=fzero(@(x) 150*tanh((20+(lambda-1-alpha*lambda)*x)/150) - x, c_s(index));



%--------------------------------------------------------------------------
%The vectors vn to be memorized
%create num_pat random sparse vectors vn with activity c
vn=zeros(N, num_pat);
for v=1:num_pat
    for i=1:floor(N*alpha)
        vn(1+floor(rand(1)*N),v)=c; 
    end
end


vn(:,1)=zeros(50,1);
vn(:,2)=zeros(50,1);
vn(:,3)=zeros(50,1);
vn(:,4)=zeros(50,1);

for i=19:30
    vn(i,1)=c;
end

for i=1:50
    if (rem(i,4)==0)
     vn(i,2)=c;
    end
end

for i=39:50
    vn(i,3)=c;
end

for i=1:36
    if rem(i,3)==0
        vn(i,4)=c;
    end
end

%output to console
vn;
%--------------------------------------------------------------------------
%Create Network: apply 7.48 page 263
n=ones(N,1);
sum_matrix=zeros(N,N);
for v=1:num_pat
   sum_matrix=sum_matrix + (vn (:,v) - alpha*c.*n)*(vn (:,v) - alpha*c.*n)';
end

K = (lambda/(c^2*alpha*N*(1-alpha))).*sum_matrix;
M = K - (1/(alpha*N)).*(n*n');


% Find activation function F iteratively for 4 v-vectors

t_step=50;
strength=4;

v0_1=vn(:,1);
v0_2=vn(:,2);
v0_3=vn(:,3);
v0_4=vn(:,4);

% output MATRICES
vt_1=zeros(N,t_step);
vt_2=zeros(N,t_step);
vt_3=zeros(N,t_step);
vt_4=zeros(N,t_step);

vt_1(:,1)=v0_1 + abs(randn(N,1))*strength;
vt_2(:,1)=v0_2 + abs(randn(N,1))*strength ;
vt_3(:,1)=v0_3 + abs(randn(N,1))*strength;
vt_4(:,1)=v0_4 + abs(randn(N,1))*strength;

for i = 1:t_step-1
    vt_1(:,i+1)=150*tanh( (M*vt_1(:,i) +20) /150 );
    vt_1(vt_1<0)=0; %[];
   
    vt_2(:,i+1)=150*tanh( (M*vt_2(:,i) +20) /150 );
    vt_2(vt_2<0)=0; %[];
   
    vt_3(:,i+1)=150*tanh( (M*vt_3(:,i) +20) /150 );
    vt_3(vt_3<0)=0; %[];

    vt_4(:,i+1)=150*tanh( (M*vt_4(:,i) +20) /150 );
    vt_4(vt_4<0)=0; %[];

end

% desired starting vector and output matrix
% please insert the vector and its output matrix correctly!!
v_start=        vt_3(:,1);
output=         vt_3(:,t_step);


subplot(1,2,1);
bar(1:N,  v_start, 'r');
set(gca,'FontSize',16);
axis([1 N+1 0 30]);
xlabel('unit','FontSize',20);
ylabel('activity','FontSize',20);
title(['Initial activities of input pattern, strength=', num2str(strength)],'FontSize',20);
 
subplot(1,2,2);
bar(1:N,  output, 'r');
set(gca,'FontSize',16);
axis([1 N+1 0 30]);
xlabel('unit','FontSize',20);
ylabel('activity','FontSize',20);
title('Activities after relaxation of 50 time steps','FontSize',20);

%strength for v0_1
strength_1=0:0.2:2.2;
performance_1=[ones(1,8)*100 60 20 10 0];
figure;
subplot(2,2,1)
plot(strength_1,performance_1,'LineWidth',4);
set(gca,'FontSize',16);
xlabel('strength','FontSize',20);
ylabel('performance (100%)','FontSize',20);
title( 'v^1','FontSize',20);


%strength for v0_2
strength_2=[0 0.2 0.4 0.5:0.1:1.5];
performance_2=[ones(1,9)*100 40 30 10 0 0];
subplot(2,2,2)
plot(strength_2,performance_2,'LineWidth',4);
set(gca,'FontSize',16);
xlabel('strength','FontSize',20);
ylabel('performance (100%)','FontSize',20);
title('v^2','FontSize',20);


%strength for v0_3
strength_3=[0 1 2 2.3:0.2:3.7];
performance_3=[100 100 100 100 100 80 60 40 20 10 0];
subplot(2,2,3)
plot(strength_3,performance_3,'LineWidth',4);
set(gca,'FontSize',16);
xlabel('strength','FontSize',20);
ylabel('performance (100%)','FontSize',20);
title('v^3','FontSize',20);


%strength for v0_4
strength_4=0:0.2:2.4;
performance_4=[ ones(1,7)*100 90 60 30 20 0 0];
subplot(2,2,4)
plot(strength_4,performance_4,'LineWidth',4);
set(gca,'FontSize',16);
xlabel('strength','FontSize',20);
ylabel('performance (100%)','FontSize',20);
title('v^4','FontSize',20);