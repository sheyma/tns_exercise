% 3.5 inhibitory conditioning

eps=0.1;
p10=1/2;
p00=1;
p01=0;
p11=0;

r10=3/4;
r01=0;


inputs=zeros(2,400);
w=zeros(2,400);
reward=zeros(1,400);
delta=zeros(1,400);

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
        inputs(1,i)=0;
        inputs(2,i)=0;
        
        
        end
        
    
        if i<200
        
        delta(i)=reward(i)-w(:,i)'*inputs(:,i);
        w(:,i+1)=w(:,i)+eps*delta(i)*inputs(:,i);
        end
      
        
       
end

p11=1/2;
p00=1;
p01=0;
p10=0;

r11=3/4;
r01=0;

for i=200:400
        x=rand;
       
        if x<p11
        inputs(1,i)=1;
        inputs(2,i)=1;
        y=rand;
            if y<r11
                
                reward(i)=1;
                
            end
                
        
        else
        inputs(1,i)=0;
        inputs(2,i)=0;
        
        
        end
        
    
        if i<400
        
        delta(i)=reward(i)-w(:,i)'*inputs(:,i);
        w(:,i+1)=w(:,i)+eps*delta(i)*inputs(:,i);
        end
      
        
       
end


 ShowSequence(inputs, reward, delta, w )
