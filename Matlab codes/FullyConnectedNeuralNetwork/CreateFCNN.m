function [w]=CreateFCNN(NI,NO,NL,NNL)
    for i=1:NL
        
        w1{i}=(rand(NNL(i),NI+1)-0.5); % Az inputr=l a s]lyz=k minden rétegbe
 
       for j=1:NL
            w2{i,j}=(rand(NNL(i),NNL(j))-0.5);   % Forward + Backward
            % melyik rétegbe,melyik rétegből, melyik neuronba melyik neuronból 
       end
    end
    w={w1,w2};
end
