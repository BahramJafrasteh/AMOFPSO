% MOP: upper and low bound
% SCH FON  POL KUR
% ZDT1 ZDT2 ZDT3 ZDT4 ZDT6 
% DTLZ1  DTLZ2  DTLZ3 DTLZ4 DTLZ5 DTLZ6 
% F1 F2 F3 F4  F5 F6 F7 F8 F9
function [numObj,D,Ub,Lb]=test_function_range(fun)
% SCH
if  strcmp(fun,'SCH')
    numObj=2;   %number of objective
    D=1;  %dimension of problem
    Ub=2*ones(1,D);
    Lb=0*ones(1,D);
end

% FON
if  strcmp(fun,'FON') 
    numObj=2;   %number of objective
    D=3;  %dimension of problem
    Ub=4*ones(1,D);
    Lb=-4*ones(1,D);
end

 % POL
if  strcmp(fun,'POL')  
    numObj=2;   %number of objective
    D=2;  %dimension of problem
    Ub=pi*ones(1,D);
    Lb=-pi*ones(1,D);
end

% KUR
if  strcmp(fun,'KUR')  
    numObj=2;   %number of objective
    D=3;  %dimension of problem
    Ub=5*ones(1,D);
    Lb=-5*ones(1,D);
end

% ZDT 1
if strcmp(fun,'ZDT1') 
    numObj=2;  %number of objective
    D=30;%dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);
end

% ZDT 2
if strcmp(fun,'ZDT2')
    numObj=2;  %number of objective
    D=30;%dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);
end

% ZDT 3
if strcmp(fun,'ZDT3')
    numObj=2;  %number of objective
    D=30;%dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);
end

% ZDT 4
if strcmp(fun,'ZDT4')
    numObj=2;  %number of objective
    D=10;%dimension of problem
    Ub=[1 5*ones(1,D-1)];
    Lb=[0 -5*ones(1,D-1)];
end

% ZDT 6
if strcmp(fun,'ZDT6')
    numObj=2;  %number of objective
    D=10;%dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);
end
 
 %DTLZ1
if  strcmp(fun,'DTLZ1')    
%     numObj=input('number of objective£ºnumObj=');
    numObj=3;
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);   
end 


 %DTLZ2
if  strcmp(fun,'DTLZ2') 
  %     numObj=input('number of objective£ºnumObj=');
    numObj=3;
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D); 
end 

 %DTLZ3
if  strcmp(fun,'DTLZ3') 
    %     numObj=input('number of objective£ºnumObj=');
    numObj=3; 
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);   
end 

 %DTLZ4
if  strcmp(fun,'DTLZ4') 
    %     numObj=input('number of objective£ºnumObj=');
    numObj=3; 
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);     
end 
  
  %DTLZ5
if  strcmp(fun,'DTLZ5') 
    numObj=3;   %number of objective
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);    
end

  %DTLZ6
if  strcmp(fun,'DTLZ6') 
    numObj=3;   %number of objective
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);  
end

%DTLZ7
if  strcmp(fun,'DTLZ7') 
    numObj=3;   %number of objective
    D=20;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);  
end
 
% F1
if  strcmp(fun,'F1') 
    numObj=2;   %number of objective
    D=30;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);  
end

% F2
if  strcmp(fun,'F2') 
    numObj=2;   %number of objective
    D=30;  %dimension of problem
    Ub=[1 1*ones(1,D-1)];
    Lb=[0 -1*ones(1,D-1)];  
end

% F3
if  strcmp(fun,'F3') 
    numObj=2;   %number of objective
    D=30;  %dimension of problem
    Ub=[1 1*ones(1,D-1)];
    Lb=[0 -1*ones(1,D-1)];  
end

% F4
if  strcmp(fun,'F4') 
    numObj=2;   %number of objective
    D=30;  %dimension of problem
    Ub=[1 1*ones(1,D-1)];
    Lb=[0 -1*ones(1,D-1)];  
end

% F5
if  strcmp(fun,'F5') 
    numObj=2;   %number of objective
    D=30;  %dimension of problem
    Ub=[1 1*ones(1,D-1)];
    Lb=[0 -1*ones(1,D-1)];  
end

% F6
if  strcmp(fun,'F6') 
    numObj=3;   %number of objective
    D=10;  %dimension of problem
    Ub=[1 1 1*ones(1,D-2)];
    Lb=[0 0 -1*ones(1,D-2)];  
end

% F7
if  strcmp(fun,'F7') 
    numObj=2;   %number of objective
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);  
end

% F8
if  strcmp(fun,'F8') 
    numObj=2;   %number of objective
    D=10;  %dimension of problem
    Ub=1*ones(1,D);
    Lb=0*ones(1,D);  
end

% F9
if  strcmp(fun,'F9') 
    numObj=2;   %number of objective
    D=30;  %dimension of problem
    Ub=[1  1*ones(1,D-1)];
    Lb=[0 -1*ones(1,D-1)];  
end