function Out=SimSBNN(Net,u,ActFunc,a)

u=[ones(size(u(:,1))),u];

[n,m]=size(u);

NN=Net{1}(3);   %number of neurons
NO=Net{1}(2);
Neurons=Net{2};


for i=1:n
    x(1,1:m)=u(i,1:m);
    for j=1:NN
        x(1,m+j)=Neurons{j,1};
    end
%     i
%          NN
%          size(Net{2})
%           size(x)
%           Neurons
    for j=1:NN
%          NN
%          size(x)
%          Neurons
        Neurons{j,1}=Neurons{j,4}.*ActFunc{Neurons{j,3}}((x*(Neurons{j,2}')),a{Neurons{j,3}});
    end
    for j=1:NO
        Out(i,j)=Neurons{j,1};
    end
end
end