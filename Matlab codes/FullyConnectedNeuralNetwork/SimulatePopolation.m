function E=SimulatePopolation(P,PopulationSize,Input,DesiredOutput,ActFunc,a)

NO=P{1}{1}(2);
for i=1:PopulationSize
    y=SimSBNN(P{i},Input,ActFunc,a);
    
    e=y-DesiredOutput;  %sorvektor
    E(i)=0;
    for j=1:NO
        E(i)=E(i)+e(:,j)'*e(:,j);
    end
    
end
end