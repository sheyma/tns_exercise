n=50;
theta=linspace(0,pi,50);
r1=[]; 
r2=[]; 
m1=[];
m1s=[];
st1=[];
m2=[];
m2s=[];
st2=[];

N=300;

for i=1:50
    for j=1:N
        S=OnBar(n,theta(i));
     
        r1(i,j)=MysteriousNeuron1(S);
        r2(i,j)=MysteriousNeuron2(S);
 
    end
    m1(i)=sum (r1(i,1:length(r1)))*(1/N);
    m1s(i)=sum (r1(i,1:length(r1)).^2)*(1/N);
    st1(i)=sqrt( (m1s(i)-m1(i)^2)*(N/(N-1))  );
    
    m2(i)=sum (r2(i,1:length(r2)))*(1/N);
    m2s(i)=sum (r2(i,1:length(r2)).^2)*(1/N);
    st2(i)=sqrt( (m2s(i)-m2(i)^2)*(N/(N-1))  );
  
    
end

subplot(1,2,1)
plot(theta/3.14,m1)
axis([0 1 0 7])
xlabel('Angle (x pi)'  )
ylabel('Average Value of Stimulus')
title('Stimulus of First Neuron at Varying Angle')

subplot(1,2,2)
plot(theta/3.14,m2)
axis([0 1 0 12])
xlabel('Angle (x pi)'  )
ylabel('Average Value of Stimulus')
title('Stimulus of Second Neuron at Varying Angle')

figure;

subplot(1,2,1)
plot(theta/3.14, st1)
axis([0 1 0 7])
xlabel('Angle (x pi)'  )
ylabel('Standart Deviation of Stimulus - 1st Neuron')
title('Standart Deviation at Varying Angle')

subplot(1,2,2)
plot(theta/3.14,st2)
axis([0 1 0 1.8])
xlabel('Angle (x pi)'  )
ylabel('Standart Deviation of Stimulus - 2nd Neuron')
title('Standart Deviation at Varying Angle')


