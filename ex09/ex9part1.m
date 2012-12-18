% THEORETICAL NEUROSCIENCE EXERCISE 9 - SEYMA BAYRAK

% Describing the Responce 

N=10000;              % vector of size of input vector
ss=12;                % max value of given light level
ave=zeros(1,ss+1);    % ave has ss+1=13 Coloumns!
s1=zeros();

for i=0:ss            % 0 < given light level (ss) < 12
    s=zeros(1,N)+i;   % setting ss to a value at each step
    r=VisResp(s);     % finding response corresp. to ss
    ave(i+1)=mean(r); % getting average response  
        
end

% Probability Distribution

a=[0 3 12];           % new light level just when ss=0,3,12
n=zeros(3,10);        % empty 3x10 matrix for count numbers
bin=n;                % empty 3x10 matrix for response int.  
Area=zeros(1,3);      % empty 1x3 matrix for area

for j=1:length(a)
            tmp=zeros(1,N)+a(j);        
            r1=VisResp(tmp);        % response for ss=0,3,12
            [n1 bin1]=hist(r1, 10); % response distribution
            n(j,:)=n1;              % counts saved
            bin(j,:)=bin1;          % response int. saved
            Area(j)=sum(n1)*(bin1(2)-bin1(1));  % area 
end


figure(1);
plot((0:1:12),ave)
title('Average Response for Different Light Levels')
xlabel('Light Level s,   0 < s < 12')
ylabel('Avera Response <r(s)>')

figure(2);
for k=1:3
    subplot(1,3,k)
    plot(bin(k,:), (n(k,:)/Area(k)))
    title('Probability Distribution ')
    xlabel('Light Level')
    ylabel('Response Distribution, p(r|s)')
    A1=sum(n(k,:))/Area(k)*(bin(k,2)-bin(k,1));
    fprintf('Area under the probability distribution of graph') 
    fprintf(' number %1.0f is %1.0f ! \n', k, A1)
end











    








    