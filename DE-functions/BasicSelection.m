function [r] = BasicSelection(NP, j, Fx, Mutation)
switch Mutation
    case 'rand/1'
        r1 = j; % randomly select r1
        while r1==j
            r1 = randi(NP,1,1); end
        r2 = j; % randomly select r2
        while r2==r1 || r2==j
            r2 = randi(NP,1,1); end
        r3 = j; % randomly select r3
        while r3 == j || r3 == r1 || r3 == r2
            r3 = randi(NP,1,1); end
        r = [r1,r2,r3];
    case 'rand/2'
        r1 = j; % randomly select r1
        while r1==j
            r1 = randi(NP,1,1); end
        r2 = j; % randomly select r2
        while r2==r1 || r2==j
            r2 = randi(NP,1,1); end
        r3 = j; % randomly select r3
        while r3 == j || r3 == r1 || r3 == r2
            r3 = randi(NP,1,1); end
        r4 = j; % randomly select r2
        while r4==r3 || r4==r2 || r4==r1 || r4==j
            r4 = randi(NP,1,1); end
        r5 = j; % randomly select r3
        while r5==r4 || r5==r3 || r5==r2 || r5==r1 || r5==j
            r5 = randi(NP,1,1); end
        r = [r1,r2,r3,r4,r5];
    case 'best/1'
        % Select rbest
        [~,rb] = min(Fx); rb = rb(1);
        r1 = j; % randomly select r1
        while r1==j || r1==rb
            r1 = randi(NP,1,1); end
        r2=j; % randomly select r2
        while r2==r1 || r2==j || r2==rb
            r2 = randi(NP,1,1); end
        r = [rb,r1,r2];
    case 'best/2'
        % Select rbest
        [~,rb] = min(Fx); rb = rb(1);
        r1 = j; % randomly select r1
        while r1==j || r1==rb
            r1 = randi(NP,1,1); end
        r2=j; % randomly select r2
        while r2==r1 || r2==j || r2==rb
            r2 = randi(NP,1,1); end
        r3 = j; % randomly select r1
        while r3==j || r3==rb || r3==r1 || r3==r2
            r3 = randi(NP,1,1); end
        r4=j; % randomly select r2
        while r4==j || r4==rb || r4==r1 || r4==r2|| r4==r3
            r4 = randi(NP,1,1); end
        r = [rb,r1,r2,r3,r4];
    case 'worst'
        % Select worst
        [~,rw] = max(Fx); rw = rw(1);
        [~,rb] = min(Fx); r2 = rb(1);
        r1 = j; % randomly select r1
        while r1==j || r1==rw || r1==r2
            r1 = randi(NP,1,1); end
        %         r2=j; % randomly select r2
        %         while r2==r1 || r2==j || r2==rw
        r3 = j; % randomly select r3
        while r3 == j || r3 == r1 || r3 == r2 || r3==rw
            r3 = randi(NP,1,1); end
        r4 = j; % randomly select r2
        while r4==r3 || r4==r2 || r4==r1 || r4==j || r4==rw
            r4 = randi(NP,1,1); end
        r = [r1,r2,rw,r3,r4];
    case 'best/worst'
        [~,rb] = min(Fx); rb = rb(1); % select rbest
        [~,rw] = max(Fx); rw = rw(1); % select rworst
        r1=j; % randomly select r2
        while r1==j || r1==rb || r1==rw
            r1 = randi(NP,1,1); end
        r = [rb,r1,rw];
end