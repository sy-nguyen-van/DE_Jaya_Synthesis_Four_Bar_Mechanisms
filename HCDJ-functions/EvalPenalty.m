function [fit Vo] = EvalPenalty(Pop, Obj, Cons, alpha)
Popsize = size(Pop, 1);
for i = 1:Popsize
    % fitness
    f1(i,1) = feval(Obj,(Pop(i,:)));
    % constraint
    Vo(i,1) = feval(Cons,(Pop(i,:)));
end
% Obtain the fitness
fit = f1+alpha*Vo;
end