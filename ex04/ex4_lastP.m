% THEORETICAL NEUROSCIENCE - EX.4, SEYMA BAYRAK %
% -LIF Model with spike frequency adaptation-
% Part 2

% creating a vector for varying dg_sra values between 0 and 0.15
% (dg_sra, as defined in 1st part, iterative-change for K+ channel
% conductance (micro .S/mm^2) )

dg=0:0.01:0.15;          % dg_sra is defined as a new vector named "dg"   
a=[];

for i=1:(length(dg));
    a(i)=sra_LIF(dg(i)); % for each different dg, spike rate is saved in a
end

plot(dg,a)
title('Spike Rate against Varying dg_{sra} Values')
xlabel('dg_{sra} [micro.S/mm^2]')
ylabel('Spike Rate Frequency (Hz)')