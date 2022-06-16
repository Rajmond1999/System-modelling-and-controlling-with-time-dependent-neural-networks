function Net = CreateSBNN(NI,NO,BS,NAF,NAN)

Data(1)=NI;  %Number of Inputs
Data(2)=NO;  %Number of Outputs
Data(3)=NO+NAN;  %Number of Neurons

for i=1:NO+NAN
    Out=BS;         %Output of the neuron is beginner state as default
    w=(rand(1,NI+NO+NAN+1)-0.5);%*2;  %The weights 
    Neurons{i,1}=Out;
    Neurons{i,2}=w;
    Neurons{i,3}=floor(rand*NAF*0.999)+1;   %The type of the activation function
    if(rand>0.5)
        Neurons{i,4}=1;    %Sign of the act function
    else
        Neurons{i,4}=1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -1 kellene
    end
end

Net{1}=Data;
Net{2}=Neurons;
end