function [f C_opt]=Objf2(x)
% X=[r1 r2 r3 r4 rcx rcy teta0 x0 y0]
% Tinh ham cost: Tinh sai lech so voi vi tri thiet ke
% Quy dao thiet ke
Cdx=[3, 2.759, 2.372, 1.890, 1.355];
Cdy=[3, 3.363, 3.663, 3.862, 3.943];
% Kich thuoc cac khau
r1=x(1); r2=x(2);
r3=x(3); r4=x(4);
rcx=x(5); rcy=x(6);
% Khoi tao ham cost ban dau
f=0;
% Cac goc teta2
Teta2=[pi/6;pi/4;pi/3;5*pi/12;pi/2];
for i=1:length(Cdx)
    % teta 3
    teta2=Teta2(i);
    K1=r1/r2;
    K4=r1/r3;
    K5=(r4^2-r1^2-r2^2-r3^2)/(2*r3*r2);
    D=cos(teta2)-K1+K4*cos(teta2)+K5;
    E=-2*sin(teta2);
    F=K1+(K4-1)*cos(teta2)+K5;
    ATAN3=(-E-sqrt(E^2-4*D*F))/(2*D);
    teta3=real(2*atan(ATAN3));
    % Quy dao tim ra
    Crx=r2*cos(teta2)+rcx*cos(teta3)-rcy*sin(teta3);
    Cry=r2*sin(teta2)+rcx*sin(teta3)+rcy*cos(teta3);
    C(:,i)=[Crx;Cry];
    % So sanh tim ERRIR
    f=f+sum((C(:,i)-[Cdx(i);Cdy(i)]).^2);
end
C_opt=C;
end