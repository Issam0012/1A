clear
clc
close all


%%%%%%%% CHOIX DES DONNEES
%%%%%%%%%%%%%%%%%%%%%%%%%%

% liste des differentes personnes
liste_personnes = {
 'f01', 'f02', 'f03', 'f04', 'f05', 'f06', 'f07', 'f08', 'f09', 'f10', 'f11', 'f12', 'f13', 'f14', 'f15', 'f16', 'm01', 'm02', 'm03', 'm04', 'm05', 'm06', 'm07', 'm08', 'm09', 'm10', 'm11', 'm12', 'm13', 'm14', 'm15', 'm16'
                   };
nb_personnes = length(liste_personnes);

% liste des differentes postures 
liste_postures = {'v1e1','v3e1','v1e2','v3e2','v1e3','v3e3'};
nb_postures = length(liste_postures);

nb_lignes = 400;
nb_colonnes = 300;

% personnes constituant la base d'apprentissage (A FAIRE EVOLUER)
liste_personnes_base = {'f01', 'f10', 'm01', 'm08'};
%       personnes          1     10     17     24     
%liste_personnes_base = {'f01', 'f10', 'm10', 'm08'} clusters mieux séparés
nb_personnes_base = length(liste_personnes_base); 

% postures de la base d'apprentissage (A FAIRE EVOLUER)
liste_postures_base = [1 2 3 4];
nb_postures_base = length(liste_postures_base);

%%%%%%%% LECTURE DES DONNES SANS MASQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = [];
liste_base = [];

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Personnes','Position',[0,0,0.67*L,0.67*H]);
colormap(gray(256));

% Affichage des images sous forme de planche-contact 
% (une personne par ligne, une posture par colonne) :
for j = 1:nb_personnes_base
    no_posture = 0;
	for k = liste_postures_base
        no_posture = no_posture + 1;
        
        ficF = strcat('./Data/', liste_personnes_base{j}, liste_postures{k}, '-300x400.gif');
        liste_base = [liste_base ; ficF];
        img = imread(ficF);
        % Remplissage de la matrice X :
        X = [X ; double(transpose(img(:)))];
        
        % Affichage
		subplot(nb_personnes_base, nb_postures_base, (j-1)*nb_postures_base + no_posture);
		imagesc(img);
		hold on;
		axis image;
		title(['Personne ' liste_personnes_base{j} ', posture ' num2str(k)]);
        
	end
end

%%%%%%%% CALCUL ET AFFICHAGE DES EIGENFACES SANS MASQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calcul de l'individu moyen :
n = size(X,1);
individu_moyen = sum(X,1)/n;

% Centrage de la matrice X :
X_centre = X - individu_moyen;

% Calcul de la matrice de covariance (impossible a calculer ainsi a cause de sa taille) :
%Sigma = transpose(X_centre)*X_centre/n;

% Calcul de la matrice resultant du calcul commuté (voir annexe du sujet) :
Sigma2 = (X_centre*X_centre')/n;

% Calcul des vecteurs/valeurs propres de la matrice Sigma2 :
[Vect2, D] = eig(Sigma2);
Val2 = diag(D);

% Les vecteurs propres de Sigma (les eigenfaces) se deduisent de ceux de Sigma2 :
Vect_propres = X_centre'*Vect2;

% Tri par ordre decroissant des valeurs propres de Sigma_barre :
[Val2dec, I] = sort(Val2, 'descend');


% Tri des eigenfaces dans le meme ordre 
% (on enleve la derniere eigenface, qui appartient au noyau de Sigma) :
Vect = zeros(size(Vect_propres));
for j = 1:n, Vect(:,j) = Vect_propres(:,I(j)); end
Vect = Vect(:, 1:n-1);

% Normalisation des eigenfaces :
for j = 1:n-1, Vect(:,j) = Vect(:,j) / norm(Vect(:,j)); end

% Affichage de l'individu moyen et des eigenfaces sous la forme de "pseudo-images" 
% (leurs coordonnees sont interpretees comme des niveaux de gris) :
figure('Name','Individu moyen et eigenfaces', 'Position', [0,0,0.67*L,0.67*H]);
colormap(gray(256)); 
img = reshape(individu_moyen, nb_lignes, nb_colonnes);
subplot(nb_personnes_base, nb_postures_base, 1)
imagesc(img); 
hold on; 
axis image; 
title(['Individu moyen']);
for k = 1:n-1
	img = reshape(Vect(:,k), nb_lignes,nb_colonnes);
	subplot(nb_personnes_base, nb_postures_base,k+1);
	imagesc(img); 
	hold on; 
	axis image; 
	title(['Eigenface ', num2str(k)]);
end

save eigenfaces;
