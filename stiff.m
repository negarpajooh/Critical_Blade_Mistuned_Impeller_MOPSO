function K=stiff(kb,kd,kt,Nb)
Ktun=zeros(Nb);
K(1,2)=-kb; 
K(2,1)=-kb; 
for i=1:2:Nb-1
   K(i,i)=kb; 
   K(i+1,i+1)=kb+kd+2*kt; 
end
for i=1:2:Nb-3
   K(i,i+1)=-kb; 
   K(i+1,i)=-kb;
end

for i=2:2:Nb 
    for j=4:2:Nb
        if i~=j
%             if i<j
   K(i,j)=-kt; 
%    K(i+3,i+1)=-kt;
% j=j+2;
        end
    end
    end
end