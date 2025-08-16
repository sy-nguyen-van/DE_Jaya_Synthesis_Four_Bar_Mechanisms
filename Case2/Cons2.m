function Vo=Cons2(x)
summaxmin=max(x(1:4))+min(x(1:4));
Other=sum(x(1:4))-summaxmin;
if summaxmin-Other<=0 %& x(2)==min(x(1:4))% Grashof condition
    vo1=0;
else
    vo1=1;
end
Vo=vo1;
end

