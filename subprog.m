function dz=subprog(t,z)
global  Asys Bsys w
% A3=10e4*[0 0 0.0001 0
%     0 0 0 0.0001
%     -3.8213 0 -0.0004 0
%     0 -0.0839 0 0];
% B3=[0;0;0.0375;-0.0198];
% E3=10e3*[0;0;2.6924;-0.7842];
% B4=[B3,E3];
% u(t) & r(t) assume sine input
% tfn=3;
u=cos(w*t);
% r=1.5*sin(2*pi*3*t);
% step
% UnitStep=@(t) double(t>=0);
% u1=UnitStep(t);
% r=UnitStep(t);
% impulse
% u1=[zeros(1,tfn),1,zeros(1,tfn)]
% r=[zeros(1,tfn),1,zeros(1,tfn)]
% exponentially
% a=1;
% u1=a.*exp(t);
% r=a.*exp(t);
% u=[u1;r];
dz=Asys*z+Bsys*u;
end