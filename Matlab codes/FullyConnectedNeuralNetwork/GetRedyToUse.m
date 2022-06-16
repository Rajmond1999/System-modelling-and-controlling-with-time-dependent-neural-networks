function [u,y,umin,umax,ymin,ymax]=GetRedyToUse(u,y)

umax=max(u);
ymax=max(y);
umin=min(u);
ymin=min(y);

%u=((u-umin)./(umax-umin)-0.5);

y=((y-ymin)./(ymax-ymin))*0.8 + 0.1;
%u=[ones(size(u(:,1))),u];

end