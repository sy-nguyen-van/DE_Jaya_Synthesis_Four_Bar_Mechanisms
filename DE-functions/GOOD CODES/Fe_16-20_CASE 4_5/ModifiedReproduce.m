function offpop = ModifiedReproduce(Fx, x, NP, lu, n,del,eta,xgood)
offpop = zeros(NP, n);
[~,idx]=min(Fx);
bestOrganism=x(idx,:);
for i = 1:NP
    F=rand();
    %========Check delta==============
    if abs(del) > eta
        %=============While 1e-4<delta<1e-3==>>perform SOS and DE=====
        [r1, r2, r3, r4, r5]=selection(i,NP);
        if F>0.3
            v=x(r1,:)+F.*(x(r2,:)-x(r3,:))+F.*(x(r4,:)-x(r5,:));
            v=check_bound(v,lu);
            u=crossover(v,x,i,n);
        else
            %============SOS=========================
            [r1,r2,r3,r4,r5]=selection(i,NP);
            %==========Mutant========================
            mutualVector=mean([x(i,:);x(r1,:)]);
            %             F=(rand(1,n));
            BF2=1;
            offpopNew2=x(r1,:)+F.*(x(r2,:)-BF2.*mutualVector)+F.*(x(r3,:)-x(r4,:));
            u=check_bound(offpopNew2,lu);
            u=crossover(u,x,i,n);
        end
    else
        %============DE best/1=============================================
        [r1 r2 r3 r4 r5]=selection(i,NP);
        if F>0.3
            v=bestOrganism+F.*(x(r1,:)-x(r2,:));
        else
            v=bestOrganism+F.*(x(r1,:)-x(r2,:))+F.*(x(r3,:)-x(r4,:));
        end
        v=check_bound(v,lu);
        u=crossover(v,x,i,n);
    end
    offpop(i,:)=u;
end
end


