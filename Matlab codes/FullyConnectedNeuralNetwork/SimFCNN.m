function Out=SimFCNN(u,w,NI,NO,NL,NNL,ActFunc,a,BiginnerState)

 w1 = w{1};
 w2 = w{2};

 u=[ones(size(u(:,1))),u];
 
[n,m]=size(u);

for i=1:NL
    y{i}=zeros(NNL(i),1)+BiginnerState; %hányadik réteg, hányadik kimenet
    % minden réteg kimenetét beállítom a kezdeti értékre
end

for i=1:n
    x{1}=u(i,:)';                    %az adottt layer elorecstolt bemenete
   
   
    for j=2:NL+1     
        x{j}=[1;y{j-1}];
    end
   
    for j=1:NL
        
        s1{j}=w1{j}*x{1};   % s{j} oszlop

        s2{j}=zeros(NNL(j),1);
        
        for k=1:NL
            s2{j}=s2{j}+ w2{j,k}*x{k+1}(2:length(x{k+1}),:);
        end    
        
        s{j}=s2{j}+s1{j};

    end
    
    for j=1:NL
        y{:,j}=ActFunc(s{:,j},a);
        
    end
    
    Out(:,i)=y{:,end};
end
Out=Out';  %oszloponként egy kimenet értéke ciklusonként
end

