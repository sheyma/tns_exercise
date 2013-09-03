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
c=fzero(@(x) 150*tanh((20+(lambda-1-alpha*lambda)*x)/150) - x, c_s(index))



%--------------------------------------------------------------------------
%The vectors vn to be memorized
%create num_pat random sparse vectors vn with activity c
vn=zeros(N, num_pat);
for v=1:num_pat
    for i=1:floor(N*alpha)
        vn(1+floor(rand(1)*N),v)=c; 
    end
end

%change vectors 1 and 2 so that in the first components 18-30 are active
%and in the second every 4th component is active (compare p. 265 figure
%7.16).
%vn(:,1)=
%vn(:,2)=

%output to console
vn
%--------------------------------------------------------------------------
%Create Network: apply 7.48 page 263
n=ones(N,1);
sum_matrix=zeros(N,N);
for v=1:num_pat
   sum_matrix=sum_matrix + (vn (:,v) - alpha*c.*n)*(vn (:,v) - alpha*c.*n)';
end

K = (lambda/(c^2*alpha*N*(1-alpha))).*sum_matrix;
M = K - (1/(alpha*N)).*(n*n');



%--------------------------------------------------------------------------
%Test

%input vector number from memory set vn
vector=1;
%noise vector additively with normal distributed noise
strength=0;
v_start=vn(:,vector) + abs(randn(N,1))*strength;

%number of relaxation steps
steps=50; 
v=v_start;
output=zeros(N, steps);
for i = 1:steps
    v_new = 150*(tanh((M*v + 20)*(1/150)));
    v_new(v_new<0)=0; %[]+
    v = v_new;
    output(:,i)=v;
end

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
c=fzero(@(x) 150*tanh((20+(lambda-1-alpha*lambda)*x)/150) - x, c_s(index))



%--------------------------------------------------------------------------
%The vectors vn to be memorized
%create num_pat random sparse vectors vn with activity c
vn=zeros(N, num_pat);
for v=1:num_pat
    for i=1:floor(N*alpha)
        vn(1+floor(rand(1)*N),v)=c; 
    end
end

%change vectors 1 and 2 so that in the first components 18-30 are active
%and in the second every 4th component is active (compare p. 265 figure
%7.16).
%vn(:,1)=
%vn(:,2)=

%output to console
vn
%--------------------------------------------------------------------------
%Create Network: apply 7.48 page 263
n=ones(N,1);
sum_matrix=zeros(N,N);
for v=1:num_pat
   sum_matrix=sum_matrix + (vn (:,v) - alpha*c.*n)*(vn (:,v) - alpha*c.*n)';
end

K = (lambda/(c^2*alpha*N*(1-alpha))).*sum_matrix;
M = K - (1/(alpha*N)).*(n*n');



%--------------------------------------------------------------------------
%Test

%input vector number from memory set vn
vector=1;
%noise vector additively with normal distributed noise
strength=0;
v_start=vn(:,vector) + abs(randn(N,1))*strength;

%number of relaxation steps
steps=50; 
v=v_start;
output=zeros(N, steps);
for i = 1:steps
    v_new = 150*(tanh((M*v + 20)*(1/150)));
    v_new(v_new<0)=0; %[]+
    v = v_new;
    output(:,i)=v;
end

subplot(1,2,1);
bar(1:N,  v_start, 'r');
set(gca,'FontSize',16);
axis([1 N+1 0 30]);
xlabel('unit','FontSize',20);
ylabel('activity','FontSize',20);
title('Initial activities of input pattern, v^1','FontSize',20);
 
subplot(1,2,2);
bar(1:N,  output(:,steps), 'r');
set(gca,'FontSize',16);
axis([1 N+1 0 30]);
xlabel('unit','FontSize',20);
ylabel('activity','FontSize',20);
title('Activities after relaxation of 50 time steps','FontSize',20);

