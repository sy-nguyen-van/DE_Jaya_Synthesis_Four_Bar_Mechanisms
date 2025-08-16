function [f C_opt]=Objf3(x)
% Tinh ham cost: Tinh sai lech so voi vi tri thiet ke
CD=[0.5, 1.1;    0.4, 1.1;    0.3, 1.1;    0.2, 1.0;    
    0.1, 0.9;    0.05, 0.75;    0.02, 0.6;    
    0.0, 0.5;    0.0, 0.4;    0.03, 0.3;    
    0.1, 0.25;    0.15, 0.2;    0.2, 0.3;    
    0.3, 0.4;    0.4, 0.5;    0.5, 0.7;    
    0.6, 0.9;    0.6, 1.0];
% Quy dao cho truoc
CD=CD';
% ==========================
Cdx=CD(1,:); Cdy=CD(2,:);
% ==========================
r1=x(1); r2=x(2);
r3=x(3); r4=x(4);
rcx=x(5); rcy=x(6);
f=0;
for i=1:length(Cdx);
    % teta3
    teta2=x(10)+(i-1)*(pi/9);
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
% Dieu kien quay toan vong GRASHOF
