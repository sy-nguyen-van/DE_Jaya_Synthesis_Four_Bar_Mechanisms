function offpop = JayaReproduce(Fx, x, NP, lu, n)
% CR: the crossover control parameter of DE
[bestFx,idx]=min(Fx); bestOrganism=x(idx,:);
[WFx,idw]=max(Fx); WOrganism=x(idw,:);
offpop = zeros(NP, n);
for i = 1 : NP
    F = rand;
    [r1, r2, r3, r4, r5]=selection(i,NP);
    v=x(r1,:)+rand()*(bestOrganism-abs(x(r2,:)))-rand()*(WOrganism-abs(x(r3,:)));
    v=check_bound(v,lu);
    offpop( i , : ) = v;
end
