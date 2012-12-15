% Exercise 10

N1=19;
R_dark=5;
R_vis=40; % Hz
sigma=pi/2;
r=zeros(1,N1);
theta_i=zeros(1,N1);
theta_true=linspace(-pi,pi,100);


for i=1:N1
    theta_i(i)=((2*i-N1-2)/N1)*pi;
    
    for j=1:length(theta_true)
        r(j)=ave_response(theta_i(i), theta_true(j),R_vis,R_dark,sigma);
    end
    
    hold on
    plot(theta_true,r)
    hold off
end


r_t=ave_response(theta_i,theta_t,R_vis,R_dark,sigma);
x_i=one_response(r_t);


figure(2);
subplot(1,2,1)
plot(theta_i,r_t,'kx')
subplot(1,2,2)
plot(theta_i,x_i,'ro')


N2=19;
beta=((2*(1:N2)-N2-2)/N2)*pi;
theta_t=0;

R_true=zeros(1,N2);
x_true=zeros(1,N2);

figure(3);


for j=1:N2
    R=zeros(1,length(theta_true));
    for i=1:N1
        rr=ave_response(theta_i(i), theta_true,R_vis,R_dark,sigma);
        R=R+cos(theta_i(i)-beta(j))*rr;
    end
    hold on
    plot(theta_true,R)
    hold off 
end

for j=1:N2
    for i=1:N1
        rrr=ave_response(theta_i(i), theta_t,R_vis,R_dark,sigma);
        R_true(j)=R_true(j)+cos(theta_i(i)-beta(j))*rrr;
        x_true(j)=x_true(j)+cos(theta_i(i)-beta(j))*one_response(rrr);
    end
end

figure(4);
subplot(1,2,1)
plot(beta,R_true, 'kx')
subplot(1,2,2)
plot(beta,x_true, 'ro')


