n=50;
% OffSpot, MysteriousNeruron1
sca_1=zeros(1,50000);
Sit_1=zeros(n,n);
for i=1:50000
    M=OffSpot(n);
    sca_1(i)=MysteriousNeuron1(M);
    Sit_1=Sit_1+M*sca_1(i);
end

Sit_1=Sit_1/sum(sca_1);
figure;
subplot(1,2,1)
pcolor(Sit_1);
title('Off-Spot (Dark Spots) Simulation - 1st Neuron')

% OffSpot, MysteriousNeruron2
sca_2=zeros(1,50000);
Sit_2=zeros(n,n);
for i=1:50000
    N=OffSpot(n);
    sca_2(i)=MysteriousNeuron2(N);
    Sit_2=Sit_2+N*sca_2(i);
end
Sit_2=Sit_2/sum(sca_2);
subplot(1,2,2)
pcolor(Sit_2)
title('Off-Spot (Dark Spots) Simulation - 2nd Neuron')