%--------------------------------------------------------------------------
% La classification bayésienne en supposant que les classes sont
% équiprobables
%
% Données :
%
% dataA  :  La matrice des classes
% dataT  :  les données à tester
%
% Résultat :
% 
% w  : La classe à laquelle appartient x
%
%--------------------------------------------------------------------------
function [w] = bayesien(dataA, dataT, label)

n = size(dataA);
P = zeros(1,n(1));

for i=1:n(1)

    [mu, sigma] = estimation_mu_Sigma(dataA(i,:)');
    P(i) = gaussienne(dataT, mu, sigma);

end

[~, indice] = max(P);

w = label(indice,:);

end