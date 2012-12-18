n=50;

% WhiteNoise, MysteriousNeuron1
r5=zeros(1,50000);
S5=zeros(n,n);
for i=1:50000
    W=WhiteNoise(n);
    r5(i)=MysteriousNeuron1(W);
    S5=S5+W*r5(i);
end
S5=S5/sum(r5);
figure;
subplot(1,2,1)
pcolor(S5)
title('White Noise Simulation - 1st Neuron')

% WhiteNoise, MysteriousNeuron1
r6=zeros(1,50000);
S6=zeros(n,n);
for i=1:50000
    W=WhiteNoise(n);
    r6(i)=MysteriousNeuron2(W);
    S6=S6+W*r6(i);
end
S6=S6/sum(r6);
subplot(1,2,2)
pcolor(S6)
title('White Noise Simulation - 2nd Neuron')