function a = CellToArray(w,NL,NNL)
w1=w{1};
w2=w{2};
a=[];
for i=1:NL
    a=[a;w1{i}(:)];
end


for i=1:NL
    for j=1:NL
        a=[a;w2{i,j}(:)];
    end
end


end