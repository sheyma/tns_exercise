% THEORETICAL NEUROSCIENCE - EXERCISE 3 %
% SCHEYMA BAYRAK %

% LEAKY INTEGRATE & FIRE NEURON %

clear all;
T=500;                  % total time (ms)                 
dt=0.1;                 % time increment (ms)
i0=12;                  % amplitude of input currents (nA/mm^2)

t=0:dt:T;               % creating a time vector

a=length(t);            % input vector and time vectors having same length
b=(round(a/4));
ie=zeros(1,a);          % an imaginargy empty input current vector
ie(b:(3*b))=i0;         % modelling input current


subplot(1,2,1)
hold on
plot(t,ie, 'r')         % plotting time vs input current
title('STEP FUNCTIONE INPUT CURRENT VS TIME')
xlabel('Time (ms)')
ylabel('Input Current (nA/mm^2)')
axis([0 500 -15 15])

EL= -65;                % reversal potential (mV)
r= 1.5;                 % membrane resistance per unit area (M.ohm.mm^2)
c=20;                   % membrane capacitance per unit area (nF/mm^2)
tau=r*c;                % time constant = RC
t_s=[];                 % this vector is to be filled up with spike t
j=1;                    

V_res=-65;              % reset potential (mV)
V_th=-50;               % threshold potential (mV)
V_m=[EL];               % membrane potential vector, "V_m(1)=EL"
V_inf=EL+r*ie;          % equilibrium potential vector 

%% EULER'S METHOD FOR SIMPLE NUMERICAL INTEGRATION %%

for i=1:(a-1)
    dV=dt*(1/tau)*(V_inf(i)-V_m(i));
    V_m(i+1)=V_m(i)+dV;
    if V_m(i+1)>=V_th
        V_m(i+1)=V_res;
        t_s(j)=t(i);
        j=j+1;
        
    end
end

t_s
t_isi=t_s(2)-t_s(1);
r_isi=1/t_isi


subplot(1,2,2)
hold on
plot(t,V_m, 'b')
title('MEMBRANE POTENTIAL VS TIME')
xlabel('Time (ms)')
ylabel('V_m with Spike Mechanism (mV)')
axis([0 500 -70 -45 ])