function Net=CreateChildren(Net1,Net2,NAF,BS,...
        ChanceOfMutation,ChanceOfBigMutation,...
        ChanceOfSingleWeightMutationIfNotBig,...
        MagnitudeOfWeightMutation,...
        CanceOfAnActFuncMutation,CanceOfInvertingTheActFunc,...
        ChanceOfANewNeuron,ChanceOfLosingANeuron)
    
% Creation:    

    NN1=Net1{1}(3);
    NN2=Net2{1}(3);
    
    
    NI=Net1{1}(1);
    NO=Net1{1}(2);
    
    Data(1)=NI;  %Number of Inputs
    Data(2)=NO;  %Number of Outputs


    Neurons1=Net1{2};
    Neurons2=Net2{2};

    if NN1==NN2
        for i=1:NN1
            if(rand>0.5)
                Neurons{i,1}=Neurons1{i,1};
                Neurons{i,2}=Neurons1{i,2};
                Neurons{i,3}=Neurons1{i,3};
                Neurons{i,4}=Neurons1{i,4};
            else
                Neurons{i,1}=Neurons2{i,1};
                Neurons{i,2}=Neurons2{i,2};
                Neurons{i,3}=Neurons2{i,3};
                Neurons{i,4}=Neurons2{i,4};
            end
        end
    else
        if(NN1>NN2 )
            for i=1:NN2
                if(rand>0.5)
                    Neurons{i,1}=Neurons1{i,1};
                    Neurons{i,2}=Neurons1{i,2};                
                    Neurons{i,3}=Neurons1{i,3};
                    Neurons{i,4}=Neurons1{i,4};
                else
                    Neurons{i,1}=Neurons2{i,1};
                    Neurons{i,2}=Neurons2{i,2};            
                    Neurons{i,3}=Neurons2{i,3};
                    Neurons{i,4}=Neurons2{i,4};
                end
            end
            j=NN2+1;
            for i=NN2+1:NN1
                if(rand>0.5)
                    Neurons{j,1}=Neurons1{i,1};
                    Neurons{j,2}=Neurons1{i,2};
                    Neurons{j,3}=Neurons1{i,3};
                    Neurons{j,4}=Neurons1{i,4};
                    ++j;
                end
            end
        else

            for i=1:NN1
                if(rand>0.5)
                    Neurons{i,1}=Neurons1{i,1};
                    Neurons{i,2}=Neurons1{i,2};
                    Neurons{i,3}=Neurons1{i,3};
                    Neurons{i,4}=Neurons1{i,4};
                else
                    Neurons{i,1}=Neurons2{i,1};
                    Neurons{i,2}=Neurons2{i,2};
                    Neurons{i,3}=Neurons2{i,3};
                    Neurons{i,4}=Neurons2{i,4};
                end
            end
            j=NN1+1;
            for i=NN1+1:NN2
                if(rand>0.5)
                    Neurons{j,1}=Neurons2{i,1};
                    Neurons{j,2}=Neurons2{i,2};
                    Neurons{j,3}=Neurons2{i,3};
                    Neurons{j,4}=Neurons2{i,4};
                    ++j;
                end
            end
        end
        
        
    end
    
% Mutation:
    [n,m]=size(Neurons);
    
    if(NN1~=NN2)
        for i=1:n
            n1=length(Neurons{i,2});
            if(n1<n+NI+1)
                Neurons{i,2}=[Neurons{i,2},rand(1,n+NI+1-n1)];
            end
            if(n1>n+NI+1)
                Neurons{i,2}(n+NI+2:end)=[];
            end
        end
    end
    
    [n,m]=size(Neurons);
    
    if(rand<ChanceOfMutation)
        for i=1:n
            % Weight mutations:
            if(rand<ChanceOfBigMutation)
                Neurons{i,2}=Neurons{i,2}+(rand(1,NI+n+1)-0.5)*2*MagnitudeOfWeightMutation;
            else
                if(rand<ChanceOfSingleWeightMutationIfNotBig)
                    r=(floor(rand*0.999*n)+1);
                    Neurons{i,2}(r)=Neurons{i,2}(r)+((rand-0.5)*2)*...
                        MagnitudeOfWeightMutation;
                end
            end
            % ActFunc mutations:
            if(rand<CanceOfInvertingTheActFunc)
                %Neurons{i,4}=Neurons{i,4}*-1;
             
            end
            
            if(rand<CanceOfAnActFuncMutation)
                %Neurons{i,3}=floor(rand*NAF*0.999)+1;
            end
            
        end
        
        %Neuron mutation
        if(rand<ChanceOfANewNeuron)
            
            for i=1:n
                Neurons{i,2}(end+1)=(rand-0.5)*2;
            end
            
            n=n+1;
            
            Neurons{n,1}=BS;
            Neurons{n,2}=(rand(1,NI+n+1)-0.5)*2;%The weights 
            Neurons{n,3}=floor(rand*NAF*0.999)+1;   %The type of the activation function
            if(rand>0.5)
                Neurons{n,4}=1;    %Sign of the act function
            else
                Neurons{n,4}=1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -1 kellene
            end
               
        end
        
        if(rand<ChanceOfLosingANeuron && n>NO)

            looser=floor(rand*(n)*0.999+1);
            j=1;
            for i=1:n
                if i~=looser
                    Neurons3{j,1}=Neurons{i,1};
                    Neurons3{j,2}=Neurons{i,2};
                    Neurons3{j,3}=Neurons{i,3};
                    Neurons3{j,4}=Neurons{i,4};
                    ++j;
                end
            end  
           
            n=n-1;
            
            for i=1:n
                Neurons{i,2}(looser)=[];
            end
               
        end
    
    end
    
    Data(3)=n;
    Net{1}=Data;
    Net{2}=Neurons;

end