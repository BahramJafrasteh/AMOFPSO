function C1=CheckBound_r(CX,Cmax,Cmin)
%  check bound constraints
C=CX.Pos;
[m,n]=size(C);

for i=1:m
    for j=1:n
        if C(i,j)>Cmax(j)
            C1(i,j)=Cmax(j);
        elseif C(i,j)<Cmin(j)
            C1(i,j)=Cmin(j);
        else
            C1(i,j)= C(i,j);
        end
    end
end
% CY.Pos=C1;
% CY.Vel=V1;