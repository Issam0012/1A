clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('ishihara-0.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes

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


