function  IGD  = calculateIGD(fit,PF);
% calculate IGD metric 
% fit: popSize*M  
% PF: pfSize*M  

[popSize, M]= size(fit);
pfSize =  size(PF,1);

for i=1:pfSize
  for j=1:popSize
      D(i,j) = norm(PF(i,:)-fit(j,:),2); 
  end 
  Dmin(i,:) = min(D(i,:));  
end

IGD = sqrt(sum(Dmin.^2))/pfSize;

