function [RESULTS]=Compare(CASE)
addpath Case1
addpath Case2
Main ='G:\My Drive\1 A my research\1 Jounal Papers\Journal forms\Paper 4\HCDJ\';
Folder = strcat(Main,CASE);
Converate_HCDJ=strcat(Folder,'\Converate_HCDJ_',CASE,'.txt');
Converate_DE=strcat(Folder,'\Converate_DE_',CASE,'.txt');
Converate_Jaya=strcat(Folder,'\Converate_Jaya_',CASE,'.txt');
%=====================================================
xbest_HCDJ=strcat(Folder,'\x_best_HCDJ_',CASE,'.txt');
xbest_DE=strcat(Folder,'\x_best_DE_',CASE,'.txt');
xbest_Jaya=strcat(Folder,'\x_best_Jaya_',CASE,'.txt');
%=====================================================
Records_HCDJ=strcat(Folder,'\Records_HCDJ_',CASE,'.txt');
Records_DE=strcat(Folder,'\Records_DE_',CASE,'.txt');
Records_Jaya=strcat(Folder,'\Records_Jaya_',CASE,'.txt');
%===========Run=Anas=for truss structure=======================
Converate_HCDJ=load(Converate_HCDJ);
Converate_DE=load(Converate_DE);
Converate_Jaya=load(Converate_Jaya);
%=====================================================
xbest_HCDJ=load(xbest_HCDJ);
xbest_DE=load(xbest_DE);
xbest_Jaya=load(xbest_Jaya);
%=====================================================
Records_HCDJ=load(Records_HCDJ);
Records_DE=load(Records_DE);
Records_Jaya=load(Records_Jaya);
%=====================================================
RESULTS=[xbest_DE,xbest_Jaya,xbest_HCDJ;
    Records_DE(end-4,1),Records_Jaya(end-4,1),Records_HCDJ(end-4,1);
    Records_DE(end-2:end,1),Records_Jaya(end-2:end,1),Records_HCDJ(end-2:end,1)];
%=====================================================
% Converate_HCDJ(:,2)=log(Converate_HCDJ(:,2));
% Converate_DE(:,2)=log(Converate_DE(:,2));
% Converate_Jaya(:,2)=log(Converate_Jaya(:,2));

figure
plot(Converate_HCDJ(:,1),Converate_HCDJ(:,2),'r--','LineWidth',2)
hold on
plot(Converate_DE(:,1),Converate_DE(:,2),'b-','LineWidth',2)
hold on
plot(Converate_Jaya(:,1),Converate_Jaya(:,2),'k-.','LineWidth',2)
xlabel('Number of analyses','FontSize',13,'FontWeight','bold')
ylabel('Values of the objective function','FontSize',13,'FontWeight','bold')
% a=get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'fontsize',13)
set(gca,'fontsize',13)
box
legend('HCDJ','DE','Jaya')
end





