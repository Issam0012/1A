%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
%
% Données :
%
% X : La classe wi
%
% Résultat :
% 
% mu : la matrice moyen
% sigma : la matrice de covariance
%
%--------------------------------------------------------------------------

function [mu, sigma] = estimation_mu_Sigma(X)

mu = X'*ones(length(X),1)/length(X);

Xc = X - mu;

sigma = Xc'*Xc/length(Xc);

end
