%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
%
% Données :
% DataA      : les données d'apprentissage (connues)
% LabelA     : les labels des données d'apprentissage
%
% DataT      : les données de test (on veut trouver leur label)
% Nt_test    : nombre de données tests qu'on veut labelliser
%
% K          : le K de l'algorithme des k-plus-proches-voisins
%
% Résultat :
% images_compactes_inidividus : L'ensemble des images compactes des
% resultats
% label_individus             : labels des individus resultats
%--------------------------------------------------------------------------
function [rep_compactes, label_individus] = kppv(DataA, LabelA, DataT, Nt_test, k)

[Na,~] = size(DataA);


% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test

    % Calcul des distances entre le vecteur de test 
    % et les vecteurs d'apprentissage (voisins)
    A = repmat(DataT(i,:),Na, 1);
    M = DataA - A;
    D = sqrt(sum(M.*M,2));
    
    % On ne garde que les indices des K + proches voisins
    [~, ind] = sort(D, "ascend");
    classes = LabelA(ind,:);
    data = DataA(ind, :);
    classes = classes(1 : k,:);
    data = data(1 : k, :);

    % Individus trouvé
    rep_compactes = data;
    label_individus = classes;
end