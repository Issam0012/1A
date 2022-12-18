
% TP1 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Alouane
% Prénom : Issam
% Groupe : 1SN-H

function varargout = fonctions_TP1_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction G_et_R_moyen (exercice_1.m) ----------------------------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)

     Gx = mean(x_donnees_bruitees);        %Gx est le moyen des x
     Gy = mean(y_donnees_bruitees);        %Gy est le moyen des y
     G= [Gx Gy];

     distances = sqrt((x_donnees_bruitees-Gx).^2 + (y_donnees_bruitees-Gy).^2);     %distances est la matrice des rayons

     R_moyen = mean(distances);       %le rayon moyen est le moyen de distances
     
end

% Fonction estimation_C_uniforme (exercice_1.m) ---------------------------
function [C_estime, R_moyen] = ...
         estimation_C_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);

    C_candidats = [rand(n_tests,1)*2*R_moyen+(G(1)-R_moyen) rand(n_tests,1)*2*R_moyen+(G(2)-R_moyen)];     %matrice aléatoire des centres candidats

    Dx = (x_donnees_bruitees-C_candidats(:,1)).^2;

    Dy = (y_donnees_bruitees-C_candidats(:,2)).^2;

    D = (sqrt(Dx + Dy)-R_moyen).^2;    %D est une matrice qui contient le rayon pour chaque centre candidat (les composantes de ce rayon sont Dx et Dy) 
                                         % moins le rayon moyen au carré
  
    residu = sum(D,2);      %residu est une matrice colonne qui contient la somme des lignes de D 

    [centre indice_centre] = min(residu);   %on récupére l'indice du minimum de residu

    C_estime = C_candidats(indice_centre,:);   %et enfin le centre estimé est celui qui se trouve dans cet indice là

end

% Fonction estimation_C_et_R_uniforme (exercice_2.m) ----------------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_uniforme(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);

    C_candidats = [rand(n_tests,1)*2*R_moyen+(G(1)-R_moyen) rand(n_tests,1)*2*R_moyen+(G(2)-R_moyen)];     %matrice aléatoire des centres candidats

    R_candidats = rand(n_tests,1)*R_moyen;      %matrice aléatoire des rayons candidats

    Dx = (x_donnees_bruitees-C_candidats(:,1)).^2;

    Dy = (y_donnees_bruitees-C_candidats(:,2)).^2;

    D = (sqrt(Dx + Dy)-R_candidats).^2;      %D est une matrice qui contient le rayon pour chaque centre candidat (les composantes de ce rayon sont Dx et Dy) 
                                         % moins le rayon moyen au carré
  
    residu = sum(D,2);         %residu est une matrice colonne qui contient la somme des lignes de D 

    [D_centre indice_min] = min(residu);    %on récupére l'indice du minimum de residu

    C_estime = [C_candidats(indice_min,1) C_candidats(indice_min,2)];    %et enfin le centre estimé et le rayon estimé sont ceux qui se trouvent dans cet indice là

    R_estime = R_candidats(indice_min);


end

% Fonction occultation_donnees (donnees_occultees.m) ----------------------
function [x_donnees_bruitees, y_donnees_bruitees] = ...
         occultation_donnees(x_donnees_bruitees, y_donnees_bruitees, theta_donnees_bruitees)
    
    
    theta_1 = rand * 2 * pi;   %les deux variables aléatoires  theta_1 et theta_2
    theta_2 = rand * 2 * pi;
    if theta_1 <= theta_2 
        indice_sup = find (theta_donnees_bruitees > theta_1);    %on cherche les indices des éléments qui vérifie les deux conditions
        indice_inf = find (theta_donnees_bruitees < theta_2);
        indice_theta = intersect (indice_inf, indice_sup);       %on prend l'inntersection des deux matrices qui vérifie les deux conditions
        x_donnees_bruitees = x_donnees_bruitees (indice_theta);  % que l'on va utiliser pour arriver à notre but
        y_donnees_bruitees = y_donnees_bruitees (indice_theta);
    else
        indice_sup_2 = find (theta_donnees_bruitees > 0);         %on cherche les indices des éléments qui vérifie les deux conditions
        indice_inf_2 = find (theta_donnees_bruitees < theta_2);
        indice_theta_2 = intersect (indice_inf_2, indice_sup_2);  %on prend l'inntersection des deux matrices qui vérifie les deux conditions
        indice_sup_1 = find (theta_donnees_bruitees > theta_1);   %aussi on cherche les indices des éléments qui vérifie les deux conditions
        indice_inf_1 = find (theta_donnees_bruitees < 2 * pi);
        indice_theta_1 = intersect (indice_inf_1, indice_sup_1);  %et aussi on prend l'inntersection des deux matrices qui vérifie les deux conditions
        indice_theta = [indice_theta_2, indice_theta_1];          %On concaténe les deux matrices pourrrrr trouver les indices qui vérifie les nos conditions
        x_donnees_bruitees = x_donnees_bruitees (indice_theta);   %que l'on va utiliser pour arriver à nnotre but
        y_donnees_bruitees = y_donnees_bruitees (indice_theta);
    end

end

% Fonction estimation_C_et_R_normale (exercice_4.m, bonus) ----------------
function [C_estime, R_estime] = ...
         estimation_C_et_R_normale(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    [G, R_moyen, distances] = G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees);  %la même procédure que exercice 2 juste on remplace rand par randn

    C_candidats = [randn(n_tests,1)*2*R_moyen+(G(1)-R_moyen) randn(n_tests,1)*2*R_moyen+(G(2)-R_moyen)];

    R_candidats = randn(n_tests,1)*R_moyen;

    Dx = (x_donnees_bruitees-C_candidats(:,1)).^2;

    Dy = (y_donnees_bruitees-C_candidats(:,2)).^2;

    D = (sqrt(Dx + Dy)-R_candidats).^2;
  
    residu = sum(D,2);

    [D_centre indice_min] = min(residu);

    C_estime = [C_candidats(indice_min,1) C_candidats(indice_min,2)];

    R_estime = R_candidats(indice_min);


end
