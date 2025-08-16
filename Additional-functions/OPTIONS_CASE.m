function Options=OPTIONS_CASE(CASE)
Options.alpha = 1e3;
Options.eta = 1e-100;
Options.tol = 1e-100;  % Tolerance of stopping condition;
Options.G_XP = 1e-6;
switch CASE
    case 'Case1'
        Options.Popsize  = 100;  % Population size
        Options.Totalgen = 1000; % Maximum iteration
        Options.alpha = 1e6;
    case 'Case2'
        Options.Popsize  = 50;   % Population size
        Options.Totalgen = 100;  % Maximum iteration
        
    case 'Case3'
        Options.Popsize  = 50;   % Population size
        Options.Totalgen = 100;  % Maximum iteration
    case 'Case4'
        Options.Popsize  = 50;  % Population size
        Options.Totalgen = 1000; % Maximum iteration
        Options.alpha = 1e4;
        
    case 'Case5'
        Options.Popsize  = 100;  % Population size
        Options.Totalgen = 1000; % Maximum iteration
        Options.alpha = 1e6;
end
end