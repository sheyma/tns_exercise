function [x X L]=likelihood(theta_true)

N1=19;
N2=19;
R_dark=5;
R_vis=40; % Hz
sigma=pi/2;
kap=1/(1-cos(sigma));
theta_i=zeros(1,N1);
beta=zeros(1,N2);
r=zeros(N1,length(theta_true));
x=zeros(N1,length(theta_true));
X=zeros(N2,length(theta_true));
L=zeros(N1,length(theta_true));
a=length(theta_true);

   
for i=1:N1
     
    theta_i(i)= ((2*i-N1-2)/N1)*pi;   
    
    for k=1:length(theta_true) 
       
       aci=angdiff(theta_i(i),theta_true(k));
       r(i,k)=R_dark+R_vis*exp(kap*cos(aci)-kap);
       x(i,k)=one_response(r(i,k)); 
       L(i,k)=x(i,k)*log(r(i,k))-r(i,k)-log(factorial(x(i,k)));
       
       for j=1:N2
    
           beta(j)=((2*j-N2-2)/N2)*pi;
           X(j,1:a)=X(j,1:a)+cos(theta_i(i)-beta(j))*x(i,:);

       end
    end
end

theta_k=zeros(1,length(theta_true));
beta_k=zeros(1,length(theta_true));


for k=1:length(theta_true)
       [maxEl maxInd]=max(x(1:N1,k));
       theta_k(k)=theta_i(maxInd);
        
end

    
for k=1: length(theta_true)
        
       [maxE  maxIn ]=max(X(1:N2,k));
       beta_k(k)=beta(maxIn);
end

for k=1: length(theta_true)
        
       [maxEle  maxIndex ]=max(L(1:N1,k));
       eps_k(k)=theta_true(maxIndex);
end


eps1=theta_k-theta_true;
eps2=beta_k-theta_true;
eps3=eps_k-theta_true;

mean(eps1)
mean(eps2)
mean(eps3)

mean((eps1-mean(eps1)).^2)
mean((eps2-mean(eps2)).^2)
mean((eps3-mean(eps3)).^2)
