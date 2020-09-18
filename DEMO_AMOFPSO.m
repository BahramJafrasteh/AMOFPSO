%% AUTHOR: Bahram Jafrasteh
%% Multiobjective fuzzy PSO algorithm
clear;
clc;

format long

save_option=0;

global Ub Lb numObj D
addpath('testFunctions');
addpath('ParetoFront');
addpath('Functions');
fun_t={'ZDT1','ZDT2','ZDT3','ZDT4','ZDT6','DTLZ1',...
    'DTLZ2','DTLZ3','DTLZ4','DTLZ5','DTLZ6','DTLZ7'};
for func=4:4
    load('fuzzypso.mat')
    fun=fun_t{func};       % choose problem
    load(fun)
    for count=1:1
        tic
%         rand('state',sum(100*clock))

        [numObj,D,Ub,Lb]=test_function_range(fun);
        objfunc='mo_test_function';
        vis=0; %Visualization
        % input parameters
        nPop = 100;
        MaxIt =  300;



        empty_particle.Pos=[];
        empty_particle.Vel=[];
        empty_particle.fit=[];
        pop=repmat(empty_particle,nPop,1);
        for i=1:nPop
            pop(i).Pos=rand(1,D).*(Ub-Lb)+ Lb;
            pop(i).Vel=.3*ones(1,D);
            pop(i).fit=feval(objfunc,pop(i).Pos,fun);
        end


        [pop,Fnum] = nondSort(pop);   % Fast nondominated sorting
        [pop,cd,Fnum] = CrowDis(pop,Fnum); % Crowding distance
              fit_it=[pop(Fnum==1).fit]';
        Igd0 = calculateIGD(fit_it,PF)
        % Select Gbest
        indF=find(Fnum==1);
        indg=randi(length(indF),1);
%         indF(indg)=[];
        Gbest=pop(indg,:);
        Pbest=pop;
        cd=[];
        Fnum=[];
        It=1;
        while It<=MaxIt
            %% adjust w, c1 and c2
            Foods=reshape([pop.Pos],D,nPop)';
            fit=[pop.fit]';
            dist2=(pdist2(Foods,Gbest.Pos));
            div=mean(dist2);
            maxdiv=max(dist2);
            mindiv=min(dist2);
            if max(dist2)~=min(dist2)
                Div(It)=std(dist2)./mean(dist2);
            else
                Div(It)=0;
            end
            if Div(It)>1
                Div(It)=1;
            end
            for i=1:numObj
                minf=min(fit(:,i));
                %                     minf=Gbest.fit(i,:);
                maxf=max(fit(:,i));
                %         tr=mean(fit(:,i));
                tr=fit(:,i);
                if maxf~=minf
                    rns=maxf-minf;

                    Erp(:,i)=(abs(tr-minf)./rns);
                    Err(i)=sum(Erp(:,i));
                else
                    Err(i)=0;
                end
            end

            Ert=sum(Err);
            Er(It)=Ert./(numObj*nPop);
            %     It=It / maxCycle;
            ta=evalfis([Div(It),Er(It)],PSOtune_ED);
            c1(It)=ta(1);
            c2(It)=ta(2);
            w(It)=ta(3);
            %% Update Position
            npop=pop;
            dist2(dist2==0)=inf;
            [~,sortd]=sort(dist2,'ascend');
            for k = 1:nPop
                num=round(0.1*nPop);
                index=sortd(randperm(num,1));
                pop(k).Vel = w(It)*pop(index(1)).Vel ...
                    +c1(It)*rand(1,D).*(Pbest(index(1)).Pos-pop(index(1)).Pos) ...
                    +c2(It)*rand(1,D).*(Gbest.Pos-pop(index(1)).Pos);
                Mus(k).Pos = pop(index(1)).Pos + pop(k).Vel;
            end

            %  Stochastically select ones dimension to update
            for k = 1:nPop
%                 for jj=1:1
                    sn = randi(D);
                    npop(k).Pos(sn)=Mus(k).Pos(sn);
%                 end
                % Check boundary constraints
                [npop(k).Pos] = CheckBound_r(npop(k),Ub,Lb);
                %Evaluate particles
                npop(k).fit = mo_test_function(npop(k).Pos,fun);
            end

            % (c)  If the candidate dominates the parent, the candidate replaces the parent.
            %      If the parent dominates the candidate, the candidate is discarded.
            %      Otherwise, the candidate is added in the population.
            num = nPop+1;
            for k = 1:nPop
                if Dominate(npop(k).fit',pop(k).fit')
                    pop(k,:)=npop(k,:);
                    Pbest(k,:)=npop(k,:);

                elseif ~Dominate(npop(k).fit',pop(k).fit') & ~Dominate(pop(k).fit',npop(k).fit')
                    pop(num,:) = npop(k,:);
                    num = num+1;
                end
            end


            [pop,Fnum] = nondSort(pop);   % Fast nondominated sorting
            [pop,~,Fnum] = CrowDis(pop,Fnum); % Crowding distance
            % select gbest from pareto front 1
            indF=find(Fnum==1);
            indg=randi(length(indF),1);
%             indF(indg)=[];
            Gbest=pop(indg,:);
            %  truncate population
            fit_it=[pop(Fnum==1).fit]';
            pop = pop(1:nPop,:);

            cd=[];
            Fnum=[];

            % calculate the performance metric GD and IGD
            Igd = calculateIGD(fit_it,PF);

            fprintf([fun,':Count=%g,Iteration = %g,,IGD = %g\n'],count,It,Igd)
            % plot the pareto front
            if vis
                fit=[pop.fit]';
                if mod(It,1 )==0
                    if numObj==2%0.0112057, IGD = 0.00304221
                        plot(PF(:,1),PF(:,2),'color','r')
                        hold on
                        plot(fit(:,1),fit(:,2),'o','MarkerSize',5);
                        hold off
                    elseif numObj==3
                        plot3(fit(:,1),fit(:,2),fit(:,3),'o','MarkerSize',5);
                        set(gca,'xdir','reverse'); set(gca,'ydir','reverse');
                    end
                    title([num2str(It),'  ' ,num2str(size(pop,1))])
                    drawnow
                end
            end
            It = It + 1;
        end
        [pop,Fnum] = nondSort(pop);   % Fast nondominated sorting
        fitt{count}=[pop(Fnum==1).fit]';
        IGD(count) = calculateIGD(fitt{count},PF);
        GD(count) = calculateGD(fitt{count},PF);
        r=max(PF);
        HV(count)=hypervolume(fitt{count},r,10000);
        time=toc;
    end
    if save_option
        save(['NAMOFPSO_',fun],'fitt','IGD')
    end
end
