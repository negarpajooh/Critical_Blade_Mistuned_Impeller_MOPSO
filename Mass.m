function M=Mass(Nb,mb,md)
M=zeros(Nb);
for i=1:2:Nb-1
   M(i,i)=100*mb;
   M(i+1,i+1)=100*md;  
end
end