function [Net,Er]=BuildAndTeach(Input,DesiredOutput,PopulationSize,MaxIter,NAN,ActFunctions,a,BS,...
    ChanceOfMutation,ChanceOfBigMutation,...
    ChanceOfSingleWeightMutationIfNotBig,...
    MagnitudeOfWeightMutation,...
    CanceOfAnActFuncMutation,CanceOfInvertingTheActFunc,...
    ChanceOfANewNeuron,ChanceOfLosingANeuron)

c=0;

if rem(PopulationSize, 2)==0
    PopulationSize=PopulationSize+1;
end
[q,NI]=size(Input);
[q,NO]=size(DesiredOutput);
[q,NAF]=size(ActFunctions);


P=GeneratePopulation(PopulationSize,NI,NO,BS,NAF,NAN);

K=ceil(PopulationSize/2);

figure(1);
grid on;
for i=1:MaxIter
    E=SimulatePopolation(P,PopulationSize,Input,DesiredOutput,ActFunctions,a);
    min(E)

    

    [Er(i),I]=min(E);
    sizee(i)=P{I}{1}(3);
    subplot(211);
    plot(Er);
    subplot(212)
    plot(sizee);
    pause(0.001);

    
    if Er(i)<0.5
        break
    end
    if i>10
        if Er(i)==Er(i-10)
            if c>40
                PNew=GeneratePopulation(PopulationSize,NI,NO,BS,NAF,sizee(i)+1);%%% nagyobb hálókat hozok létre mint amekkora volt
                for k=2:PopulationSize
                    P{k}=PNew{k};
                end
                'New population'
                c=0;
            end
        end
    end
    for j=1:K
        [best,o]=max(E);
        for h=1:PopulationSize
            if E(h)<E(o)
                o=h;
            end
        end
        
        Pb{j}=P{o}; %% itt vannak a legjobbak
        E(o)=best;
    end
    P=Repopulate(Pb,PopulationSize,NAF,BS,ChanceOfMutation,ChanceOfBigMutation,...
        ChanceOfSingleWeightMutationIfNotBig,...
        MagnitudeOfWeightMutation,...
        CanceOfAnActFuncMutation,CanceOfInvertingTheActFunc,...
        ChanceOfANewNeuron,ChanceOfLosingANeuron);
    c=c+1;
end

E=SimulatePopolation(P,PopulationSize,Input,DesiredOutput,ActFunctions,a);
min(E)

[Er(end+1),I]=min(E);
Net=P{I};

subplot(211)
sizee(i)=P{I}{1}(3);
plot(Er);
subplot(212)
plot(sizee);
pause(0.001);

end