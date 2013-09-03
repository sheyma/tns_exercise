%Analysis of a 2d nonlinear system
%E'=1/te * (-E+S(aE-I+K))
%I'=1/ti * (-I+S(bE))

close all;
clear all;

k=0;
te=5;
ti=10;

a=1.6;
b=1.5;
M=100;
s=30;

%discrete evalulation in state space. Enter start coordinates:
start_e=76.6339;  
start_i=21.9285;
steps=50;

tr=zeros(steps+1,3);
tr(1,:)=[1 start_e start_i];
for l=1:1:steps
  tr(l+1,:)=[l tr(l,2)+(1/te)*(-tr(l,2)+getS(a*tr(l,2)-tr(l,3)+k, M, s)) tr(l,3)+(1/ti)*(-tr(l,3)+getS(b*tr(l,2), M, s))];
end

figure;
plot(tr(:,2), tr(:,3), 'k+','LineWidth',2); hold on;
plot(tr(1,2), tr(1,3), 'ro','LineWidth',2);
axis([-10, 100, -10, 100]);
xlabel('E','fontsize',12);
ylabel('I','fontsize',12);
title('Discrete evaluation: red-o initial point','fontsize',12);



%flowfield and isoclines
%pre-allocating space
flowfield=zeros(20^2,4);
flowfield_i1=zeros(100,4);
flowfield_i2=zeros(100,4);
flowfield_i3=zeros(100,4);
iso=zeros(100,4);

%flowfield
l=1;
for i=0:5:100 
    for e=0:5:100
        flowfield(l,:)=[e i (1/te)*(-e+getS(a*e-i+k,M,s)) (1/ti)*(-i+getS(b*e,M,s))];
        l=l+1;
    end
end

%isoclines
l=1;
for e=0:1:100
     iso(l,:)=[e getS(b*e,M,s) a*e+k-s*sqrt(e/(M-e)) a*e+k+s*sqrt(e/(M-e))];
     %flowfield on the isoclines
     flowfield_i1(l,:)=[e getS(b*e,M,s) (1/te)*(-e+getS(a*e-getS(b*e,M,s)+k,M,s)) (1/ti)*(-getS(b*e,M,s)+getS(b*e,M,s))];
     flowfield_i2(l,:)=[e a*e+k-s*sqrt(e/(M-e)) (1/te)*(-e+getS(a*e-(a*e+k-s*sqrt(e/(M-e)))+k,M,s)) (1/ti)*(-(a*e+k-s*sqrt(e/(M-e)))+getS(b*e,M,s))];
     flowfield_i3(l,:)=[e a*e+k+s*sqrt(e/(M-e)) (1/te)*(-e+getS(a*e-(a*e+k+s*sqrt(e/(M-e)))+k,M,s)) (1/ti)*(-(a*e+k+s*sqrt(e/(M-e)))+getS(b*e,M,s))];
     l=l+1;
end

%intersections
ind1=find(diff(sign(iso(:,2)-iso(:,3)))); % find indices with changes in sign
ind2=find(diff(sign(iso(:,2)-iso(:,4)))); 

f1=@(X) (getS(b*X,M,s) - (a*X+k-s*sqrt(X/(M-X))));
f2=@(X) (getS(b*X,M,s) - (a*X+k+s*sqrt(X/(M-X))));

intersections=zeros(numel(ind1)+numel(ind2)-1,2);
l=1;
if (f1(0)==0 || f2(0)==0)
    intersections(1,:)=[0 0];
    l=2;
end
for i=1:numel(ind1)
    if (ind1(i)-1>0)
      intersections(l,1)=fzero(f1, ind1(i)-1);
      intersections(l,2)=getS(b*intersections(l,1),M,s);
      l=l+1;
    end
end
for i=1:numel(ind2)
    if (ind2(i)-1>0)
      intersections(l,1)=fzero(f2, ind2(i)-1);
      intersections(l,2)=getS(b*intersections(l,1),M,s);
      l=l+1;
    end
end
intersections 

%plot flowfield and isoclines
figure;
quiver(flowfield(:,1), flowfield(:,2), flowfield(:,3),flowfield(:,4)); hold on;
quiver(flowfield_i1(:,1), flowfield_i1(:,2), flowfield_i1(:,3),flowfield_i1(:,4)); 
quiver(flowfield_i2(:,1), flowfield_i2(:,2), flowfield_i2(:,3),flowfield_i2(:,4)); 
quiver(flowfield_i3(:,1), flowfield_i3(:,2), flowfield_i3(:,3),flowfield_i3(:,4)); 

plot(iso(:,1), iso(:,2), 'r-','LineWidth',2);
plot(iso(:,1), iso(:,3), 'b-+','LineWidth',2);
plot(iso(:,1), iso(:,4), 'g-o','LineWidth',2);
plot(intersections(:,1),intersections(:,2),'ko','Linewidth',8)

axis([0,100, 0, 100]); 
xlabel('dE','fontsize',12);
ylabel('dI','fontsize',12);
title('Non-linear system: Isocline I_2 (blue),Isocline I_3  (green), Isocline I_1 (red)','fontsize',12);

 
% %eigenvaules of the Jacobian matrix. Evaluate matrix at intersetcion
% point

e=32.1596;
i=72.1106;
hh=a*e-i+k;
jacobian=[ (((2*M*a*hh*s^2)/(s^2+hh^2)^2)-1)/te (-2*M*hh*s^2)/(te*(s^2+hh^2)^2); (1/ti)*(2*M*s^2*b^2*e)/(s^2+b^2*e^2)^2 -1/ti]
eigenvalues=eig(jacobian)
