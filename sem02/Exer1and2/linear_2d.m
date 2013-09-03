%Analysis of a 2d linear system
%E'=1/t * (E-aI+K)
%I'=1/t * (-I+bE-4K)

close all;
clear all;

k=0;
t=10;
a=2;
b=5;


%discrete evalulation in state space. Enter start coordinates:
start_e=3;  %stable in (k,k)only
start_i=3;
steps=50;

tr=zeros(steps+1,3);
tr(1,:)=[1 start_e start_i];
for l=1:1:steps
  tr(l+1,:)=[l tr(l,2)+(1/t)*(tr(l,2)-a*tr(l,3)+k) tr(l,3)+(1/t)*(-tr(l,3)+b*tr(l,2)-4*k)];
end

figure;
plot(tr(:,2), tr(:,3), 'k+','LineWidth',2); hold on;
plot(tr(1,2), tr(1,3), 'ro','LineWidth',2);
plot(k, k, 'b*','LineWidth',2);
axis([-10, 10, -10, 10]);
xlabel('E', 'fontsize',12);
ylabel('I','fontsize',12);
title('Discrete evaluation: blue-* equilibrium point; red-o initial point','fontsize',12);



%flowfield and isoclines
%pre-allocating space
flowfield=zeros(400,4);
iso=zeros(80,3);
flowfield_i1=zeros(80,4);
flowfield_i2=zeros(80,4);

%flowfield
l=1;
for i=-10:1:10 
    for e=-10:1:10
        flowfield(l,:)=[e i 1/t*(e-a*i+k) 1/t*(-i+b*e-4*k)];
        l=l+1;
    end
end

%isoclines
l=1;
for e=-10:0.25:10
    iso(l,:)=[e 0.5*(e+k) 5*e-4*k];
     %flowfield on the isoclines
    flowfield_i1(l,:)=[e 0.5*(e+k) 1/t*(e-a*(0.5*(e+k))+k) 1/t*(-(0.5*(e+k))+b*e-4*k)];
    flowfield_i2(l,:)=[e 5*e-4*k 1/t*(e-a*(5*e-4*k)+k) 1/t*(-(5*e-4*k)+b*e-4*k)];
    l=l+1;
end

%plot flowfield and isoclines
figure;
quiver(flowfield(:,1), flowfield(:,2), flowfield(:,3),flowfield(:,4)); hold on;
quiver(flowfield_i1(:,1), flowfield_i1(:,2), flowfield_i1(:,3),flowfield_i1(:,4)); 
quiver(flowfield_i2(:,1), flowfield_i2(:,2), flowfield_i2(:,3),flowfield_i2(:,4)); 
plot(iso(:,1), iso(:,2), 'r-','LineWidth',2);
plot(iso(:,1), iso(:,3), 'b-','LineWidth',2);
plot(k, k, 'b*','LineWidth',8);
axis([-10, 10, -10, 10]);
xlabel('dE','fontsize',12);
ylabel('dI','fontsize',12);
title('Linear system: Isocline 1 (red), Isocline 2 (blue)','fontsize',12);


%eigenvaules of the Jacobian matrix
jacobian=[1/t -a/t; b/t -1/t]
eigenvalues=eig(jacobian)
