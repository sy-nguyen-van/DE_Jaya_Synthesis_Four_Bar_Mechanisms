function [r1 r2 r3 r4 r5]=selection(i,NP)
r1=i;r2=r1;r3=r1;r4=r1;r5=r1;
while i==r1
    seed=randperm(NP);
    r1=seed(1);
end
while r2==i||r2==r1
    seed=randperm(NP);
    r2=seed(1);
end
while r3==i||r3==r1||r3==r2
    seed=randperm(NP);
    r3=seed(1);
end
while r4==i||r4==r1||r4==r2||r4==r3
    seed=randperm(NP);
    r4=seed(1);
end
while r5==i||r5==r1||r5==r2||r5==r3||r5==r4
    seed=randperm(NP);
    r5=seed(1);
end
end