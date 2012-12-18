n=50;
theta=linspace(0,pi,50);
 r3=[];
 r4=[]; 

m3=[];
m3s=[];
st3=[];
m4=[];
m4s=[];
st4=[];

N=300;


for i=1:50
    for j=1:N
        
        D=OffBar(n,theta(i));
       
        r3(i,j)=MysteriousNeuron1(D);
        r4(i,j)=MysteriousNeuron2(D);
    end

    m3(i)=sum (r3(i,1:length(r3)))*(1/N);
    m3s(i)=sum (r3(i,1:length(r3)).^2)*(1/N);
    st3(i)=sqrt( (m3s(i)-m3(i)^2)*(N/(N-1))  );
    
    m4(i)=sum (r4(i,1:length(r4)))*(1/N);
    m4s(i)=sum (r4(i,1:length(r4)).^2)*(1/N);
    st4(i)=sqrt( (m4s(i)-m4(i)^2)*(N/(N-1))  );
    
    
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

