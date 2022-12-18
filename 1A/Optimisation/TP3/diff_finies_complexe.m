% Auteur : J. Gergaud
% décembre 2017
% -----------------------------
% 

    
function Jac= diff_finies_complexe(fun, x, option)
%
% Cette fonction calcule les différences finies centrées sur un schéma
% Paramètres en entrées
% fun : fonction dont on cherche à calculer la matrice jacobienne
%       fonction de IR^n à valeurs dans IR^m
% x   : point où l'on veut calculer la matrice jacobienne
% option : précision du calcul de fun (ndigits)
%
% Paramètre en sortie
% Jac : Matrice jacobienne approximé par les différences finies
%        real(m,n)
% ------------------------------------
Jac=[];
for k=1:size(x,1)
    omega=max(eps,10^(-option(1)));
    h=sqrt(omega)*max(abs(x(k)),1)*sgn(x(k));
    v=zeros(length(x),1);
    v(k)=1;
    Jac(:,k)=imag(fun(x+h*v*i))/h;
end
end

function s = sgn(x)
% fonction signe qui renvoie 1 si x = 0
if x==0
  s = 1;
else 
  s = sign(x);
end
end








