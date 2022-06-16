function P = GeneratePopulation(PopulationSize,NI,NO,BS,NAF,NAN)
for i=1:PopulationSize
        P{i}=CreateSBNN(NI,NO,BS,NAF,NAN);
        
end
end