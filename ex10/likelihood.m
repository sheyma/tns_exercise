function [x X L]=likelihood(theta_true)

N1=19;
N2=19;
R_dark=5;
R_vis=40; % Hz
sigma=pi/2;
kap=1/(1-cos(sigma));
theta_i=zeros(N1);
beta=zeros(N2);
r=zeros(N1,length(theta_true));
x=zeros(N1,length(theta_true));
X=zeros(1,100);

   
for i=1:N1
     
    theta_i(i)= ((2*i-N1-2)/N1)*pi;   
    
    for k=1:length(theta_true) 
       
      
       aci=angdiff(theta_i(i),theta_true(k));
       r(i,k)=R_dark+R_vis*exp(kap*cos(aci)-kap);
       x(i,k)=one_response(r(i,k)); 
        
       for j=1
       
           beta(j)=((2*j-N2-2)/N2)*pi;
           X(j,1:100)=X(j,1:100)+cos(theta_i(i)-beta(j))*x(i,:);

       end
      
    end

end








