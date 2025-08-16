function [nvars,Objf,Const,LB,UB,CASE]=Mechanisms(CASE)
switch CASE
    %=============Size=======================================
    %optimizaton=============================================
    case 'Case1'
        nvars = 15;                      % Number of variables
        L1=0*ones(1,4);
        H1=60*ones(1,4);
        % For position of C on links 2
        L2=-60*ones(1,4);
        H2=60*ones(1,4);
        % For angular position of link 2
        L3=0*ones(1,7);
        H3=2*pi*ones(1,7);
        % Final
        LB=[L1 L2 L3];
        UB=[H1 H2 H3];
        Objf  = @Objf1;             % Objective function
        Const = @Cons1;            % Constraint function
    case 'Case2'
        nvars = 6;                     % Number of variables
        L1=0*ones(1,4);
        H1=50*ones(1,4);
        L2=-50*ones(1,2);
        H2=50*ones(1,2);
        % For positions of link 1
        % Final
        LB=[L1 L2];
        UB=[H1 H2];
        Objf  = @Objf2;
        Const = @Cons2;
    case 'Case3'
        nvars = 10;       % Number of variables
        L1=0*ones(1,4);
        H1=50*ones(1,4);
        % For position of C on links 2
        L2=-50*ones(1,4);
        H2=50*ones(1,4);
        % For positions of link 1
        L3=0*ones(1,2);
        H3=2*pi*ones(1,2);
        % Final
        LB=[L1 L2 L3];
        UB=[H1 H2 H3];
        Objf  = @Objf3; % Objective function
        Const = @Cons3; % Constraint function
    case 'Case4'
        nvars = 9;       % Number of variables
        L1=0*ones(1,4);
        H1=50*ones(1,4);
        % For position of C on links 2
        L2=-50*ones(1,4);
        H2=50*ones(1,4);
        % For positions of link 1
        L3=0;
        H3=2*pi;
        % Final
        LB=[L1 L2 L3];
        UB=[H1 H2 H3];
        Objf  = @Objf4; % Objective function
        Const = @Cons4; % Constraint function
    case 'Case5'
        nvars = 19;                     % Number of variables
        L1=0*ones(1,4);
        H1=80*ones(1,4);
        % For position of C on links 2
        L2=-80*ones(1,4);
        H2=80*ones(1,4);
        % For angular position of link 2
        L3=0*ones(1,11);
        H3=2*pi*ones(1,11);
        % Final
        LB=[L1 L2 L3];
        UB=[H1 H2 H3];
        Objf  = @Objf5;             % Objective function
        Const = @Cons5;            % Constraint function        
end