close all
clear all

load SG1.mat;
load ImSG1.mat;

% figure
% subplot(1,2,1);
% hold on
% title('Partie image originale');
% imshow(Data);
% axis equal
% subplot(1,2,2);
% hold on
% DataMod_re = MCI(Data, DataMod);
% DataMod = (DataMod_re(2)-log(DataMod))/DataMod_re(1);
% title('Partie image modifiée');
% imshow(DataMod)
% axis equal

figure
subplot(1,2,1);
hold on
title('Partie image originale');
imshow(I);
axis equal
subplot(1,2,2);
hold on
I_re = MCI(I, ImMod);
ImMod = (I_re(2)-log(ImMod))/I_re(1);
title('Partie image modifiée');
imshow(ImMod)
axis equal

fprintf("L'erreur aux moindres carré est : %1.6f \n", sqrt(mse(ImMod - I)))