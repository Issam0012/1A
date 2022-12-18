
% TP2 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : ALOUANE
% Prénom : Issam
% Groupe : 1SN-H

function varargout = fonctions_TP2_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction centrage_des_donnees (exercice_1.m) ----------------------------
function [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)
     
    %Les coordonnées du centre de gravité G sont les moyens des vecteurs
    %x_donnees et y_donnees
    x_G = mean(x_donnees_bruitees);
    y_G = mean(y_donnees_bruitees);


    %on retranche les coordonnees de G des vecteurs x et y pour avoir les
    %coordonnées centrés
    x_donnees_bruitees_centrees = x_donnees_bruitees - x_G;
    y_donnees_bruitees_centrees = y_donnees_bruitees - y_G;
   
     
end

% Fonction estimation_Dyx_MV (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
           estimation_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    %on appelle la fonction précédente
    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);


    %les psi_candidats sont des variables aléatoires sur [0,1] que l'on a multiplié par pi
    %et retranché pi/2 pour se situer dans [-pi/2, pi/2]
    psi_candidats = (rand(n_tests, 1) * pi) - (pi/2);


    %les candidats pour a sont les tangente des candidats pour psi
    a_candidats = tan(psi_candidats);


    %On calcule la fonction qu'on veut minimiser qui est le residu
    D = (y_donnees_bruitees_centrees - a_candidats * x_donnees_bruitees_centrees).^2;
    residu = sum(D, 2);


    %On prend l'indice du minimum qui va servir à trouver a et b (puisque
    %le centre de gravité appartient à la droite)
    [minimum indice_min] = min(residu);
    a_Dyx = a_candidats(indice_min);
    b_Dyx = y_G - a_Dyx * x_G;

    
end

% Fonction estimation_Dyx_MC (exercice_2.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
                   estimation_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)

    %On exprime A et B
    A = [x_donnees_bruitees; ones(1,length(x_donnees_bruitees))]';
    B = y_donnees_bruitees';

    %On exprime X
    X = (A' * A) \ (A' * B);

    %et on extrait a et b de X
    a_Dyx = X(1);
    b_Dyx = X(2);


    
end

% Fonction estimation_Dorth_MV (exercice_3.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
         estimation_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,n_tests)

    %On fait appel à la premire fonction
    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);


    %On crée une matrice theta_candidats de même que psi_candidats créée à
    %l'exercice 1
    theta_candidats = rand(n_tests,1) * pi - (pi/2);


    %On calcule les images des points par la fonction qu'on veut minimiser
    D = (x_donnees_bruitees_centrees .* cos(theta_candidats) + y_donnees_bruitees_centrees .* sin(theta_candidats)).^2;
    residu = sum(D, 2);


    %On cherche l'indice du minimum avec qui on va obtenir theta et rho on
    %la cherche pa l'équation de droite puisque le centre de gravité
    %appartient à la droite
    [minimum indice_min] = min(residu);
    theta_Dorth = theta_candidats(indice_min);
    rho_Dorth = x_G * cos(theta_Dorth) + y_G * sin(theta_Dorth);



end

% Fonction estimation_Dorth_MC (exercice_4.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
                 estimation_Dorth_MC(x_donnees_bruitees,y_donnees_bruitees)

    %On fait appel à la première fonction
    [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);
    

    %On exprime la matrice C
    C = [x_donnees_bruitees_centrees ; y_donnees_bruitees_centrees]';


    %On cherche la matrice des vecteurs propres et la matrice des valeurs
    %propres pour avoir l'indice du min des valeurs propres
    [V lambda] = eig(C' * C);
    lambda = diag(lambda);
    [lambda_p indice] = min(lambda);

    
    %On récupère Y* qui va servir à trouver theta w rho
    Y = V(:, indice);
    theta_Dorth = atan(Y(2)/Y(1));
    rho_Dorth = x_G * cos(theta_Dorth) + y_G * sin(theta_Dorth);


end
