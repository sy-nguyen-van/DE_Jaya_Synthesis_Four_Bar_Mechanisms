function [xval,fval,FES,PIC,Alarm]=HCDJ(n,Objf,Consf,Lb,Ub,Options,mpercent,kpercent,sigma,FF,CASE)
Popsize= Options.Popsize;
tol= Options.tol;
Totalgen= Options.Totalgen;
alpha=Options.alpha;
eta=Options.eta;
G_XP=Options.G_XP;
% The population size
NP   = Popsize;
FES  = 0;
maxFES=NP*Totalgen;
lu = [Lb;Ub];
% Initialize the main population

for i=1:NP
    x(i,:) = lu(1, :)+rand(1,n).* ((lu(2, :)-lu(1, :)));
    summaxmin=max(x(i,1:4))+min(x(i,1:4));
    Other=sum(x(i,1:4)) - summaxmin;
    while summaxmin- Other >0 %& x(i,2)~=min(x(i,1:4))
        x(i,:) = lu(1, :)+rand(1,n).*((lu(2, :)-lu(1, :)));
        summaxmin=max(x(i,1:4))+min(x(i,1:4));
        Other=sum(x(i,1:4))-summaxmin;
    end
    switch CASE
        case 'Case1'
            Cdx=ones(1,6);
            index=INDEX(x(i,:),Cdx);
            x1=x(i,:);
            [~,index1]=sort(x1(10:end));;
            index1=index1+9;
            x1(index)=x(i,index1);
                x(i,:)=x1;
        case 'Case5'
            Cdx=ones(1,10);
            index=INDEX(x(i,:),Cdx);            
            x1=x(i,:);
            [~,index1]=sort(x1(10:end));;
            index1=index1+9;
            x1(index)=x(i,index1);
                x(i,:)=x1;
    end
end

% Evaluate the objective function
[fit,g]=EvalPenalty(x, Objf, Consf, alpha);
[~,id]  = sort(fit);
xp      = x(id(1:Popsize),:);
fit_xp  = fit(id(1:Popsize));
g_xp    = g(id(1:Popsize));
gen = 1;
del =1e6;
while FES < maxFES
    % Generate the offspring population
    offpop=HCDJ_Reproduce(fit_xp, xp, NP, lu, n,mpercent,kpercent,sigma,FF);
    % Evaluate "offpop" by slightly revising the current program
    [fit_off,g_off] = EvalPenalty(offpop, Objf, Consf, alpha);
    % Update x, g,f using elistist selection
    x       = [xp; offpop];
    fit     = [fit_xp; fit_off];
    g       = [g_xp; g_off];
    [~,id]  = sort(fit);
    xp      = x(id(1:Popsize),:);
    fit_xp  = fit(id(1:Popsize));
    g_xp    = g(id(1:Popsize));
    FES = FES + NP;
    [fbest,idb] = min(fit_xp);
    if gen >= Totalgen
        if g_xp(idb)<=G_XP
            [fbest,idb] = min(fit_xp);
            fval=fbest; xval=xp(idb,:);
            disp('_____________________________________________________')
            fprintf('Optimal solution of HCDJ is found at generation: %i, Number of FEMs: %i,fval = %s, xval = %s \n',gen,FES,mat2str(fval),mat2str(xval));
            PIC(gen,1)=FES;
            PIC(gen,2)=fbest;
            gen = gen+1;
            Alarm=0;
        else
            g_xp(idb)
            disp('The optimal solution is not found')
            fval = []; xval = [];
            Alarm=1;
        end
    end
    PIC(gen,1)=FES;
    PIC(gen,2)=fbest;
    gen = gen+1;
end
fval=fbest; xval=xp(idb,:);
end