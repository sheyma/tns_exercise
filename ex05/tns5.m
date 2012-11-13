% THEORETICAL NEUROSCIENCE - EXERCISE 5  %
% The Hodgkin-Huxley Model               %
% Seyma BAYRAK %

% PART 1%

cm=10;                  % membrane capacitance (nF/mm^2)
gL = 3;                 % leaky conductance (microS/mm2)
gNa= 1200;              % Na+ channel conductance (microS/mm^2)
gK = 360;               % K+ channel conductance (microS/mm^2)
El = -54.402;           % leak reversal potential (mV)
Ena= 50;                % Na+ reversal potential (mV)
Ek = -77;               % K+ reversal potential (mV)
dt= 0.1;                % time increment (ms)
t = 0 : 0.1 : 40;       % time vector from 0 to 40 ms
ie = 0;                 % constant input current (nA/mm^2)

% empty vectors for channel opening-closing franctions

m = zeros(length(t),1); % fraction of open Na+ m gates
h = zeros(length(t),1); % fraction of open Na+ h gates
n = zeros(length(t),1); % fraction of open K+ n gates
n(1)=0.3;               % at t=0 ms, 3% of n gates are open!

tau_eff=zeros(length(t),1);
V_eff=zeros(length(t),1);
Vm=zeros(length(t),1);
Vm(1) = -70;            % initial value of membrane potential (mV)


for j=1:length(t)-1

 % variables to calculate m,h,n are found out through functions
 
[m_infty, tau_m] = HH_equi_tau_m(Vm(j)); 
[h_infty, tau_h] = HH_equi_tau_h(Vm(j));
[n_infty, tau_n] = HH_equi_tau_n(Vm(j));

% variables to calculate m,h,n are inserted into numerical solutions of
% their identical differential equation

dm=dt*(1/tau_m)*(m_infty-m(j));
m(j+1)=m(j)+dm;


dn=dt*(1/tau_n)*(n_infty-n(j));
n(j+1)=n(j)+dn;

dh=dt*(1/tau_h)*(h_infty-h(j));
h(j+1)=h(j)+dh;


V_eff(j)= (gL*El+gNa*m(j)^3*h(j)*Ena+ gK*n(j)^4*Ek+ie)  /...
          (gL+ gNa*m(j)^3*h(j) + gK*n(j)^4);

tau_eff(j)=cm/(gL+ gNa*m(j)^3*h(j) + gK*n(j)^4);

% All the computed values (m,h,n, V_eff, tau_eff are used to find Vm)

Vm(j+1)=V_eff(j)+ ( Vm(j)-V_eff(j) )*exp(-dt/ tau_eff(j));

end

V_rest=Vm(length(Vm));  % resting potential of membrane (mV)
fprintf('The resting potential of membrane is %2.4f mV\n', V_rest)


subplot(1,2,1)
hold on
plot(t,Vm)
title('Memrane Potential vs Time')
xlabel('Time [ms]')
ylabel('Membrane Potential, V_m [mV]')

subplot(1,2,2)
plot(t,[m n h])
axis([0 40 0 1])
title('Time Evolution of Gating Variables')
xlabel('Time [ms]')
ylabel('Gating Variable Fractions m,h,n')

