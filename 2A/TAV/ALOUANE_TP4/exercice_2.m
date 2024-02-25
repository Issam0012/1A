clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);


% Parametres :
N = 100;					% Nombre de disques d'une configuration
R = 7;					% Rayon des disques
nb_points_affichage_disque = 30;
increment_angulaire = 2*pi/nb_points_affichage_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
q_max = 50000;
nb_affichages = 1000;
pas_entre_affichages = floor(q_max/nb_affichages);
temps_pause = 0.0001;
beta = 1;
S = 140;
gamma = 5;
T0 = 0.1;
lambda0 = 100;
alpha = 0.99;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2ycbcr(I);
I = double(I(:,:,1));
[nb_lignes,nb_colonnes] = size(I);
figure('Name',['Detection de ' num2str(N) ' flamants roses'],'Position',[0,0,L,0.58*H]);

% Tirage aleatoire d'une configuration initiale et calcul des niveaux de gris moyens :
c = zeros(N,2);
I_moyen = zeros(N,1);
seuil = 2 * R * R;
for i = 1:N
    c_i = [nb_colonnes*rand nb_lignes*rand];
    distance = (c(:,1) - c_i(1)).^2 + (c(:,2)-c_i(2)).^2;
    inegalites = find(distance < seuil);
    while ~isempty(inegalites)
	    c_i = [nb_colonnes*rand nb_lignes*rand];
        distance = (c(:,1) - c_i(1)).^2 + (c(:,2)-c_i(2)).^2;
        inegalites = find(distance < seuil);
    end
	c(i,:) = c_i;
	I_moyen(i) = calcul_I_moyen(I,c_i,R);
end
liste_q = 0;
liste_Uc = 0;

% Affichage de la configuration initiale :
subplot(1,2,1);
imagesc(I);
axis image;
axis off;
colormap gray;
hold on;
for i = 1:N
	x_affich = c(i,1)+R*cos(theta);
	y_affich = c(i,2)+R*sin(theta);
	indices = find(x_affich>0 & x_affich<nb_colonnes & y_affich>0 & y_affich<nb_lignes);
	plot(x_affich(indices),y_affich(indices),'Color',rose,'LineWidth',3);
end
pause(temps_pause);

% Courbe d'evolution du niveau de gris moyen :
subplot(1,2,2);
plot(liste_q,liste_Uc,'.','Color',rose);
axis([0 q_max -400 0]);
set(gca,'FontSize',20);
xlabel('Nombre d''iterations','FontSize',20);
ylabel('Niveau de gris moyen','FontSize',20);

q_max = 200;
lambda = lambda0;
T = T0;
c_prev = c;
for q=1:q_max
    N2 = poissrnd(lambda);   % Génération de N suivant une loi de poisson de paramètre lambda
    config = [c_prev ; zeros(N2,2)];  % On initialise la nouvelle configuration à partir de la configuration précédente
    % On initialise les nouveaux centres
    for i = 1:N2
        c_alea = [nb_colonnes*rand nb_lignes*rand];
        distance = (config(:,1) - c_alea(1)).^2 + (config(:,2)-c_alea(2)).^2;
        inegalites = find(distance < seuil);
        while ~isempty(inegalites)
	        c_alea = [nb_colonnes*rand nb_lignes*rand];
            distance = (config(:,1) - c_alea(1)).^2 + (config(:,2)-c_alea(2)).^2;
            inegalites = find(distance < seuil);
        end
        config(N+i,:) = c_alea;
    end
    % On calcule I pour chaque centre
    l = length(config);
    I_barre = zeros(1,l);
    for i = 1:l
        I_barre(i) = calcul_I_moyen(I, config(i,:), R);
    end

    % On calcules les énergies et on les tri par ordre décroissant
    Ui = 1-2./(1+exp(-gamma*((I_barre/S)-1)));
    [U_decroissant, decroissant] = sort(Ui, 'descend');
    config = config(decroissant,:);
    j = 1;  % L'indice de centre actuelle
    for i = 1:length(decroissant)

        % On calcule U(c)
        delta = 0;
        for m=1:length(config)
            for n=1:m-1
                if ((config(m,1) - config(n,1))^2 + (config(m,2) - config(n,2))^2) < seuil
                    delta = delta + 1;
                end
            end
        end
        Uc = sum(U_decroissant) + beta * delta;

        % On calcule U(c-{ci})
        U_ci = horzcat(U_decroissant(1:j-1), U_decroissant(j+1:end));
        config_ci = [config(1:j-1,:); config(j+1:end,:)];
        delta = 0;
        for m=1:length(config_ci)
            for n=1:m-1
                if ((config_ci(m,1) - config_ci(n,1))^2 + (config_ci(m,2) - config_ci(n,2))^2) < seuil
                    delta = delta + 1;
                end
            end
        end
        Uc_ci = sum(U_ci) + beta * delta;
    
        % On calcule p
        p = lambda/(lambda + exp((Uc_ci-Uc)/T));
        
        % On enlève le centre avec une probabilité p et on passe à
        % l'élément suivant sinon
        if (rand() < p)
            config = config_ci;
            U_decroissant = U_ci;
        else
            j = j + 1;
        end
    end
    
    % Si on veut utiliser le test de convergence
    %if (length(config)==length(c_prev))
    %    convergence = sum(sum(c_prev==config))==0;
    %end
    
    % Mise à jour des paramètres
    T = alpha * T;
    lambda = lambda * alpha;
    c_prev = config;
    liste_q = [liste_q q];
    liste_Uc = [liste_Uc Uc];
    
end

subplot(1,2,2);
plot(liste_q,liste_Uc,'.-','Color',rose,'LineWidth',3);
axis([0 q_max -400 0]);
set(gca,'FontSize',20);
xlabel('Nombre d''iterations','FontSize',20);
ylabel('Énergie de la configuration','FontSize',20);