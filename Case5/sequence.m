function vo2=sequence(x,index)
vo2=0;
for i=1:length(index)-1
if x(index(i))-x(index(i+1))<0
    vo2=vo2+0;
else 
    vo2=vo2+1;
end
end
