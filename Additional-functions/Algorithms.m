function [Records DATA Influence] = Algorithms(Algo,No_Records,CASE,nvars,Objf,Const,LB,UB,Options,Percent,SIGMA,FIND,FF)
addpath DE-functions
addpath Jaya-functions
addpath HCDJ-functions
addpath Case1
addpath Case2
addpath Case3
addpath Case4
addpath Case5
addpath Additional-functions
format long
% =========================================================================
Additional_space=5;
Records=zeros(No_Records+Additional_space,10);
% Main ='C:\Users\Admin\Google Drive\1 Master Degree\1 Jounal Papers\Synthesis of mechanisms_edit\';
Main ='C:\Users\user\Google Drive\1 Master Degree\1 Jounal Papers\Synthesis of mechanisms_edit\';

Folder = strcat(Main,CASE);
switch Algo
    %================HDEJaya================================================
    case 1
        if FIND==1
            sigma=SIGMA;
            for jj=1:size(Percent,1);
                mpercent=Percent(jj,1);
                kpercent=Percent(jj,2);
                for zz=1:No_Records
                    tic
                    [xopt_HCDJ,fopt_HCDJ,FES_HCDJ,PIC_HCDJ,Alarm]= HCDJ(nvars,Objf,Const,LB,UB,Options,mpercent,kpercent,sigma,FF,CASE);
                    time=toc;               
                    Records(zz,1:3)=[fopt_HCDJ,FES_HCDJ,time];
                    FES(:,zz)=PIC_HCDJ(:,1);
                    COST(:,zz)=PIC_HCDJ(:,2);
                    Xbest(1:nvars,zz)=xopt_HCDJ';
                end
                [fminj index]=min(Records(1:No_Records,1));
                fmin(jj)=fminj;
                DATA(jj).FES=FES(:,index);
                DATA(jj).Xbest=Xbest(:,index);
                DATA(jj).COST=COST(:,index);
                Records(end,1)=std(Records(1:No_Records,1));
                Records(end-1,1)=mean(Records(1:No_Records,1));
                Records(end-2,1)=max(Records(1:No_Records,1));
                Records(end-3,1)=Records(index,2);
                Records(end-4,1)=Records(index,1);
                Records(No_Records+1,2)=index;
                Influence(:,jj)=[Percent(jj,:)';Records(No_Records+1:end,1);DATA(jj).Xbest];
                DATA(jj).Records=Records;
            end
        elseif FIND==2
            for jj=1:size(SIGMA,2);
                sigma=SIGMA(jj);
                mpercent=Percent(1);
                kpercent=Percent(2);
                for zz=1:No_Records
                    tic
                    [xopt_HCDJ,fopt_HCDJ,FES_HCDJ,PIC_HCDJ,Alarm]= HCDJ(nvars,Objf,Const,LB,UB,Options,mpercent,kpercent,sigma,FF,CASE);
                    time=toc;
                    Records(zz,1:3)=[fopt_HCDJ,FES_HCDJ,time];
                    FES(:,zz)=PIC_HCDJ(:,1);
                    COST(:,zz)=PIC_HCDJ(:,2);
                    Xbest(1:nvars,zz)=xopt_HCDJ';
                end
                [fminj index]=min(Records(1:No_Records,1));
                fmin(jj)=fminj;
                DATA(jj).FES=FES(:,index);
                DATA(jj).Xbest=Xbest(:,index);
                DATA(jj).COST=COST(:,index);
                Records(end,1)=std(Records(1:No_Records,1));
                Records(end-1,1)=mean(Records(1:No_Records,1));
                Records(end-2,1)=max(Records(1:No_Records,1));
                Records(end-3,1)=Records(index,2);
                Records(end-4,1)=Records(index,1);
                Records(No_Records+1,2)=index;
                Influence(:,jj)=[SIGMA(jj);Records(No_Records+1:end,1);DATA(jj).Xbest];
                DATA(jj).Records=Records;
            end
        else
            for jj=1:size(FF,2);
                sigma=SIGMA;
                ff=FF(jj);                
                mpercent=Percent(1);
                kpercent=Percent(2);
                for zz=1:No_Records
                    tic
                    [xopt_HCDJ,fopt_HCDJ,FES_HCDJ,PIC_HCDJ,Alarm]= HCDJ(nvars,Objf,Const,LB,UB,Options,mpercent,kpercent,sigma,ff,CASE);
                    time=toc;
                    Records(zz,1:3)=[fopt_HCDJ,FES_HCDJ,time];
                    FES(:,zz)=PIC_HCDJ(:,1);
                    COST(:,zz)=PIC_HCDJ(:,2);
                    Xbest(1:nvars,zz)=xopt_HCDJ';
                end
                [fminj index]=min(Records(1:No_Records,1));
                fmin(jj)=fminj;
                DATA(jj).FES=FES(:,index);
                DATA(jj).Xbest=Xbest(:,index);
                DATA(jj).COST=COST(:,index);
                Records(end,1)=std(Records(1:No_Records,1));
                Records(end-1,1)=mean(Records(1:No_Records,1));
                Records(end-2,1)=max(Records(1:No_Records,1));
                Records(end-3,1)=Records(index,2);
                Records(end-4,1)=Records(index,1);
                Records(No_Records+1,2)=index;
                Influence(:,jj)=[FF(jj);Records(No_Records+1:end,1);DATA(jj).Xbest];
                DATA(jj).Records=Records;
            end
        end
        [f_best index1]=min(fmin);
        x_best=DATA(index1).Xbest;
        Records= DATA(index1).Records;
        Records(1:nvars,4)=x_best;
        [ineq,C] = feval(Objf,x_best);
        Records(1:length(C),5:6)=C';
        FES=DATA(index1).FES;
        COST=DATA(index1).COST;
        Converate_HCDJ=[FES COST];
        %=====================
        filename = 'DATA_' ;   % text file name
        filename = strcat(filename,CASE,'.mat');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'DATA')
        %=====================
        filename = 'x_best_HCDJ_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'x_best','-ascii')
        % =====
        filename = 'Converate_HCDJ_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Converate_HCDJ','-ascii')
        %===============
        filename = 'Records_HCDJ_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Records','-ascii');
        %====================
        if FIND==1
            name='xyz_';
        elseif FIND==2;
            name='Sigma_';
        else
            name='FF_';
        end
        filename = 'Influence_' ;   % text file name
        filename = strcat(filename,name,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Influence','-ascii')
        
    case 2
        DATA=zeros(50,No_Records);Influence=zeros(50,No_Records);
        for zz=1:No_Records
            tic
            [xopt_DE,fopt_DE,FES_DE,PIC_DE,Alarm]= DE(nvars,Objf,Const,LB,UB,Options);
            time=toc;
            while Alarm==1
                tic
                [xopt_DE,fopt_DE,FES_DE,PIC_DE,Alarm]= DE(nvars,Objf,Const,LB,UB,Options);
                time=toc;
            end
            
            Records(zz,1:3)=[fopt_DE,FES_DE,time];
            PIC(zz).FES=PIC_DE(:,1);
            PIC(zz).fopt=PIC_DE(:,2);
            Xbest(1:nvars,zz)=xopt_DE';
        end
        Records(end,1)=std(Records(1:No_Records,1));
        Records(end-1,1)=mean(Records(1:No_Records,1));
        [ab index]=min(Records(1:No_Records,1));
        Records(end-2,1)=max(Records(1:No_Records,1));
        Records(end-3,1)=Records(index,2);
        Records(end-4,1)=Records(index,1);
        x_best= Xbest(1:end,index);
        Records(1:length(x_best),4)=x_best;
        [ineq,C] = feval(Objf,x_best);
        Records(1:length(C),5:6)=C';
        f_best=PIC(index).fopt  ;
        FES=PIC(index).FES;
        Converate_DE=[FES f_best];
        %%%%%%%%%%%%%%%%%%%
        filename = 'x_best_DE_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'x_best','-ascii')
        % ========
        filename = 'Converate_DE_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Converate_DE','-ascii')
        %%%%
        filename = 'Records_DE_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Records','-ascii');
        %==============Jaya=====================
    case 3
        DATA=zeros(50,No_Records);Influence=zeros(50,No_Records);
        Records=zeros(No_Records+5,10);
        for zz=1:No_Records
            tic
            [xopt_Jaya,fopt_Jaya,FES_Jaya,PIC_Jaya,STD,Alarm]= Jaya(nvars,Objf,Const,LB,UB,Options);
            time=toc;
            while Alarm==1;
                tic
                [xopt_Jaya,fopt_Jaya,FES_Jaya,PIC_Jaya,STD,Alarm]= Jaya(nvars,Objf,Const,LB,UB,Options);
                time=toc;
            end
            Records(zz,1:3)=[fopt_Jaya,FES_Jaya,time];
            PIC(zz).FES=PIC_Jaya(:,1);
            PIC(zz).fopt=PIC_Jaya(:,2);
            Xbest(1:nvars,zz)=xopt_Jaya';
        end
        Records(end,1)=std(Records(1:No_Records,1));
        Records(end-1,1)=mean(Records(1:No_Records,1));
        [ab index]=min(Records(1:No_Records,1));
        Records(end-2,1)=max(Records(1:No_Records,1));
        Records(end-3,1)=Records(index,2);
        Records(end-4,1)=Records(index,1);
        x_best= Xbest(1:end,index);
        Records(1:length(x_best),4)=x_best;
        [ineq,C] = feval(Objf,x_best);
        Records(1:length(C),5:6)=C';
        f_best=PIC(index).fopt  ;
        FES=PIC(index).FES;
        Converate_Jaya=[FES f_best];
        %%%%%%%%%%%%%%%%
        filename = 'x_best_Jaya_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'x_best','-ascii')
        % ========
        filename = 'Converate_Jaya_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Converate_Jaya','-ascii')
        %%%%%%%%%%%%%%%%%%%%%%%
        filename = 'Records_Jaya_' ;   % text file name
        filename = strcat(filename,CASE,'.txt');
        file = [Folder filesep filename] ;  % make filename  with path
        save(file,'Records','-ascii');
        %==============Jaya=====================
end
