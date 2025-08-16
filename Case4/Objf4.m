function [f C_opt]=Objf4(x)
% Tinh ham cost: Tinh sai lech so voi vi tri thiet ke
C1=[0;0];
C2=[1.9098 ;5.8779];
C3=[6.9098; 9.5106];
C4=[13.09; 9.5106];
C5=[18.09 ;5.8779];
C6=[20 ;0.0];
% Quy dao cho truoc
CD=[C1,C2,C3,C4,C5,C6];
% ==========================
Cdx=CD(1,:); Cdy=CD(2,:);
% ==========================
r1=x(1); r2=x(2);
r3=x(3); r4=x(4);
rcx=x(5); rcy=x(6);
f=0;
Teta2=[pi/6;pi/3;pi/2;2*pi/3;5*pi/6;pi];
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
    Crx=r2*cos(teta2)+rcx*cos(teta3)-rcy*sin(teta3);
    Cry=r2*sin(teta2)+rcx*sin(teta3)+rcy*cos(teta3);
    C(:,i)=[cos(x(9)),-sin(x(9));sin(x(9)),cos(x(9))]*[Crx;Cry]+[x(7);x(8)];
    f=f+sum((C(:,i)-[Cdx(i);Cdy(i)]).^2);
end
C_opt=C;