function [f C_opt]=Objf5(x)
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
r1=x(1);
r2=x(2);
r3=x(3);
r4=x(4);
rcx=x(5);
rcy=x(6);
f=0;
for i=1:length(Cdx)
    teta2=x(9+i);
    K1=r1/r2;
    K4=r1/r3;
    K5=(r4^2-r1^2-r2^2-r3^2)/(2*r3*r2);
    D=cos(teta2)-K1+K4*cos(teta2)+K5;
    E=-2*sin(teta2);
    F=K1+(K4-1)*cos(teta2)+K5;
    ATAN3=(-E-sqrt(E^2-4*D*F))/(2*D);
    teta3=real(2*atan(ATAN3));
    Crx=r2*cos(teta2)+rcx*cos(teta3)-rcy*sin(teta3);
    Cry=r2*sin(teta2)+rcx*sin(teta3)+rcy*cos(teta3);
    C(:,i)=[cos(x(9)),-sin(x(9));sin(x(9)),cos(x(9))]*[Crx;Cry]+[x(7);x(8)];
    f=f+sum((C(:,i)-[Cdx(i);Cdy(i)]).^2);
end
C_opt=C;
end