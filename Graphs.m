function Graphs()
clear;
clc;
close all;
global M Ktun Kmis Ctun Cmis G F0 w  Nb A ...
       Asys Bsys u Delta Mistune Mistuned Gyroscop...
       BEST MaxIt e dtMis dtTun Emis Etun ...
        FreqTun FreqMis 
%% Defaults for this blog post
width = 8;     % Width in inches
height = 4;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz =16 ;      % Fontsize
lw = 1;      % LineWidth
msz = 8;       % MarkerSize
%%
% for ii=1:2
%     if ii==1
system=load('system');
Blade=size(system.VectorTun,2);
BladeVec=1:Blade;
delta=system.Delta;
TimeTunNumber=numel(system.dtTun);
TimeMisNumber=numel(system.dtMis);
tt=[TimeTunNumber,TimeMisNumber];
TimeNumber=min(tt);
rmf_disp=system.rmf_disp;
rmf_vel=system.rmf_vel;
% nfe=system.nfe;
% BestCost=system.BestCost;
%
systemG=load('systemG'); 
Blade=size(systemG.VectorTun,2);
BladeVec=1:Blade;
delta=systemG.Delta;
TimeTunNumberG=numel(systemG.dtTun);
TimeMisNumberG=numel(systemG.dtMis);
ttG=[TimeTunNumberG,TimeMisNumberG];
TimeNumberG=min(ttG);
rmf_dispG=systemG.rmf_disp;
rmf_velG=systemG.rmf_vel;
AngularVelG=systemG.AngularVel;
% nfeG=systemG.nfe;
% BestCostG=systemG.BestCost;
%% Input
figure(1)
plot(system.dtTun,system.Input,'linewidth',2)
grid minor
xlabel('time - s')
ylabel('Amplitude - N')
title('External Disturbance')
%% disp blades
x1_tun=system.dtTun(1:TimeNumber-1).*ones(TimeNumber-1,Blade);
y1_tun=BladeVec.*ones(TimeNumber-1,Blade);
z1_tun=system.dzTun(:,1:2:end-1);
x2_mis=system.dtMis(1:TimeNumber-1).*ones(TimeNumber-1,Blade);
y2_mis=BladeVec.*ones(TimeNumber-1,Blade);
z2_mis=system.dzMis(:,1:2:end-1);
%
x1_tunG=systemG.dtTun(1:TimeNumberG-1).*ones(TimeNumberG-1,Blade);
y1_tunG=BladeVec.*ones(TimeNumberG-1,Blade);
z1_tunG=systemG.dzTun(:,1:2:end-1);
x2_misG=systemG.dtMis(1:TimeNumberG-1).*ones(TimeNumberG-1,Blade);
y2_misG=BladeVec.*ones(TimeNumberG-1,Blade);
z2_misG=systemG.dzMis(:,1:2:end-1);
figure(2)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*200]); %<- Set size
set(gca, 'FontSize', 2*fsz, 'LineWidth', 2*alw); %<- Set properties
subplot(2,2,1)
plot3(x1_tun,y1_tun,z1_tun)
grid minor
ylabel('Number of Blades')
zlabel('Displacement - m')
xlabel('time - s')
title('Tuned Blades')
subplot(2,2,2)
plot3(x2_mis,y2_mis,z2_mis)
grid minor
ylabel('Number of Blades')
zlabel('Displacement - m')
title('Mistuned Blades')
xlabel('time - s')
title('Mistuned Blades No Coriolis')
subplot(2,2,3)
plot3(x1_tunG,y1_tunG,z1_tunG)
grid minor
ylabel('Number of Blades')
zlabel('Displacement - m')
xlabel('time - s')
title('Tuned Blades with Coriolis')
% zlim([min(z1_tunG),max(z1_tunG)])
subplot(2,2,4)
plot3(x2_misG,y2_misG,z2_misG)
grid minor
ylabel('Number of Blades')
zlabel('Displacement - m')
title('Mistuned Blades')
xlabel('time - s')
title('Mistuned Blades with Coriolis')
axis auto
%% velocity blades
% velx1_tun=system.dtTun(1:TimeNumber-1).*ones(TimeNumber-1,Blade);
% vely1_tun=BladeVec.*ones(TimeNumber-1,Blade);
% velz1_tun=system.dzTun(:,2:2:end);
% velx2_mis=system.dtMis(1:TimeNumber-1).*ones(TimeNumber-1,Blade);
% vely2_mis=BladeVec.*ones(TimeNumber-1,Blade);
% velz2_mis=system.dzMis(:,2:2:end);
% %
% velx1_tunG=systemG.dtTun(1:TimeNumberG-1).*ones(TimeNumberG-1,Blade);
% vely1_tunG=BladeVec.*ones(TimeNumberG-1,Blade);
% velz1_tunG=systemG.dzTun(:,2:2:end);
% velx2_misG=systemG.dtMis(1:TimeNumberG-1).*ones(TimeNumberG-1,Blade);
% vely2_misG=BladeVec.*ones(TimeNumberG-1,Blade);
% velz2_misG=systemG.dzMis(:,2:2:end);
% %
% figure(3)
% pos = get(gcf, 'Position');
% set(gcf, 'Position', [pos(1) pos(2) width*100, height*200]); %<- Set size
% set(gca, 'FontSize', 2*fsz, 'LineWidth', 2*alw); %<- Set properties
% subplot(2,2,1)
% plot3(velx1_tun,vely1_tun,velz1_tun)
% grid minor
% ylabel('Number of Blades')
% zlabel('Velocity - m/s')
% xlabel('time - s')
% title('Tuned Blades')
% subplot(2,2,2)
% plot3(velx2_mis,vely2_mis,velz2_mis)
% grid minor
% ylabel('Number of Blades')
% zlabel('Velocity - m/s')
% xlabel('time - s')
% title('Mistuned Blade')
% % 
% subplot(2,2,3)
% plot3(velx1_tunG,vely1_tunG,velz1_tunG)
% grid minor
% ylabel('Number of Blades')
% zlabel('Velocity - m/s')
% xlabel('time - s')
% title('Tuned Blades with Coriolis')
% subplot(2,2,4)
% plot3(velx2_misG,vely2_misG,velz2_misG)
% grid minor
% ylabel('Number of Blades')
% zlabel('Velocity - m/s')
% xlabel('time - s')
% title('Mistuned Blade with Coriolis')
%% system.AngularVel
figure(4)
plot(systemG.dtTun(1:TimeNumber),systemG.AngularVel(1).*ones(1,TimeTunNumber),'b','linewidth',2)
hold on
plot(systemG.dtTun(1:TimeNumber),systemG.AngularVel(2).*ones(1,TimeTunNumber),'r','linewidth',2)
hold on
plot(systemG.dtTun(1:TimeNumber),systemG.AngularVel(3).*ones(1,TimeTunNumber),'k:','linewidth',2)
grid minor
xlabel('time - s')
ylabel('Amplitude - rad/s')
title('Angular Velocity')
legend('\omega_x','\omega_y','\omega_z','location','southeast')
ylim([-.5,max(systemG.AngularVel)+1])
%% 
figure(5)
plot(BladeVec,abs(diag(system.FreqTun)),'-s','linewidth',2)
hold on
plot(BladeVec,abs(diag(system.FreqMis)),'-o','linewidth',1)
grid minor
xlabel('Modes')
ylabel('Amplitude - Hz')
title('Frequency Response')
legend('Tuned','Mistuned', 'location','southeast')
%% Vector
figure(6)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*200]); %<- Set size
set(gca, 'FontSize', 2*fsz, 'LineWidth', 2*alw); %<- Set properties
subplot(2,2,1)
bar3(system.VectorTun)
grid minor
xlabel('Blade')
ylabel('Mode')
zlabel('Amplitude')
title('Tuned Blade Mode Shpae')
subplot(2,2,2)
bar3(system.VectorMis)
grid minor
xlabel('Blade')
ylabel('Mode')
zlabel('Amplitude')
title('Mistuned Blade Mode Shpae')
%
subplot(2,2,3)
bar3(systemG.VectorTun)
grid minor
xlabel('Blade')
ylabel('Mode')
zlabel('Amplitude')
title('Tuned Blade Mode Shpae with Coriolis')
subplot(2,2,4)
bar3(systemG.VectorMis)
grid minor
xlabel('Blade')
ylabel('Mode')
zlabel('Amplitude')
title('Mistuned Blade Mode Shpae  with Coriolis')
%% rmf_disp rmf_vel  BladeVec,
figure(7)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', 2*fsz, 'LineWidth', 2*alw); %<- Set properties
subplot(1,2,1)
rmf_x=system.dtTun(1:TimeNumber-1).*ones(TimeNumber-1,Blade);
rmf_y=BladeVec.*ones(TimeNumber-1,Blade);
rmf_z=system.rmf_disp;
plot3(rmf_x,rmf_y,rmf_z)
grid minor
xlabel('t - s')
ylabel('blade')
zlabel('amplitude')
title('RMF Tuned Blade')
subplot(1,2,2)
rmf_xG=systemG.dtTun(1:TimeNumber-1).*ones(TimeNumber-1,Blade);
rmf_yG=BladeVec.*ones(TimeNumber-1,Blade);
rmf_zG=system.rmf_disp;
plot3(rmf_xG,rmf_yG,rmf_zG)
grid minor
xlabel('t - s')
ylabel('blade')
zlabel('amplitude')
title('RMF Mistuned Blade with Coriolis')
%% optimization
for i=1:MaxIt
BEST1(i,:)=BEST(i).Cost;
end
blades=BladeVec.*ones(MaxIt,Blade);
% times=dtMis(2:end).*ones(size(e,1),size(e,2));
IT=1:MaxIt;
IT=IT'.*ones(MaxIt,size(e,2));
figure(8)
waterfall(IT,blades,BEST1);  %,IT,'LineWidth',3
xlabel('Iteration');
zlabel('Error');
ylabel('blades');
title('Optimization Process')
grid minor
%% ,'b','linewidth',2
figure(9)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*200]); %<- Set size
set(gca, 'FontSize', 2*fsz, 'LineWidth', 2*alw); %<- Set properties

subplot(2,1,1)
Nn=1:Nb;
Etun=Etun.*ones(1,Nb);
Emis=Emis.*ones(1,Nb);
plot(Nn,Etun,'sb','linewidth',2)
hold on
plot(Nn,Emis(1,:),'pr','linewidth',2)
xlabel('Blades');
ylabel('Magnitude - Pa');
title('Young Modulus')
grid minor
% ylim([0,Etun(1)+Etun(1)])
legend('Tuned','Mistuned','location','southeast')
subplot(2,1,2)
plot(Delta,'k.','linewidth',2)
xlabel('Blades');
ylabel('Magnitude');
title('Mistuning Value of Blade')
grid minor
diag(FreqTun)
abs(diag(FreqMis))
disp('Lotfan Tamas Begirid ba Mojtaba Hasanlu 09012040519')
end