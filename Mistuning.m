function Delta=Mistuning(Mistuned,Nb,A)
h=1;
N=Nb;
%% Mistuned
switch Mistuned
    case 1
%% Linear Intentional mistuning of blade 
for i=1:Nb
d1=(2*(i-1))/(N-1);
d1=d1-1;
Delta(i)=A*d1;  
end
    case 2
%% Harmonic Intentional mistuning of blade
for i=1:Nb
 d2=(2*pi*h*(i-1))/N;
 d2=cos(d2);
 Delta(i)=A*d2;
end
end
end