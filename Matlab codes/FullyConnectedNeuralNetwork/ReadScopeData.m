function InputData=ReadScopeData(ScopeData)

t=ScopeData.time;
y(:,1)=ScopeData.signals(1).values;
u(:,1)=ScopeData.signals(2).values;
InputData=[u,y,t]; %oszlopvektorok
end