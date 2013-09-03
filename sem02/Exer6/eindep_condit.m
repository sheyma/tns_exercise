% 3.3 Independent Conditioning

eps=0.1;                         % learning rate - constant
p11=0;
p00=0;
p01=1/2;
p10=1;

r10=1;
r01=3/4;

step=200;                        % number of trials
inputs=zeros(2,step);            % u_11, u_10, u_01, u_00   
w=zeros(2,step);                 % weights for corresponding inputs   
reward=zeros(1,step);            % reward of the i th trial - a vector
delta=zeros(1,step);             % the scalar for Rescola-Wagner Rule

for i=1:step
        x=rand;
       
        if x<p01
        inputs(1,i)=0;
        inputs(2,i)=1;
       
        y=rand;
            if y<r01
                
                reward(i)=1;
                
            end
                
        
        else
        inputs(1,i)=1;
        inputs(2,i)=0;
        reward(i)=1;
        
        end
        
    
        if i<step
            
        % Rescola-Wagner Rule
        delta(i)=reward(i)-w(:,i)'*inputs(:,i);
        w(:,i+1)=w(:,i)+eps*delta(i)*inputs(:,i);
        end
      
        
end
    
ShowSequence( inputs, reward, delta, w )