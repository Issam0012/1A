
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : ALOUANE
% Prenom : Issam
% Groupe : 1SN-H

function varargout = fonctions_TP3_stat(varargin)

    [varargout{1},varargout{2}] = feval(varargin{1},varargin{2:end});

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)

    % La matrice A
    A = [cos(theta), sin(theta)];

    % La mtrice X qui contient x_F et y_F
    X = A\rho;
    x_F = X(1);
    y_F = X(2);

    % Calcul du rho_F et theta_F par les relations entre les coordonnées
    % cartésiennes et polaires
    rho_F = sqrt(x_F^2 + y_F^2);
    theta_F = atan2(y_F, x_F);


    % L'écart moyen utilisé à l'exercice 2
    ecart_moyen = (1/length(rho) * sum(abs(rho - rho_F * cos(theta-theta_F))));

end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres)


    ecart_min = Inf;

    % La boucle qui va réaliser l'algorithme
    for i = 1:parametres(3) 
        % Le tirage aléatoire des indices des deux points
        indice_pts = randperm(length(rho),2);

        % Estimation_F sur les rho et theta de ces deux indices
        rho_test = rho(indice_pts);
        theta_test = theta(indice_pts);
        [rho_F,theta_F,ecart_moyen] = estimation_F(rho_test,theta_test);

        % Détermination des données conformes
        Seuil = abs(rho - rho_F * cos(theta - theta_F)) ;
        rho_conformes = rho(Seuil <= parametres(1));
        theta_conformes = theta(Seuil <= parametres(1));

        if length(rho_conformes)/length(rho) >= parametres(2)                             %Si le pourcentage et supérieur à S2
            [rho_F,theta_F,ecart_moyen] = estimation_F(rho_conformes,theta_conformes);    % Estimation de F sur les donnees conformes
            if ecart_moyen < ecart_min                                                    % Mise à jour des données quand ecart_moyen < ecart_min
                ecart_min = ecart_moyen;
                rho_F_estime = rho_F;
                theta_F_estime = theta_F;
            end
        end
    end


end

% Fonction G_et_R_moyen (exercice_3.m, bonus, fonction du TP1) ------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)



end

% Fonction estimation_C_et_R (exercice_3.m, bonus, fonction du TP1) -------
function [C_estime,R_estime,critere] = ...
         estimation_C_et_R(x_donnees_bruitees,y_donnees_bruitees,n_tests,C_tests,R_tests)
     
    % Attention : par rapport au TP1, le tirage des C_tests et R_tests est 
    %             considere comme etant deje effectue 
    %             (il doit etre fait au debut de la fonction RANSAC_3)



end

% Fonction RANSAC_3 (exercice_3, bonus) -----------------------------------
function [C_estime,R_estime] = ...
         RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres)
     
    % Attention : il faut faire les tirages de C_tests et R_tests ici



end
