clc;
clear;
close all;
% % disp('---------------------------------------')
% % disp('0 = No Gyroscope') 
% % disp('1 = Gyroscope') 
% % disp(' ')
% % Gyroscop=input('if Gyroscope is 1 otherwise 0 = ');
% % switch  Gyroscop
% %         case 0
% % disp('Without Gyroscop');
% % wx=0;
% % wy=0;
% % wz=0;  
% %     case 1     
% % disp('With Coriolis');
% % disp(' ')
% % wx=input('plz enter wx = ');
% % wy=input('plz enter wy = ');
% % wz=input('plz enter wz = ');
% % disp('--------------------------------')
% %  end
% % disp(' ')
% % disp('Running Program')
% % disp('--------------------------------')
% % disp('---------------------------------------')
% % disp('0 = No Gyroscope') 
% % disp('1 = Gyroscope') 
% % disp(' ')
% % Gyroscop=input('if Gyroscope is 1 otherwise 0 = ');
% % switch  Gyroscop
% %         case 0
% % disp('Without Gyroscop');
% % wx=0;
% % wy=0;
% % wz=0;  
% %     case 1     
% % disp('With Coriolis');
% % disp(' ')
% % wx=input('plz enter wx = ');
% % wy=input('plz enter wy = ');
% % wz=input('plz enter wz = ');
% % disp('--------------------------------')
% %  end
% % disp(' ')
% % disp('Running Program')
% % disp('--------------------------------')
% %% Problem Definition
% global M Ktun Kmis Ctun Cmis G F0 w  Nb A ...
%        Asys Bsys u Delta Mistune Mistuned Gyroscop...
%        NFE AngularVel3 BEST MaxIt e dtMis dtTun Emis Etun...
%         FreqTun FreqMis 
% %% inputs
disp('1 = Linear Mistuning') 
disp('2 = Harmonic Mistuning') 
disp(' ')
Mistuned=input('plz enter type of Mistuning 1 or 2 = ');
switch Mistuned
    case 1
     disp('Linear Mistuning') 
     disp('Lotfan Tamas Begirid ba Mojtaba Hasanlu 09012040519')
    case 2
     disp('Harmonic Mistuning')  
     disp('Lotfan Tamas Begirid ba Mojtaba Hasanlu 09012040519')
end
% % disp('---------------------------------------')
% % disp('0 = No Gyroscope') 
% % disp('1 = Gyroscope') 
% % disp(' ')
% % Gyroscop=input('if Gyroscope is 1 otherwise 0 = ');
% % switch  Gyroscop
% %         case 0
% % disp('Without Gyroscop');
% % wx=0;
% % wy=0;
% % wz=0;  
% %     case 1     
% % disp('With Coriolis');
% % disp(' ')
% % wx=input('plz enter wx = ');
% % wy=input('plz enter wy = ');
% % wz=input('plz enter wz = ');
% % disp('--------------------------------')
% %  end
% % disp(' ')
% % disp('Running Program')
% % disp('--------------------------------')
%%
% Gyroscop=1;
% Mistuned=1;
AngularVel0=[150,0,0];
AngularVel1=[0,0,0];
AngularVel2=AngularVel0;
AngularVel3=[AngularVel1;AngularVel2];
%%
CostFunction=@(x) SheikhZenoz(x);        % Cost Function
nVar=1;             % Number of Decision Variables
VarSize=[1 nVar];   % Size of Decision Variables Matrix
VarMin=0;         % Lower Bound of Variables
VarMax=10;         % Upper Bound of Variables
%% PSO Parameters
MaxIt=5;      % Maximum Number of Iterations
nPop=100;        % Population Size (Swarm Size)
% w=1;            % Inertia Weight
% wdamp=0.99;     % Inertia Weight Damping Ratio
% c1=2;           % Personal Learning Coefficient
% c2=2;           % Global Learning Coefficient
% Constriction Coefficients
phi1=5;  %2.05
phi2=8;   %2.05
phi=phi1+phi2;
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;          % Inertia Weight
wdamp=1;        % Inertia Weight Damping Ratio
c1=chi*phi1;    % Personal Learning Coefficient
c2=chi*phi2;    % Global Learning Coefficient
% Velocity Limits
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;
%% Initialization
empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
particle=repmat(empty_particle,nPop,1);
GlobalBest.Cost=inf;
for i=1:nPop
    % Initialize Position
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    % Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    % Evaluation
    particle(i).Cost=CostFunction(particle(i).Position); 
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost; 
    % Update Global Best
    if particle(i).Best.Cost<GlobalBest.Cost 
       GlobalBest=particle(i).Best;      
    end    
end
BestCost=zeros(MaxIt,1);
nfe=zeros(MaxIt,1);
%% PSO Main Loop
for it=1:MaxIt
    for i=1:nPop
        % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        % Evaluation
        particle(i).Cost = CostFunction(particle(i).Position);
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost 
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            % Update Global Best
            if particle(i).Best.Cost<GlobalBest.Cost  
                GlobalBest=particle(i).Best;
            end
        end
    end
    %(size(GlobalBest.Cost,1),size(GlobalBest.Cost,2),it)
BEST(it).Cost=GlobalBest.Cost;
%     disp(['Iteration = ', num2str(it) , ' Best Cost = ' ,num2str(BestCost(it))]);   
    w=w*wdamp;    
end
%% Results
% figure;
% %plot(nfe,BestCost,'LineWidth',2);
% semilogy(nfe,BestCost,'LineWidth',3);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid minor
Graphs
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