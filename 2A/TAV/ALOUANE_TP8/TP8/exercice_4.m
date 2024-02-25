load donnees

u_bruitee = u;

% Filtrage de la texture pour réduire le bruit
texture_filtree = medfilt2(u_bruitee - u_barre);

% Reconstruction de l'image améliorée
image_amelioree = u_barre  + texture_filtree;

% Affichage de l'image améliorée
figure;
subplot(1,2,1);
imshow(uint8(u_bruitee));
title('Image bruitée','FontSize',30);

subplot(1,2,2);
imshow(uint8(image_amelioree));
title('Image améliorée','FontSize',30);