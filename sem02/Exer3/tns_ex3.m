
v1_0=0.1;
v2_0=0.3;

M=[0.5 0.5; 0 0.5];
tau=[0.5 1 2 4];
t_step=50;
v1=zeros(numel(tau),t_step);
v2=zeros(numel(tau),t_step);
v1(1)=v1_0;
v2(1)=v2_0;
color='bkrg';

for j=1:numel(tau)
    for i=1:t_step-1
    v1(j,i+1)=  (1*v1(i) + tanh( M(1,1) *v1(i) + M(1,2)*v2(i) )) /1;
    v2(j,i+1)=( (tau(j)-1) / tau(j) )* v2(i) + tanh( M(2,2)*v2(i) )/ tau(j);
    end
    
    figure(1);
    hold on
    plot(1:t_step,v1(j,:), color(j),'LineWidth',2);
    hold off
    xlabel('50 time steps','FontSize',16);
    ylabel('v_1^t','FontSize',16);
    title('Network Output v_1^t with 4 Different \tau Values','FontSize',16)

    
    figure(2);
    hold on
    plot(1:t_step,v2(j,:), color(j),'LineWidth',2);
    hold off
    xlabel('50 time steps','FontSize',16);
    ylabel('v_2^t','FontSize',16);
    title('Network Output v_2^t with 4 Different \tau Values','FontSize',16)

end

