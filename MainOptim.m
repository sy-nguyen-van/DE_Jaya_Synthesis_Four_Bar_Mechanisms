clc;clear all;close all;
addpath DE-functions
addpath Jaya-functions
addpath HCDJ-functions
addpath Additional-functions
addpath Case1
addpath Case2
addpath Case3
addpath Case4
addpath Case5
format long
% ====================================
% So lan chay bai toan NP=GEN
% Problem 1: 100 1000:  4.06717E–12:    Can dieu kien GOC QUAY TANG DAN
% Problem 2: 50  100:   4.27×10-6
% Problem 3: 50  100:   0.03375
% Problem 4: 100 1000:  1.216
% Problem 5: 100 1000:  4.02E–4:        Can dieu kien GOC QUAY TANG DAN (MY: 2.2E-3)
% Chon bai toan: Case 1, Case 2, Case 3, Case 4, Case 5
% Ortiz: 50 runs
% Lin: 50 runs
% ===================================
Problem=4; % Loai bai toan
COMPA=1;
No_runs=50; % So lan chay
% Chon giai thuat giai;
Algo=2; % 1) HCDJ; 2) DE; 3) Jaya;
FIND=1; % 1: percent of k and m : 2 Influence of Sigma   3: Influence of FF
CASE = strcat('Case',num2str(Problem));
% Thong so bai toan optimization;
Options=OPTIONS_CASE(CASE);
% ====================================
% Truy cap ham object va rang buoc;
[nvars,Objf,Const,LB,UB,CASE] = Mechanisms(CASE);
% Giai bai toan toi uu hoa;
Percent=[0.2,0.3,0.5]; % ============
% FF=0.7+rand*0.3; SIGMA=0.3;
FF=0.7; SIGMA=0.2;
% Tim cac thong so toi uu: Percent sigma FF;
if COMPA==0;
    if Algo==1
        if FIND==1
%             Percent=load('percent_km.txt');
            [Records DATA Influence]=Algorithms(Algo,No_runs,CASE,nvars,Objf,Const,LB,UB,Options,Percent,SIGMA,FIND,FF);
            % BEST COST % =======================
            [f index_mincost]= min(Influence(4,:))
            Best_Percent_cost=Percent(index_mincost,:)
            % Max cost
            [f index_maxcost]= max(Influence(6,:))
            Max_Percent_cost=Percent(index_maxcost,:)
            % =====% BEST MEAN %================
            [f index_mean]= min(Influence(7,:))
            Best_Percent_mean=Percent(index_mean,:)
            % ===== % BE=ST STD %================
            [f index_std]= min(Influence(8,:))
            Best_Percent_std = Percent(index_std,:)
        elseif FIND==2
            SIGMA=[0.2:0.1:0.8];
            [Records DATA Influence]=Algorithms(Algo,No_runs,CASE,nvars,Objf,Const,LB,UB,Options,Percent,SIGMA,FIND,FF);
            % BEST COST
            [f index_mincost]=min(Influence(2,:))
            Best_SIGMA_cost=SIGMA(index_mincost)
            % Max COST
            [f index_maxcost]=max(Influence(4,:))
            Max_SIGMA_maxcost=SIGMA(index_maxcost)
            % =====% BEST MEAN
            [f index_mean]=min(Influence(5,:))
            Best_SIGMA_mean=SIGMA(index_mean)
            % ===== % BEST STD
            [f index_std]=min(Influence(6,:))
            Best_SIGMA_std=SIGMA(index_std);
        else
            FF=[0.4:0.1:0.8];
            [Records DATA Influence]=Algorithms(Algo,No_runs,CASE,nvars,Objf,Const,LB,UB,Options,Percent,SIGMA,FIND,FF);
            % ========== BEST COST ==========
            [f1 index_mincost]=min(Influence(2,:));
            Best_FF_cost=FF(index_mincost);
            % ========== MAX COST ==========
            [f1, index_maxcost]=max(Influence(4,:));
            Max_FF_cost=FF(index_maxcost);
            % ====== BEST MEAN ==============
            [f2 index_mean]=min(Influence(5,:));
            Best_FF_mean = FF(index_mean);
            % ====== BEST STD ==============
            [f3 index_std] = min(Influence(6,:));
            Best_FF_std=FF(index_std);
        end
    else
        SIGMA=0;    KM=0;    FF=0; % ======================
        [Records DATA Influence] = Algorithms(Algo,No_runs,CASE,nvars,Objf,Const,LB,UB,Options,Percent,SIGMA,FIND,FF);
    end
    RESULTS=Compare(CASE);
    
else
    % So sanh ket qua
    RESULTS=Compare(CASE);
    if Problem==1
        Influence_xyz = strcat('Influence_xyz_',CASE,'.txt');
        Influence_xyz=load(Influence_xyz);
                Influence_FF = strcat('Influence_FF_',CASE,'.txt');
        Influence_FF=load(Influence_FF);
                        Influence_Sigma = strcat('Influence_Sigma_',CASE,'.txt');
        Influence_Sigma=load(Influence_Sigma);
    end
end
