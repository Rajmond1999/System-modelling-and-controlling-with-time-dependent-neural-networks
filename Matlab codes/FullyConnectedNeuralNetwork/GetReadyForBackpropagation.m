function [w,NL,NNL]=GetReadyForBackpropagation(Net)
Data=Net{1};
NI=Data(1);  %Number of Inputs
NO=Data(2);  %Number of Outputs
NN=Data(3);  %Number of Neurons

Neurons=Net{2};

if(NN>NO)
    NL=2;
    NNL=[NN-NO NO];
   
   
    
    for j=1:NN-NO
        for k=1:NI+1
            w1{1}(j,k)=Neurons{j+NNL(2),2}(k);
        end
    end
     
    % melyik rétegbe,melyik rétegből, melyik neuronba melyik neuronból

    for j=1:NN-NO
        for k=1:NN-NO
            w2{1,1}(j,k)=Neurons{j+NNL(2),2}(NNL(2)+NI+1+k);
        end
    end
    
    for j=1:NN-NO
        for k=1:NO
            w2{1,2}(j,k)=Neurons{j+NNL(2),2}(NI+1+k);
        end
    end
    
    % 2. réteg
    
    for j=1:NO
        for k=1:NI+1
            w1{2}(j,k)=Neurons{j,2}(k);     %csatolás az inputról a 2. rétegbe
        end

    end
    
    for j=1:NO
        for k=1:NO
            w2{2,2}(j,k)=Neurons{j,2}(NI+1+k);
        end
    end
    
    for j=1:NO
        for k=1:NN-NO
            w2{2,1}(j,k)=Neurons{j,2}(NI+NNL(2)+k+1);
        end
    end
else
    % csak 1 réteg van
    NL=1;
    NNL=NO;
    
    for j=1:NO
        for k=1:NI+1
            w1{1}(j,k)=Neurons{j,2}(k);
        end
    end
    
    for j=1:NO
        for k=1:NO
            w2{1,1}(j,k)=Neurons{j,2}(NI+k+1);
        end
    end
end
w={w1,w2};


end
