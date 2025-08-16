function x=SORTTETA(x,index,lu)
for i=1:length(index)-1
    ERROR=x(index(i))- x(index(i+1));
    if ERROR>=0
        x(index(i+1))= x(index(i+1))+(2-rand)*ERROR;
    end
    
end