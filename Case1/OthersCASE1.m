clear all;clc
MUMSA=[31.788264 8.2046468 24.932131 31.385926 34.193719 14.415668 -6.366519 56.83676 4.015959 1.366547 2.330773 2.871039 3.394591 3.97096 4.96349 ]
x=MUMSA;
% IOA=[54.715815 18.730993 31.223101 42.223736 -27.29874 31.650513 5.977455 43.070863 27.417061 6.424111 6.534955 0.362302 0.469063 0.577652 0.690469];
% x=IOA;
% x7=x(7);
% x89=x(8:9);
% x(7:8)=x89;
% x(9)=x7;
x=x';
Cdx=[20 20 20 20 20 20];
Cdy=[20 25 30 35 40 45];
r1=x(1);
r2=x(2);
r3=x(3);
r4=x(4);
rcx=x(5);
rcy=x(6);
error=0;
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
    error=error+sum((C(:,i)-[Cdx(i);Cdy(i)]).^2);
end
x=[x;error]
error

