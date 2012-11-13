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

%%% EULER'S METHOD FOR SIMPLE NUMERICAL INTEGRATION %%%

for i=1:(a-1)
    dV=dt*(1/tau)*(V_inf(i)-V_m(i));
    V_m(i+1)=V_m(i)+dV;
    
end


max(V_inf)
max(V_m)