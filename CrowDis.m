function [pop,cd_out,Fnum_out] = CrowDis(pop,Fnum)
%   CrowDis is used for calculating crowding distance, and sort the points in each front
% clc
% clear
% load tt
nPop=size(pop,1);
% D=length(pop(1).Pos);
% [nPop,D] = size([pop.Pos]);
M = size([pop.fit],1);

Fmax = max(Fnum);     % Fmax: the number of Front
% previous_index = 1;
% pop1_sort=pop;
cd_out=zeros(nPop,1);
Fnum_out=zeros(nPop,1);
for i = 1:Fmax
    % index of individuals in Front i
    indk=(Fnum==i);
    
    %     for k = previous_index:nPop
    %         if Fnum(k,:) ~= i
    %             break;
    %         end
    %     end
    %     if ( k==nPop ) & ( Fnum(k,:)==i )
    %         current_index = k;
    %     else
    %         current_index = k-1;
    %     end
    
    % get crowding distance
    %     clear pop1  fit1 cd1 crowdis  pop1_sort  fit1_sort   cd1_sort
    % clear pop1   crowdis
    %     pop1(1:current_index-previous_index+1,:) = P(previous_index:current_index,:);
    %     fit1(1:current_index-previous_index+1,:) = fit(previous_index:current_index,:);
    % pop1=pop(indk,:);
    cd1=[];crowdis=[];
    Fnum1 = Fnum(indk,:);
    for j=1:M
        len = size(pop(indk,:),1);
        obj = [];
        %         index = [];
        ri=find(indk);
        for k=1:len
            %             obj2(k) = fit1(k,j);
            obj(k) =pop(ri(k)).fit(j,1);
        end
        Vmax = max(obj); Vmin = min(obj);
        [sortObj,sortIndex]=sort(obj);
        crowdis(sortIndex(1),j) = inf ;
        crowdis(sortIndex(len),j) = inf;
        for k=2:len-1
            crowdis(sortIndex(k),j) = (sortObj(k+1)-sortObj(k-1)) / (Vmax-Vmin);
        end
    end
    for k = 1:size(pop(indk,:),1)
        cd1(k,:) = sum(crowdis(k,:));
    end
    
    % sort the points in each front based on crowding distance
    [~,sortIndex]=sort(cd1,'descend');
    %     pop1_sort(indk,:) = pop1(sortIndex,:);
    pop(indk,:)=pop(ri(sortIndex),:);
    %     fit1_sort = fit1(sortIndex,:);
    cd_out(indk,:)  = cd1(sortIndex,:);
    Fnum_out(indk,:) =Fnum1(sortIndex,:);
    
    
    %     pop(indk,:) = pop1_sort(indk,:);
    %     fit_out(previous_index:current_index,:) = fit1_sort(1:current_index-previous_index+1,:);
    %     cd_out(indk,:) = cd1_sort(indk,:);
    %      Fnum_out(indk,:) = Fnum1_sort(indk,:);
    %     previous_index = current_index+1;
    
end
% pop=P_out;
% pop=pop1_sort;
% cd=cd_out;

