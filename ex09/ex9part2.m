% THEORETICAL NEUROSCIENCE EXERCISE 9 - SEYMA BAYRAK

% Non-optimal decision

% Presence or Absence of Light



N=10000;
a=12;
s=zeros(1,N);             
s1=zeros(1,N);
r=VisResp(s);
theta=8;                    % decision criteria for detection
Hon=zeros(1,a+1);
Hoff=zeros(1,a+1);

% response r0 represents responses coming from light absence,
% it is calculated from an s vector having only zeros

% response r1 represents responses coming from light presence,
% it is calculated from non-zero s1 vectors

% responses greater than theta makes the observer to detect
% responses smaller than theta makes the observer not to det.


for i=0:a
  r0=VisResp(s);            % response only when s=0
  k=r0>=theta;              % if elements of r0>=theta, "fake" 
  Hoff(i+1)=(sum(k))/N;     % fraction of false alarms
  
  s1=zeros(1,N)+i;          % light level 0<=s<=12
  r1=VisResp(s1);           % response to s each time
  h=r1>=theta;              % if elements of r1>=theta, "hit"
  Hon(i+1)=sum(h)/N;        % fraction of "hits"; right alarm
end

P_correct=(Hon+1-Hoff)./2;  % Fraction of hits over all resp.       

figure(1);
subplot(1,2,1)
plot(0:1:a,Hon,0:1:a,Hoff,'--r')
title('Right Alarms (Hits) vs Light Levels')
ylabel('Proportion of Hits')
xlabel('Light Levels s between 0 and 12')
axis([0 12 0 1])
subplot(1,2,2)
plot(0:1:a,Hoff,'--r')
title('False Alarms vs Light Levels')
xlabel('Light Levels s between 0 and 12')
ylabel('Proportion of False Alarms')
axis([0 12 0 0.02])
  
figure(2);
plot(0:1:a,P_correct)
title('Neurometric Function')
xlabel('Light Levels s between 0 and 12')
ylabel('P_{correct}')




