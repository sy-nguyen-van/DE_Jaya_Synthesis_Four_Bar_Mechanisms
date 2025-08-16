clc;clear all;close all;
addpath DE-functions
addpath SOS-functions
addpath Additional-functions
addpath Case1
addpath Case4
addpath Case5
format long
% ===================================================
% So lan chay bai toan
% NP  GEN
% CASE 1: 100 1000:  2.37x10-4: : Can dieu kien GOC QUAY TANG DAN==== LAM THEO
% CASE 2: 50 100:    4.27×10-6 ========KO LAM THEO
% CASE 3: 50 100:    0.0349    ========KO LAM THEO
% CASE 4: 100 1000: 2.49       ========LAM THEO
% CASE 5: 100 1000: 4.7x10-3: Can dieu kien GOC QUAY TANG DAN=======LAM
% THEO
% Chon bai toan: Case 1, Case 2, Case 3
Options.alpha = [1e2 1e3];
Options.eta = 1e-4;
Options.tol = 1e-5;  % Tolerance of stopping condition
Options.G_XP =1e-1;
Problem=5;
No_runs=5;
% Chon giai thuat giai: 1) Modified DE; 2)Original DE; 3)Original SOS
Algo=1;
CASE = strcat('Case',num2str(Problem));
% Thong so bai toan optimization
switch CASE
    case 'Case1'
        Options.Popsize  = 100;  % Population size
        Options.Totalgen = 1000; % Maximum iteration
    case 'Case2'
        Options.Popsize  = 50;   % Population size
        Options.Totalgen = 100;  % Maximum iteration
    case 'Case3'
        Options.Popsize  = 50;   % Population size
        Options.Totalgen = 100;  % Maximum iteration
    case 'Case4'
        Options.Popsize  = 100;  % Population size
        Options.Totalgen = 1000; % Maximum iteration
    case 'Case5'
        Options.Popsize  = 100;  % Population size
        Options.Totalgen = 1000; % Maximum iteration
end
%==========================================================================
% Truy cap ham object va rang buoc;
[nvars,Objf,Const,LB,UB]= Mechanisms(CASE);
% Giai bai toan toi uu hoa;
[Records PIC]=Algorithms(Algo,No_runs,CASE,nvars,Objf,Const,LB,UB,Options);
% plot(STD);
% Chay
% Algo=2; % 1 MDE % 2 DE
% [Records PIC]=Algorithms(Algo,No_runs,CASE,nvars,Objf,Const,LB,UB,Options);
% So sanh ket qua
% Compare(CASE);
