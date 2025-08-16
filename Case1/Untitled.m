clear all;clc
Cdx=[20 20 20 20 20 20];
Cdy=[20 25 30 35 40 45];
x1=[ones(1,8)];
x2=[ 7, 1:6];
x=[x1 x2];
x=x';
index=INDEX(x,Cdx)
Co2=sequence(x,index)