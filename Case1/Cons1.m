function [Co index]=Cons1(x)
Cdx=[20 20 20 20 20 20];
Cdy=[20 25 30 35 40 45];
summaxmin=max(x(1:4))+min(x(1:4));
Other=sum(x(1:4))-summaxmin;
if summaxmin-Other<=0 & x(2)==min(x(1:4))% Grashof condition
    Co1=0;
else
    Co1=1;
end
% Dieu kien cho gia tri goc cua TAY QUAY: Tang dan hoac Giam dan
index=INDEX(x,Cdx);
Co2=sequence(x,index);
Co=Co1+Co2;
end
