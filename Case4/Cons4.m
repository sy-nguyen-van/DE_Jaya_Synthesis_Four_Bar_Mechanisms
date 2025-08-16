function Vo=Cons4(x)
summaxmin=max(x(1:4))+min(x(1:4));
Other=sum(x(1:4))-summaxmin;
if summaxmin-Other<=0 & x(2)==min(x(1:4))% Grashof condition
    Vo=0;
else
    Vo=1;
end
end

