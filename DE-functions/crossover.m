function u=crossover(v,x,i,n)
cr=0.9;
CR = cr + (1-cr).*rand;
jRand = floor(rand * n) + 1;
t = rand(1, n)<CR;
t(1, jRand) = 1;
t_ = 1 - t;
u = t .* v + t_ .* x(i, : );
end