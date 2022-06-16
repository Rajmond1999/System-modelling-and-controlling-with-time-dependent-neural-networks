function w = ArrayToCell(a,NL,NNL,NI)


for i=1:NL
    w1{i}=reshape(a(1:NNL(i)*(NI+1)),NNL(i),NI+1);
    a=a(NNL(i)*(NI+1)+1:end);
    
    
end

for i=1:NL
    for j=1:NL
        w2{i,j}=reshape(a(1:NNL(i)*NNL(j)),NNL(i),NNL(j));
        a=a(NNL(i)*NNL(j)+1:end);
    end
end

w={w1,w2};

end