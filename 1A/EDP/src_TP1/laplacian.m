function L = laplacian(nu,dx1,dx2,N1,N2)
%
%  Cette fonction construit la matrice de l'opérateur Laplacien 2D anisotrope
%
%  Inputs
%  ------
%
%  nu : nu=[nu1;nu2], coefficients de diffusivité dans les dierctions x1 et x2. 
%
%  dx1 : pas d'espace dans la direction x1.
%
%  dx2 : pas d'espace dans la direction x2.
%
%  N1 : nombre de points de grille dans la direction x1.
%
%  N2 : nombre de points de grilles dans la direction x2.
%
%  Outputs:
%  -------
%
%  L      : Matrice de l'opérateur Laplacien (dimension N1N2 x N1N2)
%
% 

% Initialisation
a=(nu(1)/(dx1^2));
b=(nu(2)/(dx2^2));
I=speye(N1*N2);
I=I*(-a);
V1=spdiags(I);
I=speye(N1*N2);
I=I*(-b);
V3=spdiags(I);
I=speye(N1*N2);
I=I*(2*(a+b));
V2=spdiags(I);

V1_=V1;
V3_=V3;
V1_(N2:N2:end)=0;
V3_(N2+1:N2:end)=0;
L=spdiags([V1,V1_,V2,V3_,V3],[-N2,-1,0,1,N2],N1*N2,N1*N2);

end    
