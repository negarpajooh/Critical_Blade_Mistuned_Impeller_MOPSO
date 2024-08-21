function C=Damp(Nb,K,M,params)
C=zeros(Nb);
zita=params.zita;
[phi,omega]=eig(K,M);
omega=sqrt(omega);
omega=omega.*omega;
phiS=conj(phi);
C=2*zita.*pinv(phiS)*omega*phi;
end