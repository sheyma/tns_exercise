n=50;
% OnSpot, MysteriousNeuron1
r1=zeros(1,50000);
S_bar1=zeros(n,n);


for i=1:50000
    K = OnSpot( n );
    r1(i)=MysteriousNeuron1(K);
    S_bar1=S_bar1+K*r1(i);
end

S_bar1=S_bar1/sum(r1);
figure;
subplot(1,2,1)
pcolor(S_bar1);
title('On-Spot (Bright Spots) Simulation - 1st Neuron')



% OnSpot, MysteriousNeuron2
r2=zeros(1,50000);
S_bar2=zeros(n,n);
for i=1:50000
    L = OnSpot( n );
    r2(i)=MysteriousNeuron2(L);
    S_bar2=S_bar2+L*r2(i);
end

S_bar2=S_bar2/sum(r2);
subplot(1,2,2)
pcolor(S_bar2);
title('On-Spot (Bright Spots) Simulation - 2nd Neuron')



