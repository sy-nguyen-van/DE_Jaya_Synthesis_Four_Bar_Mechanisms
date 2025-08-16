function index=INDEX(x,Cdx)
A=x(10:end);
[z imin]=min(A);
index=zeros(1,length(Cdx));
index(1)=9+imin;
for i=1:length(Cdx)-1
    AA=mod(imin+i,length(Cdx));
    index(1+i)=9+AA;
    if AA==0
        index(1+i)=9+length(Cdx);
    end
end
end