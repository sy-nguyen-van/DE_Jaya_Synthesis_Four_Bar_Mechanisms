function [xval,fval,FES,PIC,STD]=mDE(n,Objf,Consf,Lb,Ub,Options)
Popsize= Options.Popsize;
tol= Options.tol;
Totalgen= Options.Totalgen;
alpha=Options.alpha(1);
alphamax=Options.alpha(2);
eta=Options.eta;
G_XP=Options.G_XP;
% The population size
NP   = Popsize;
FES  = 0;
maxFES=NP*Totalgen;
lu = [Lb;Ub];
% Initialize the main population
for i=1:NP
    xp(i,:) = lu(1, :) + rand(1, n) .* ((lu(2, :) - lu(1, :)));
%     while min(xp(i,:))+max(xp(i,:))>sum(xp(i,:));
%         xp(i,:) = lu(1, :) + rand(1, n) .* ((lu(2, :) - lu(1, :)));
%     end
end
% Evaluate the objective function
[fit_xp,g_xp]=EvalPenalty(xp, Objf, Consf, alpha);
gen = 1;
del =1e6;
xgood=xp;
while FES < maxFES
        alpha = alpha + alphamax/Totalgen;
    if alpha>alphamax
       alpha=alphamax;        
    end
    % Generate the offspring population
    offpop = ModifiedReproduce(fit_xp, xp, NP, lu, n,del,eta,xgood);
    % Evaluate "offpop" by slightly revising the current program
    [fit_off,g_off] = EvalPenalty(offpop, Objf, Consf, alpha);
    % Update x, g,f using elistist operator
    x       = [xp; offpop];
    fit     = [fit_xp; fit_off];
    g       = [g_xp; g_off];
    [~,id]  = sort(fit);
    xp      = x(id(1:Popsize),:);
    fit_xp  = fit(id(1:Popsize));
    g_xp    = g(id(1:Popsize));
    FES = FES + NP;
    [fbest,idb] = min(fit_xp);
    %     min(g_xp);
    %     del = abs(abs(fbest)/abs(mean(fit_xp))-1);
    del=abs(1-exp(std(fit_xp)));
    % check stopping condition;
    if FES < maxFES
        if abs(del) <= tol && min(g_xp)<=G_XP
            fval=fbest; xval=xp(idb,:);
            break
        end
    else
        if min(g_xp)<=G_XP
            [fbest,idb] = min(fit_xp);
            fval=fbest; xval=xp(idb,:);
        else
            disp('The optimal solution is not found')
            fval = []; xval = [];
        end
    end
    % Update the number of FES
    PIC(gen,1)=FES;
    PIC(gen,2)=fbest;
    abs(del);
    STD(gen)=del;
    gen = gen + 1;
end



