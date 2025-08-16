close all
Influence_xyz = load('Influence_xyz_Case1.txt');
Y2=Influence_xyz(8,:)*1e2;
Y1=Influence_xyz(4,:)*1e31;
X=[1:16];
figure
grid on
scatter(X,Y1)
grid on

figure
scatter(X,Y2)
grid on
