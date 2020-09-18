function [pop,Fnum_out] = nondSort(pop) 
% Fast nondominated sorting 

popSize=size(pop,1);
% D=length(pop(1).Pos);
% [popSize,D] = size([pop.Pos]);      
% M = size([pop.fit],2);
 
for i = 1:popSize
    pop_s(i).np = 0;   
    pop_s(i).Sp = [];   
end
for i=1:popSize
    for j=1:popSize 
        if Dominate(pop(i).fit',pop(j).fit')   % P(i) donimates P(j)  
             pop_s(i).Sp = [pop_s(i).Sp j ];
        elseif Dominate(pop(j).fit',pop(i).fit')   % P(i) is dominated by P(j) 
             pop_s(i).np = pop_s(i).np+1;
        end   
    end
end

% Individuals in the first Front  
front = 1;
F = [];   
for i = 1:popSize
    if pop_s(i).np == 0
        Fnum(i,:) = 1;
        F = [F i];
    end
end
 
% Individuals in other Front  
Q=[];
while ~isempty(F) 
    for i = 1:length(F)                         
        for j = 1:length(pop_s(F(i)).Sp)        
            ind1 = pop_s(F(i)).Sp(j);            
            pop_s(ind1).np = pop_s(ind1).np-1; 
            if  pop_s(ind1).np == 0
                Q = [Q ind1];                 
                Fnum(ind1,:) = front+1;
            end    
        end 
    end
    front = front+1;
    F = Q;Q = []; 
end


[~,sortIndex] = sort(Fnum);
pop = pop(sortIndex,:);
% fit_out  = fit(sortIndex,:);
Fnum_out  = Fnum(sortIndex,:); 

