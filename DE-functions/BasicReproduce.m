function offpop = BasicReproduce(Fx, x, NP, lu, n)
% CR: the crossover control parameter of DE
offpop = zeros(NP, n);
for i = 1 : NP    
    F=rand;
    % Mutation
    [r1, r2, r3, r4, r5]=selection(i,NP);
%     if rand>0.3
            v=x(r1,:)+F.*(x(r2,:)-x(r3,:));
%     else
        
%        v=x(r1,:)+F.*(x(r2,:)-x(r3,:))+F.*(x(r4,:)-x(r5,:)); 
%     end
    % Handle the elements of the mutant vector which violate the boundary
    vioLow = find(v < lu(1, : ));
    if ~isempty(vioLow)
        v(1, vioLow) = 2 .* lu(1, vioLow) - v(1, vioLow);
        vioLowUpper = find(v(1, vioLow) > lu(2, vioLow));
        if ~isempty(vioLowUpper)
            v(1, vioLow(vioLowUpper)) = lu(2, vioLow(vioLowUpper));
        end
    end
    
    vioUpper = find(v > lu(2, : ));
    if ~isempty(vioUpper)
        v(1, vioUpper) = 2 .* lu(2, vioUpper) - v(1, vioUpper);
        vioUpperLow = find(v(1, vioUpper) < lu(1, vioUpper));
        if ~isempty(vioUpperLow)
            v(1, vioUpper(vioUpperLow)) = lu(1, vioUpper(vioUpperLow));
        end
    end

    % Implement the binomial crossover
    CR = 0.7 + (1-0.7).*rand;
    jRand = floor(rand * n) + 1;
    t = rand(1, n)<CR;
    t(1, jRand) = 1;
    t_ = 1 - t;
    u = t .* v + t_ .* x(i, : );    
    % Update the offspring population
    offpop( i , : ) = u;    
end
