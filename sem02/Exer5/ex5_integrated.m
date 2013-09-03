
N=40;               % number of neruons in upstream population
M=50;               % number of neurons in downstream population
Rmax=1;             % unitary response
kappa=0.1;
sigma=50;
nu_max=1000;        % maximum value of preferred random frequency

% define preferred direction for each neuron in both populations
nupref_ran1=nu_max*rand(1,N);     %v_pref for upstream population
nupref_ran2=nu_max*rand(1,M);     %v_pref for downstream population

nu_train=1000*rand(1,12*N);


[r1_mean r1_noisy] =GaussResp_LinearSTD(nu_train,nupref_ran1,Rmax,kappa);

[r2_mean r2_noisy]=GaussResp_ConstantSTD(nu_train,nupref_ran2,Rmax,sigma);


r1_mean(r1_mean<0)=0;
r2_mean(r2_mean<0)=0;
r1_noisy(r1_noisy<0)=0;
r2_noisy(r2_noisy<0)=0;

color='brg';
figure(1);
for i=1:3
    subplot(2,1,1)   
    hold on
    set(gca,'FontSize',16);
    plot(nu_train, r1_mean(:,i),'.','color',color(i),'LineWidth',8)
    xlabel('\nu', 'FontSize',20);
    ylabel('Response Function', 'FontSize',20);
    title('Upstream Population, without Noise','FontSize',20);
    hold off
    
    subplot(2,1,2)
    hold on
    plot(nu_train, r2_mean(:,i),'.','color',color(i),'LineWidth',8)
    set(gca,'FontSize',16);
    xlabel('\nu', 'FontSize',20);
    ylabel('Response Function', 'FontSize',20);
    title('Downstream Population, without Noise','FontSize',20);
    hold off
end


figure(2);
for i=1:3
    subplot(2,1,1)   
    hold on
    plot(nu_train, r1_noisy(:,i),'.','color',color(i))
    set(gca,'FontSize',16);
    xlabel('\nu', 'FontSize',20);
    ylabel('Response Function', 'FontSize',20);
    title('Upstream Population, with Noise','FontSize',20);
    hold off

    subplot(2,1,2)
    hold on
    plot(nu_train, r2_noisy(:,i),'.','color',color(i))
    set(gca,'FontSize',16);
    xlabel('\nu', 'FontSize',20);
    ylabel('Response Function', 'FontSize',20);
    title('Downstream Population, with Noise','FontSize',20);
    hold off
end

% Wji = covariance( Ri, Rj )
cov_mean=covariance(r1_mean,r2_mean);
cov_noisy=covariance(r1_noisy,r2_noisy);

figure(3);
subplot(1,2,1)
pcolor(cov_mean);
axis ('square');
set(gca,'FontSize',16);
xlabel('Upstream Population, N=40', 'FontSize',20);
ylabel('Downstream Population, M=50', 'FontSize',20);
title('Covariance without Noise','FontSize',20);
subplot(1,2,2)
pcolor(cov_noisy);
axis ('square');
set(gca,'FontSize',16);
title('Covariance with Noise', 'FontSize',20);
ylabel('Downstream Population', 'FontSize',20);
xlabel('Upstream Population', 'FontSize',20);

% create a new frequency vector to test feed-forward connectivity
nu_test=1000*rand(1,12*N);
[r1test_mean r1test_noisy] =GaussResp_LinearSTD(nu_test,nupref_ran1,Rmax,kappa);

% calculate response R_{C,j} indirectly with feed-forward connectivity
r2test_mean=r1test_mean*cov_mean';
r2test_mean(r2test_mean<0)=0;           % assign negative elements to 0
r2test_noisy=r1test_noisy*cov_noisy';


% decoding downstream activity
 sum1=0;
 sum2=0;
for i=1:M
    sum1=sum1+r2test_mean(:,i)*nupref_ran2(:,i);
    sum2=sum2+r2test_mean(:,i);
end

nu_infer=(sum1./sum2)';
figure(4);
hold on;
set(gca,'FontSize',16);
plot(1:round(max(nu_test)),1:round(max(nu_test)),'r', 'LineWidth', 4);
plot(nu_test,nu_infer, '.');
xlabel('\nu_{test}', 'FontSize',20);
ylabel('\nu_{inferred}', 'FontSize',20);
hold off;
