%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP1 - Espace de représentation des couleurs
% Exercice_1.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Décomposition des canaux RVB d'une image couleur

%I = imread('autumn.tif');          % 1er exemple
I = imread('gantrycrane.png');     % 2nd exemple
%I = imread('pears.png');           % 3ième exemple (dernier exercice)
%I = imread('coloredChips.png');    % 4ième exemple (dernier exercice)

% Découpage de l'image en trois canaux et conversion en flottants
R = single(I(:,:,1));
V = single(I(:,:,2));
B = single(I(:,:,3));

%% Affichage de l'image RVB et de ses canaux

% 1ère fenêtre d'affichage
figure('Name','Separation des canaux RVB',...
       'Position',[0.01*L,0.1*H,0.59*L,0.75*H])

% Affichage de l'image RVB
    subplot(2,2,1)	% La fenêtre comporte 2 lignes et 2 colonnes
    imagesc(I)
    axis off image
    title('Image RVB','FontSize',20)
    
colormap gray % Pour afficher les images en niveaux de gris
              % Affichage avec la palette 'parula' par défaut sinon
    
% Affichage du canal R
    subplot(2,2,2) % 1ère ligne, 2ème colonne
    imagesc(R)
    axis off image
    title('Canal R','FontSize',20)
    
% Affichage du canal V
    subplot(2,2,3) % 2ème ligne, 1ère colonne
    imagesc(V)
    axis off image
    title('Canal V','FontSize',20)
    
% Affichage du canal B
    subplot(2,2,4) % 2ème ligne, 2ème colonne
    imagesc(B)
    axis off image
    title('Canal B','FontSize',20)
    
% Enregistrement des images des canaux
imwrite(uint8(R),'canal_R.png')
imwrite(uint8(V),'canal_V.png')
imwrite(uint8(B),'canal_B.png')

%% Affichage du nuage de pixels dans le repère RVB

% % Deuxième fenêtre d'affichage
% figure('Name','Nuage de pixels dans le repere RVB',...
%        'Position',[0.61*L,0.1*H,0.38*L,0.6*H])
% 
%     plot3(R,V,B,'b.')
%     axis equal
%     grid on
%     xlabel('R','FontWeight','bold')
%     ylabel('V','FontWeight','bold')
%     zlabel('B','FontWeight','bold')
%     title({'Représentation 3D des pixels' ...
%            'dans l''espace RVB'},'FontSize',20)
%     rotate3d 

%% Calcul des corrélations entre les canaux RVB et des contrastes
    
% Matrice des données
X = [R(:) V(:) B(:)];	% Les trois canaux sont vectorisés et concaténés

% Matrice de variance/covariance
Sigma = zeros(3,3);
R_barre = mean(R(:));
V_barre = mean(V(:));
B_barre = mean(B(:));

Sigma(1,1) = 1/3 * sum (( R(:) - R_barre ).^2);
Sigma(2,2) = 1/3 * sum ((V(:) - V_barre).^2);
Sigma(3,3) = 1/3 * sum ((B(:) - B_barre).^2);
Sigma(1,2) = 1/3 * sum ( (R(:) - R_barre) .* ( V(:) - V_barre ) );
Sigma(2,1) = Sigma(1,2);
Sigma(1,3) = 1/3 * sum ( (R(:) - R_barre) .* ( B(:) - B_barre ) );
Sigma(3,1) = Sigma(1,3);
Sigma(2,3) = 1/3 * sum ( (V(:) - V_barre) .* ( B(:) - B_barre ) );
Sigma(3,2) = Sigma(2,3);

% Coefficients de corrélation linéaire
Sigma_RV = Sigma(1,2); Sigma_RB = Sigma(1,3); Sigma_VB = Sigma(2,3);
Ecart_Type_R=sqrt(Sigma(1,1)); Ecart_Type_V = sqrt(Sigma(2,2)); Ecart_Type_B = sqrt(Sigma(3,3));

r_RV = Sigma_RV/(Ecart_Type_R*Ecart_Type_V);
r_RB = Sigma_RB/(Ecart_Type_R*Ecart_Type_B);
r_VB = Sigma_VB/(Ecart_Type_V*Ecart_Type_B);

% Proportions de contraste
c_R = Ecart_Type_R^2 / (Ecart_Type_B^2 + Ecart_Type_R^2 + Ecart_Type_V^2);
c_V = Ecart_Type_V^2 / (Ecart_Type_B^2 + Ecart_Type_R^2 + Ecart_Type_V^2);
c_B = Ecart_Type_B^2 / (Ecart_Type_B^2 + Ecart_Type_R^2 + Ecart_Type_V^2);

%% Exercice 2 - Analyse en Composantes Principales
[W,D] = eig(Sigma);
diag_D = diag(D);
[diag_D_triee, indices] = sort(diag_D,'descend');
W_triee = W(:, indices);

C_1 = X*W_triee(:,1);
C_2 = X*W_triee(:,2);
C_3 = X*W_triee(:,3);

C=[C_1, C_2, C_3];

C1_barre = mean(C(:,1));
C2_barre = mean(C(:,2));
C3_barre = mean(C(:,3));

Sigma_C(1,1) = 1/3 * sum (( C(:,1) - C1_barre ).^2);
Sigma_C(2,2) = 1/3 * sum ((C(:,2) - C2_barre).^2);
Sigma_C(3,3) = 1/3 * sum ((C(:,3) - C3_barre).^2);
Sigma_C(1,2) = 1/3 * sum ( (C(:,1) - C1_barre) .* ( C(:,2) - C2_barre ) );
Sigma_C(2,1) = Sigma_C(1,2);
Sigma_C(1,3) = 1/3 * sum ( (C(:,1) - C1_barre) .* ( C(:,3) - C3_barre ) );
Sigma_C(3,1) = Sigma_C(1,3);
Sigma_C(2,3) = 1/3 * sum ( (C(:,2) - C2_barre) .* ( C(:,3) - C3_barre ) );
Sigma_C(3,2) = Sigma_C(2,3);

% Coefficients de corrélation linéaire
Sigma_C1C2 = Sigma_C(1,2); Sigma_C1C3 = Sigma_C(1,3); Sigma_C2C3 = Sigma_C(2,3);
Ecart_Type_C1=sqrt(Sigma_C(1,1)); Ecart_Type_C2 = sqrt(Sigma_C(2,2)); Ecart_Type_C3 = sqrt(Sigma_C(3,3));

r_C1C2 = Sigma_C1C2/(Ecart_Type_C1*Ecart_Type_C2);
r_C1C3 = Sigma_C1C3/(Ecart_Type_C1*Ecart_Type_C3);
r_C2C3 = Sigma_C2C3/(Ecart_Type_C2*Ecart_Type_C3);

% Proportions de contraste
c_C1 = Ecart_Type_C1^2 / (Ecart_Type_C3^2 + Ecart_Type_C1^2 + Ecart_Type_C2^2);
c_C2 = Ecart_Type_C2^2 / (Ecart_Type_C3^2 + Ecart_Type_C1^2 + Ecart_Type_C2^2);
c_C3 = Ecart_Type_C3^2 / (Ecart_Type_C3^2 + Ecart_Type_C1^2 + Ecart_Type_C2^2);