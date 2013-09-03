% 3.4 inhibitory conditioning

eps=0.1;
p11=1;
p00=0;
p01=0;
p10=1/2;

r10=3/4;
r01=0;

step=200;
inputs=zeros(2,200);
w=zeros(2,200);
reward=zeros(1,200);
delta=zeros(1,200);

for i=1:200
        x=rand;
       
        if x<p10
        inputs(1,i)=1;
        inputs(2,i)=0;
        y=rand;
            if y<r10
                
                reward(i)=1;
                
            end
                
        
        else
        inputs(1,i)=1;
        inputs(2,i)=1;
        
        
        end
        
    
        if i<200
        
        delta(i)=reward(i)-w(:,i)'*inputs(:,i);
        w(:,i+1)=w(:,i)+eps*delta(i)*inputs(:,i);
        end
      
        
end
    ShowSequence(inputs, reward, delta, w )
