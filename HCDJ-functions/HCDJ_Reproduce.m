function offpop = HCDJ_Reproduce(Fx, x, NP, lu, n,mpercent,kpercent,Sigma,F)
offpop = zeros(NP, n);
[~,idx]=min(Fx);
bestOrganism=x(idx,:);
[~,imax]=max(Fx);
WorstOrganism=x(imax,:);
if F==0.8
    F=0.7+rand*0.3;
end
if Sigma==0.8
    Sigma=0.7+rand*0.3;
end
for i = 1:NP
    m=mpercent;
    k=kpercent;
    %========Check delta==============
    %=============While 1e-4<delta<1e-3==>>perform SOS and DE=====
    [r1, r2, r3, r4, r5]=selection(i,NP);
    if i<=round(m*NP)
        if rand>Sigma
            v=bestOrganism+F.*(x(r1,:)-x(r2,:));
        else
            v=bestOrganism+F.*(x(r1,:)-x(r2,:))+F.*(x(r3,:)-x(r4,:));
        end
    elseif round(m*NP)<i<=round((m+k)*NP)
        if rand>Sigma
            v=x(r1,:)+F.*(bestOrganism-x(r1,:))+F.*(x(r2,:)-x(r3,:));            
        else
            v=x(r1,:)+F.*(bestOrganism-abs(x(r2,:)))-F.*(x(r3,:)-abs(WorstOrganism)); % Jaya            
        end
    else
        if rand>Sigma
            v=x(r1,:)+F.*(x(r2,:)-x(r3,:));
        else
            v=x(r1,:)+F.*(x(r2,:)-x(r3,:))+F.*(x(r4,:)-x(r5,:));
        end
    end
    v=check_bound(v,lu);
    u=crossover(v,x,i,n);
    offpop(i,:)=u;
end
end


