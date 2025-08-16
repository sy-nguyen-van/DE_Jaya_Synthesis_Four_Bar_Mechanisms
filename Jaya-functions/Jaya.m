function [xval,fval,FES,PIC,STD,Alarm]=Jaya(n,Objf,Consf,Lb,Ub,Options)
Popsize     = Options.Popsize;
tol         = Options.tol;
Totalgen    = Options.Totalgen;
alpha=Options.alpha;
G_XP=Options.G_XP;
% The population size
NP   = Popsize;
FES  = 0;
lu = [Lb;Ub];
% Initialize the main population
xp = ones(NP, 1) * lu(1, :) + rand(NP, n) .* (ones(NP, 1) * (lu(2, :) - lu(1, :)));
% Evaluate the objective function
[fit_xp,g_xp] = EvalPenalty(xp, Objf, Consf, alpha);
gen = 1; del =1e6;
while gen <= Totalgen
    % write to command window
    % Update eps2
    %     eps2 = eps2 + eps2max/Totalgen;
    % Generate the offspring population
    offpop = JayaReproduce(fit_xp, xp, NP, lu, n);
    % Evaluate "offpop" by slightly revising the current program
    [fit_off,g_off] = EvalPenalty(offpop, Objf, Consf, alpha);
    % Update x, g, f
    for j = 1:Popsize
        if fit_off(j) < fit_xp(j) %&& g_off(j) <= 1e-6
            fit_xp(j) = fit_off(j);
            xp(j,:)   = offpop(j,:);
            g_xp(j)   = g_off(j);
        end
    end
    FES = FES + NP;
    [fbest,idb] = min(fit_xp);
    if gen >= Totalgen
        if g_xp(idb)<=G_XP
            [fbest,idb] = min(fit_xp);
            fval=fbest; xval=xp(idb,:);
            disp('_____________________________________________________')
            fprintf('Optimal solution of JAYA is found at generation: %i, Number of FEMs: %i,fval = %s, xval = %s \n',gen,FES,mat2str(fval),mat2str(xval));
            PIC(gen,1)=FES;
            PIC(gen,2)=fbest;
            gen = gen+1;
            Alarm=0;
        else
            disp('The optimal solution is not found')
            fval = []; xval = [];
            Alarm=1;
        end
    end
    PIC(gen,1)=FES;
    PIC(gen,2)=fbest;
    abs(del);
    STD(gen)=del;
    gen = gen+1;
end
fval=fbest; xval=xp(idb,:);
% Evaluate the objective function using the penalty method

