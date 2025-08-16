x1=ones(1,9);
x2=rand(1,6);
% x2=1:6;
Cdx=ones(1,6);
x=[x1,x2];
x=x'
x1=x;
index=INDEX(x,Cdx)
Co2=sequence(x,index)
while Co2>0
    [~,index1]=sort(x(10:end))
    index1=index1+9
    for ij=1:length(index)
     x1(index(ij))=x(index1(ij));   
    end
    x=x1;
    Co2=sequence(x,index)
end
X=[x,x1]