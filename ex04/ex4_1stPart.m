% THEORETICAL NEUROSCIENCE - EX.4, SEYMA BAYRAK %
% -LIF Model with spike frequency adaptation-
% Part 1 

% Defining parameters, a time and current vector firstly

T=600;                  % total time (ms)
dt=0.1;                 % time interval to be used in iteration (ms)
t=0:dt:T;               % time vector between 0 and 600 ms by incr. dt

EL=-65;                 % reversal leak potential (mV)
EK=-75;                 % reversal potentiol for K+ ion (mV)

Vrst=-65;               % reset potential for neuron (mV)
Vth=-45;                % threshold pot. for action pot. to be occured (mV)

i0=12;                  % amplitude of input current (nA/mm^2)
ie=zeros(1,length(t));  
ie=ie+i0;               % a constant valued input current vector  

cm=15;                  % capacitance of membrane per unit area (nF/mm^2)

% Conductances (micro .S/mm^2)
gL=0.5;                 % leak conductance 
g_sra(1)=0;             % 1st element of conduc. vector of K+ channel 
dg_sra=0.05;            % increment of g_sra subsequent elements

V_eff=[];               % an empty vector for effective equilib. potential
V(1)=EL;                % membrane potential at time=0 is -65 mV
t_eff=[];               % an empty vector-effective value of time constant
t_sra= 250;             % (ms)

% Computation of g_sra, t_eff, V_eff, V iteratively 
% note: g_sra is time dependent, therefore also t_eff and V_eff

for i=1:(length(t)-1)
    
    if V(i)<Vth          % if membrane potential exceeds threshold value
        
        g_sra(i+1)=g_sra(i)*exp(-dt/t_sra);
        t_eff(i)=cm/(gL+g_sra(i));
        V_eff(i)=(gL*EL+g_sra(i)*EK+ie(i))/(gL+g_sra(i));
        V(i+1)=V_eff(i)+(  V(i)- V_eff(i)  )*exp(-dt/t_eff(i));
        
    else                % if membrane potential is below of threshold val.

        g_sra(i+1)=g_sra(i)+dg_sra;
        t_eff(i)=cm/(gL+g_sra(i));
        V_eff(i)=(gL*EL+g_sra(i)*EK+ie(i))/(gL+g_sra(i));
        V(i+1)=Vrst;
    end
    
end

subplot(1,2,1)
plot(t,V)
title('Membrane Potential vs Time')
xlabel('Time [ms]')
ylabel('Membrane Potential, V_m [mV]')
axis([0 600 -70 -40])

subplot(1,2,2)
plot(t,g_sra)
title('K^+ Channel Conductance vs Time')
xlabel('Time [ms]')
ylabel('Conductivity of K^+ channel, g_{sra} [micro.S/mm^2]')
axis([0 600 -0.02 0.12])

