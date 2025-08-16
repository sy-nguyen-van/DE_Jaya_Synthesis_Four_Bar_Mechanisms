function [f C_opt]=Objf1(x)
% X=[r1 r2 r3 r4 rcx rcy teta0 x0 y0 teta1 teta2 teta3...teta6] Tinh ham
% cost: Tinh sai lech so voi vi tri thiet ke
Cdx=[20 20 20 20 20 20];
Cdy=[20 25 30 35 40 45];
r1=x(1);
r2=x(2);
r3=x(3);
r4=x(4);
rcx=x(5);
rcy=x(6);
f=0;
for i=1:length(Cdx)
    % teta3
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