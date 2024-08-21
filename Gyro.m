function G=Gyro(AngularVel,Gyroscop,Nb)
switch Gyroscop
    case 0
        G=zeros(Nb);
    case 1
omegaX=AngularVel(1);
omegaY=AngularVel(2);
omegaZ=AngularVel(3);
G1=zeros(Nb);
%% wx
j=3;
for i=2:3:Nb-3
        G1(i,j)=omegaX;
        G1(j,i)=omegaX;
j=j+3;
end
%% wy
j=3;
for i=1:3:Nb-3
        G1(i,j)=omegaY;
        G1(j,i)=omegaY;
j=j+3;
end
%% wz
j=2;
for i=1:3:Nb-3
        G1(i,j)=-omegaZ;
        G1(j,i)=-omegaZ;
j=j+3;
end
G=2*G1;
end