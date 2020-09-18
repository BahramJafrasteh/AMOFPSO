function dom=Dominate(x,y)
%  x donimate y£¬  return 1
%  x is not dominated by y£¬ return 0
    dom=all(x<=y) & any(x<y);
end