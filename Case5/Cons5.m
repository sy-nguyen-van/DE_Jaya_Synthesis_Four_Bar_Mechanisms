function Co=Cons5(x)
C1=[20;10];
C2=[17.66;15.142];
C3=[11.736;17.878];
C4=[5;16.928];
C5=[0.60307;12.736];
C6=[0.60307;7.2638];
C7=[5;3.0718];
C8=[11.736;2.1215];
C9=[17.66;4.8577];
C10=[20;10];
% Quy dao cho truoc
CD=[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10];
% ==========================
Cdx=CD(1,:); Cdy=CD(2,:);
summaxmin=max(x(1:4))+min(x(1:4));
Other=sum(x(1:4))-summaxmin;
if summaxmin-Other<=0 %& x(2)==min(x(1:4))% Grashof condition
    Co1=0;
else
    Co1=1;
end
% Dieu kien cho gia tri goc cua TAY QUAY: Tang dan hoac Giam dan
index=INDEX(x,Cdx);
Co2=sequence(x,index);
Co=Co1+Co2;
end

