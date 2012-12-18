% THEORETICAL NEUROSCIENCE EXERCISE 9 - SEYMA BAYRAK

% Optimal Decision

N=10000;
a=12;
s=zeros(1,N)+0;
s1=zeros(1,N);
r=VisResp(s);
theta=8;
Hon=zeros(1,a+1);
Hoff=zeros(1,a+1);
TRAPZ=zeros(1,a+1);

for i=0:a
    
    % Creating light levels between 0 and 12
    s1=zeros(1,N)+i;

    % For each theta Hon and Hoff is computed
    for theta=0:1:30                
       r0=VisResp(s);
       r1=VisResp(s1);
       h=r1>=theta;
       Hon(theta+1)=sum(h)/N;       % hit =right alarm
       k=r0>=theta;
       Hoff(theta+1)=(sum(k))/N;    % fake alarm
    end
   
    TRAPZ(i+1)= trapz(Hoff,Hon);    
    % "trapz"calculates area under each curve
    
    figure(1);
    subplot(1,2,1)
    hold on
    plot(Hoff,Hon)
    title('ROC CURVE')
    xlabel('F(\theta)')
    ylabel('H(\theta)')
    hold off
    Pcor=Hon./(Hoff+Hon);
   
end

subplot(1,2,2)
plot(0:1:a, -TRAPZ)
title('Proportionality Correct vs Light Levels')
xlabel('Light Levels s between 0 and 12')
ylabel('P_{correct}')

