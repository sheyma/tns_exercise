% Creating a function  
% Input argument is dg_sra, output argument is spk_rate 
% dg_sra, as defined in 1st part, iterative-change for K+ channel
% conductance (micro .S/mm^2)
% spk_rate, inverse of time interval between two spikes (Hz)  

function spk_rate = sra_LIF(dg_sra)

T=1000;                 % ms
dt=0.1;                 % ms
t=0:dt:T;

EL=-65;                 % mV
EK=-75;                 % mV
Vrst=-65;               % mV
Vth=-45;                % mV

i0=12;                  % amplitude of input current (nA/mm^2)
ie=zeros(1,length(t));
ie=ie+i0;

cm=15;                  % nF/mm^2
t_sra= 250;             % ms


gL=0.5;                 % micro .s/mm^2
g_sra(1)=0;             % micro .s/mm^2
V(1)=EL;

t_eff=[];

s=[];                   % !!Time points at which spikes occur!!
j=1;                    % position donation for elements in s vector 

for i=1:(length(t)-1)
    
    if V(i)<Vth         % the case where no spike occurs
        g_sra(i+1)=g_sra(i)*exp(-dt/t_sra);
        t_eff(i)=cm/(gL+g_sra(i));
        V_eff(i)=(gL*EL+g_sra(i)*EK+ie(i))/(gL+g_sra(i));
        V(i+1)=V_eff(i)+(  V(i)- V_eff(i)  )*exp(-dt/t_eff(i));
        
    else                % the case where spikes occur
        s(j)=t(i);      % whenever spike occurs, its time is pushed in s
        j=j+1;          % new spike occurance time is to be saved next
        g_sra(i+1)=g_sra(i)+dg_sra;
        t_eff(i)=cm/(gL+g_sra(i));
        V_eff(i)=(gL*EL+g_sra(i)*EK+ie(i))/(gL+g_sra(i));
        V(i+1)=Vrst;
    end
    
end

% time interval between last two spikes of membrane potential
t_isi=s(length(s))-s(length(s)-1);  % ms

% spike rate calculation for last two spikes 
r_isi=(1/t_isi)*1000 ;   % 1/ms=kHz, this is converted into Hz by x1000 

spk_rate=r_isi;          % output of above created function sra_LIF 


