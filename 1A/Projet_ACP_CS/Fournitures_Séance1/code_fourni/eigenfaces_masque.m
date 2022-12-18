clear
clc
close all

load eigenfaces;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AVEC MASQUE
%%%%%%%%%%%%%


% Dimensions du masque
ligne_min = 200;
ligne_max = 350;
colonne_min = 60;
colonne_max = 290;

%%%%%%%% LECTURE DES DONNES ET AJOUT DU MASQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X_masque = [];

figure('Name','Personnes avec Masque','Position',[0,0,0.67*L,0.67*H]);
colormap(gray(256));

for j = 1:nb_personnes_base,
    no_posture = 0;
	for k = liste_postures_base,
        no_posture = no_posture + 1;
        
        ficF = strcat('./Data/', liste_personnes_base{j}, liste_postures{k}, '-300x400.gif')
        img = imread(ficF);
        
%         % Degradation de l'image
        img(ligne_min:ligne_max,colonne_min:colonne_max) = 0;
        % Remplissage de la matrice X_masque :
        X_masque= [X_masque; double(transpose(img(:)))];
%         
%         % Affichage
		subplot(nb_personnes_base, nb_postures_base, (j-1)*nb_postures_base + no_posture);
		imagesc(img);
		hold on;
		axis image;
		title(['Personne ' liste_personnes_base{j} ', posture ' num2str(k)]);
        
	end
end

%%%%%% REFAIRE LE CALCUL ET L'AFFICHAGE DES EIGENFACES AVEC MASQUE

% Calcul de l'individu moyen :
n = size(X_masque,1);
individu_moyenM = sum(X_masque,1)/n;

% Centrage de la matrice X :
X_centreM = X_masque - individu_moyenM;

% Calcul de la matrice de covariance (impossible a calculer ainsi a cause de sa taille) :
%Sigma = transpose(X_centre)*X_centre/n;

% Calcul de la matrice resultant du calcul commuté (voir annexe du sujet) :
Sigma2M = X_centreM*transpose(X_centreM)/n;

% Calcul des vecteurs/valeurs propres de la matrice Sigma2 :
[Vect2M, DM] = eig(Sigma2M);
Val2M = diag(DM);

% Les vecteurs propres de Sigma (les eigenfaces) se deduisent de ceux de Sigma2 :
Vect_propresM = transpose(X_centreM)*Vect2M;

% Tri par ordre decroissant des valeurs propres de Sigma_barre :
[Val2decM, IM] = sort(Val2M, 'descend');


% Tri des eigenfaces dans le meme ordre 
% (on enleve la derniere eigenface, qui appartient au noyau de Sigma) :
VectM = zeros(size(Vect_propresM));
for j = 1:n, VectM(:,j) = Vect_propresM(:,IM(j)); end
VectM = VectM(:, 1:n-1);

% Normalisation des eigenfaces :
for j = 1:n-1, VectM(:,j) = VectM(:,j) / norm(VectM(:,j)); end

% Affichage de l'individu moyen et des eigenfaces sous la forme de "pseudo-images" 
% (leurs coordonnees sont interpretees comme des niveaux de gris) :
figure('Name','Individu moyen et eigenfaces', 'Position', [0,0,0.67*L,0.67*H]);
colormap(gray(256)); 
img = reshape(individu_moyenM, nb_lignes, nb_colonnes);
subplot(nb_personnes_base, nb_postures_base, 1)
imagesc(img); 
hold on; 
axis image; 
title(['Individu moyen']);
for k = 1:n-1
	img = reshape(VectM(:,k), nb_lignes,nb_colonnes);
	subplot(nb_personnes_base, nb_postures_base,k+1);
	imagesc(img); 
	hold on; 
	axis image; 
	title(['Eigenface ', num2str(k)]);
end

save eigenfaces_masque;