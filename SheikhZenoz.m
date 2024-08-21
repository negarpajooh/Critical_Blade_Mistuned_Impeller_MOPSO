function z=SheikhZenoz(x)
global M Ktun Kmis Ctun Cmis G F0 w  Nb A ...
       Asys Bsys u Delta Mistune Mistuned Gyroscop...
       AngularVel3 BEST MaxIt e dtMis dtTun Emis Etun...
        FreqTun FreqMis 
%% Defaults for this blog post
width = 8;     % Width in inches
height = 4;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz =16 ;      % Fontsize
lw = 1;      % LineWidth
msz = 8;       % MarkerSize
%%
% disp('1 = Linear Mistuning') 
% disp('2 = Harmonic Mistuning') 
% disp(' ')
% Mistuned=input('plz enter type of Mistuning 1 or 2 = ');
% switch Mistuned
%     case 1
%      disp('Linear Mistuning')   
%     case 2
%       disp('Harmonic Mistuning')  
% end
% disp('---------------------------------------')
% disp('0 = No Gyroscope') 
% disp('1 = Gyroscope') 
% disp(' ')
% Gyroscop=input('if Gyroscope is 1 otherwise 0 = ');
% switch  Gyroscop
%         case 0
% disp('Without Gyroscop');
% wx=0;
% wy=0;
% wz=0;  
%     case 1     
% disp('With Gyroscop');
% disp(' ')
% wx=input('plz enter wx = ');
% wy=input('plz enter wy = ');
% wz=input('plz enter wz = ');
% disp('--------------------------------')
%  end
% disp(' ')
% disp('Running Program')
% disp('--------------------------------')
%%
% Mistuned=1;
% AngularVel0=[10,0,0];
% AngularVel1=[0,0,0];
% AngularVel2=AngularVel0;
% AngularVel3=[AngularVel1;AngularVel2];
for ii=1:2
AngularVel=AngularVel3(ii,:);
% AngularVel=[wx,wy,wz];
%%
A=x;
params.zita=0.005;
r=.3;
L=0.1;
h=.001;
b=0.05;
Nb=50;
Etun=2e11;
mb=1.884;
md=22.1954;
kb=1;
kd=1;
kt=493;
Ib=(b*h^3)/12;
Id=0.25*pi*r^4;
w=3;
f0=1;
tfn=5;
intervalt=[0 tfn];
% Gtun=zeros(Nb);
%% mass
M=100.*Mass(Nb,mb,md);
%% stiffness
Ktun=stiff(kb,kd,kt,Nb);
[VectorTun,FreqTun]=eig(Ktun,M);

FreqTun=sqrt(abs(FreqTun)).*sqrt(abs(FreqTun));
%% dmaping
Ctun=Damp(Nb,Ktun,M,params);
%% Gyroscope
Gyroscop=1;
G=Gyro(AngularVel,Gyroscop,Nb);
Ctun=1.*Ctun+0.*G;
%% force
F0=Force(f0,Nb);
%% Mistuning
Delta=Mistuning(Mistuned,Nb,A);
Emis=1.*Etun.*(ones(Nb,1)+Delta);
Kmis=1.*Ktun.*(ones(Nb,1)+Delta);
%%
Asys=[zeros(Nb),eye(Nb);-Ktun*pinv(M),-(Ctun+G)*pinv(M)];
Atun=Asys;
Bsys=[zeros(Nb,1);pinv(M)*F0];
%% solve tuning
[dtTun,dzTun]=ode45('subprog',intervalt,zeros(1,2*Nb));
%%
Cmis=Damp(Nb,Kmis,M,params);
Cmis=Cmis+0.01.*G;
[VectorMis,FreqMis]=eig(Kmis,M);

FreqMis=sqrt(FreqMis).*sqrt(FreqMis);
%%
Asys=[];
Asys=[zeros(Nb),eye(Nb);-Kmis*pinv(M),-(Cmis+G)*pinv(M)];
Amis=Asys;
%% solve mistuning
[dtMis,dzMis]=ode45('subprog',intervalt,zeros(1,2*Nb));
%% input
Input=f0(1,1)*cos(w*dtTun);
%%
%% Response magnification factor
SIZE=[size(dzTun,1),size(dzMis,1)];
MIN=min(SIZE);
dzTun=dzTun(1:MIN,:);
dzTun(1,:)=[];
dzMis=dzMis(1:MIN,:);
dzMis(1,:)=[];
RMF=dzMis./dzTun;
rmf_disp=RMF(:,1:2:end-1);
rmf_vel=RMF(:,2:2:end);
%%
% for i=1:size(rmf_disp,1)
%     n1=rmf_disp(i,:);
%      nn=isnan(n1);
%      SUM=sum(nn);
%        if SUM~=0
%            rmf_disp(i,:)=[];
%            rmf_disp1=rmf_disp;
%      else
%          continue
%        end
% rmf_disp=rmf_disp1;
% end
e=abs(dzMis(:,1:2:end-1)-dzTun(:,1:2:end-1));
z=max(e);
% z=rmf_disp;
%% save data
if ii==1
save('system')
else
  save('systemG')  
  end
end
end
