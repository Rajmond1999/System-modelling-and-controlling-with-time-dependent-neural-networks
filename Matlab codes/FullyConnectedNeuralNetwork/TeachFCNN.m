function  [wt,Err]=TeachFCNN(Input,d,w,NI,NO,NL,NNL,ActFunc,DActFunc,a,u,MaxIter,R,BiginnerState)

w1 = w{1};
w2 = w{2};
Input=[ones(size(Input(:,1))),Input];
[n,m]=size(Input);
for o=1:MaxIter
    
    
    Err(o)=0;
    %% Kimenet és hibaszámítás
    
    for i=1:NL
        y{i}=zeros(NNL(i),1)+BiginnerState; %hányadik layer, hányadik kimenet
    end
    
    for i=1:n
        x{1,i}=Input(i,:)';
        for j=2:NL+1
            x{j,i}=[1;y{j-1}];
        end
        for j=1:NL
            s1{j}=w1{j}*x{1,i};   % s{j} oszlop
            s2{j}=zeros(NNL(j),1);
            
            for k=1:NL
                s2{j}=s2{j}+ w2{j,k}*x{k+1,i}(2:length(x{k+1,i}),:);
            end
            s{j}=s2{j}+s1{j};
        end
        for j=1:NL
            y{:,j}=ActFunc(s{:,j},a);
            S{i,j}=s{:,j};
        end
       
        Out(:,i)=y{:,end};
        E{i,NL}=d(i,:)'-Out(:,i);  %minden oszlopvektor
        
        Err(o)=Err(o)+sum((E{i,NL}.^2));
        %% Tanítás
        if i>R%mod(i,R*NL)==0 %számoltam e már ennyi kimenetet, ahányszor ki szeretném teríteni
            for j=0:R-1    %kiterítéseken megyek végig
                ErrorBack{i-j,NL}=E{i-j,NL};
                if j>0
                    ErrorBack2{i-j,NL}=w2{NL,NL}'*(ErrorBack{i-j+1,NL}.* DActFunc(S{i-j+1,NL},a));
                    for k=NL-1:-1:1
                        ErrorBack2{i-j,NL}=w2{k,NL}'*(ErrorBack{i-j+1,k}.* DActFunc(S{i-j+1,k},a))+ErrorBack2{i-j,NL};
                    end
                    ErrorBack{i-j,NL}=ErrorBack{i-j,NL}+ErrorBack2{i-j,NL};
                end
                
                for k=NL:-1:1
                    w1{k}=w1{k}+u(1)*(x{1,i-j}*(DActFunc(S{i-j,k},a).*ErrorBack{i-j,k})')';
                    for g=NL:-1:1
                        w2{k,g}=w2{k,g}+u(2)*(x{g+1,i-j}(2:length(x{g+1,i-j}(:,1)'),:)*(DActFunc(S{i-j,k},a).*ErrorBack{i-j,k})')';
                    end
                    if k>1
                        ErrorBack{i-j,k-1}=w1{k}(:,2:length(w1{k}(1,:)))'*(ErrorBack{i-j,k}.*DActFunc(S{i-j,k},a));
                        ErrorBack2{i-j,k-1}=zeros(NNL(k-1),1);
                        if j>0
                            for g=1:NL
                                ErrorBack2{i-j,k-1}=w2{g,k-1}'*(ErrorBack{i-j+1,g}.* DActFunc(S{i-j+1,g},a))+ ErrorBack2{i-j,k-1};
                            end
                        end
                        ErrorBack{i-j,k-1}=ErrorBack2{i-j,k-1};
                    end
                end
            end
            
        end  %
    end
    if mod(Out,100)==0
    plot(Out);
    end
end
wt{1}=w1;
wt{2}=w2;


% figure(5)
% plot(ran)
% hold on;
% plot(Err)
% grid on;
% legend('Ritktási együttható','Hiba')
% figure(6)
% dErr=Err(3:end)-Err(2:end-1);
% plot(ran(2:end-1),dErr,'*b')
% hold on;
% plot(NL.*ones(size((min(dErr):max(dErr)))),(min(dErr):max(dErr)),'r')
% title('Hiba változás=f(Ritkítási együttható)')
% grid on;
% 
% figure(7)
% p=ones(1,max(ran));
% 
% for i=1:length(dErr)
%     rz{ran(i+1)}(p(ran(i+1)))=dErr(i);
%     p(ran(i+1))=p(ran(i+1))+1;
% end
% 
% for j=1:max(ran)
%     avg(j)=mean(rz{j}');
% end
% figure(7)
% plot(avg)
% hold on;
% plot(avg,'*r')
% grid on
end