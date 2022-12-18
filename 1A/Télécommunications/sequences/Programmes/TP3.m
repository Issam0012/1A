%TP3 telecomm
clear; 
close all;
clc;

%Sequence 3 sur l'étude de l'impact du bruit, filtrage adadpté, taux d'erreur
% efficacité en puissance.
% Issam ALOUANE & Germain BESSON groupe H.

%% Données  pour la partie 3 %%
Fe = 24000; % Frequence d'echantillonnage
Te = 1/Fe;
Rb = 3000; 
%n_fft = 1024;
Ns = Fe/Rb;
M1=2;      %Nombre de symbobole possible lorsdu mapping 2-aire(partie 1&2)
M2=4;      %Nombre de symbole possible lors du mapping 4-aire ( partie 3)

nb_bits =  10000; %Nombre de bits générer
Ts = log2(M1)/Rb; 
EbNo= (0:1:8); %  Différentes valeur du rapport Eb/N0

% Gérération de l'information binairealéatoirement
bits = randi ([0, 1], 1, nb_bits);

%% PArtie 1 Chaine de référence avec filtre h=hr rectangulaire %%

% Génération de la réponse impulsionnelle du modulateur 
h = ones (1, Ns);

% Génération de la réponse impulsionnelle du démodulateur 
hr = h;

% Mapping binaire à moyenne nulle : 0 -> -1, 1 -> +1 :
bits_map = bits * 2 - 1;

% Génération des impulsions :
Impulsions1 = [kron(bits_map, [1 zeros(1, Ns-1)])];

% La modulation et démodulation
signalModule = filter(h, 1, Impulsions1);

%Ajout du bruit,filtrage,calcul du TEB
Puissance= mean(abs(signalModule).^2); % Puissance du signal à bruiter
TEB=zeros(1,9);                        % Tableau des TEB simulé 
TEB_Theo = zeros(1,9);                 % Tableau des TEB théorique 

for i=1:length(EbNo)
    sigma = (Puissance*Ns)./(2*log2(M1).*10^(EbNo(i)/10));  %sigma carré

    %génération du bruit
    bruit = sqrt(sigma)*randn(1,length(signalModule)); 

    %ajout du bruit 
    SignalModuleBruit= signalModule + bruit;
    
    %filtre en reception du signa bruité
    signalDemodule = filter(hr, 1, SignalModuleBruit);
    
    %echantillonage du signal reçu avec n0 optimal
    n0=Ns;
    decision = signalDemodule(n0: Ns :length(signalDemodule));
    
    % Calcul du TEB simulé et théorique 
    TEB(i) = sum((decision>0)~=bits)/length(decision);
    TEB_Theo(i)=qfunc(sqrt(2*10^(EbNo(i)/10)));
 
    
end

%Tracé du TEB pratique et théorique en fonction du rapport Eb/N0

figure, semilogy(EbNo, TEB);
hold on
semilogy(EbNo, TEB_Theo);
legend('TEB pratique', 'TEB théorique');
title("Comparaison du taux d'erreur binaire pratique et " + ...
    "théorique  en fonction du rapport signal à bruit")
xlabel("Eb/N0 (Db)")
ylabel("TEB")


% Tracé du diagramme de l'oeil en sortie du filtre de réception
figure, plot(reshape(signalDemodule,Ns,length(signalDemodule)/Ns));
title("Le diagramme de l'oeil en sortie du filtre de réception sans canal");



%% PARTIE 2   avec h inchangé et hr signal rectangualaire sur [0,Ts/2] 0 ailleurs 

% 2.1 ) SANS BRUIT

% modification de hr
hr = [ones(1,Ns/2),zeros(1,Ns/2)];

% filtrage du signal 
signalModule = filter(h, 1, Impulsions1);
signalDemodule = filter(hr, 1, signalModule);

% Tracé du diagramme de ltoeil en sortie du filtre de réception
figure, plot(reshape(signalDemodule,Ns,length(signalDemodule)/Ns));
title("Le diagramme de l'oeil en sortie du filtre de réception sans canal");

% Le diagramme de l oeil en sortie du filtre de réception sans pb du début
% figure, plot(reshape(signalDemodule(65:end),Ns,length(signalDemodule(65:end))/Ns));
% title('Le diagramme de l%oeil en sortie du filtre de réception sans canal sans prob');


n0=Ns/2;  %n0 optimal pour échantillonnage

% echantillonnage du signal après filtre de réception
decision1 = signalDemodule(n0: Ns :length(signalDemodule));

%calcul du taux d'erreur binaire  sans bruit
TEB_2_SB = sum((decision1>0)~=bits)/length(decision1);


%2.2) AVEC AJOUT DE BRUIT

Puissance=mean(abs(signalModule).^2); % puissance du signal après le pe premier filtre

TEB_2=zeros(1,9); % Initialisation tableau TEB simulé 
TEB_Theo_2 = zeros(1,9); % Initialisation tableau TEB théorique

for i=1:length(EbNo)
    sigma = sqrt((Puissance*Ns)./(2*log2(M1).*10^(EbNo(i)/10))); %sigma carré

    %Calcul du bruit à ajouter
    bruit = sigma*randn(1,length(signalModule));

    %Ajout du bruit
    SignalModuleBruit= signalModule + bruit; 
    signalDemodule = filter(hr, 1, SignalModuleBruit);
    
    %Echantillonage du signal à la sortie du filtre de réception
    decision = signalDemodule(Ns/2: Ns :length(signalDemodule));

    %Calcul du TEB simulé et théorique
    TEB_2(i) = sum((decision>0)~=bits)/length(decision);
    TEB_Theo_2(i)=qfunc(sqrt(10^(EbNo(i)/10)));
     
end

% Tracé du TEB théorique et simulé  en fonction du rappport Eb/n0 afin de les comparer
figure, semilogy(EbNo, TEB_2);
hold on
semilogy(EbNo, TEB_Theo_2);
legend('TEB pratique', 'TEB théorique');
title("Le taux d'erreur binaire en fonction du rapport signal à bruit")
xlabel("Eb/N0 (Db)")
ylabel("TEB")

%Tracé  du TEB de la partie 1 et du TEB de la partie 2
figure, semilogy(TEB);
hold on
semilogy(TEB_2);
legend('TEB filtre adapté', 'TEB filtre non adapté');
title("Comparaison TEB ")
xlabel("Eb/N0 (Db)")
ylabel("TEB")

%% Partie 3  avec h=hr et mapping 4-aire %%

M= 4;
t0_4=length(h);
% Génération du mapping 4-aire  : 00 -> -3, 01 -> -1, 11 -> 1, 10 -> 3 
bits_re_4 = reshape(bits, length(bits)/2,2);
bits_re1_4 = bi2de(bits_re_4);
bits_re2_4 = pammod(bits_re1_4,M,0,'GRAY');


%géneration des impulsions
Impulsions1 = [kron(bits_re2_4.', [1 zeros(1, Ns-1)])];

hr=h; %filtre de reception 

% 3.1) SANS BRUIT

%filtrage du signal sans bruit
signalModule = filter(h, 1, Impulsions1);
signalDemodule = filter(hr, 1, signalModule);

% Tracé du diagramme de lToeil en sortie du filtre de réception
figure, plot(reshape(signalDemodule,Ns,length(signalDemodule)/Ns));
title('Le diagramme de l’oeil en sortie du filtre de réception sans canal');

n0= Ns; %n0 optimal pour échantillonnage

% echantillonnage à la sortie du filtre 
decision= signalDemodule(Ns: Ns :length(signalDemodule));
decision8 = decision ./Ns;


% demodulation : Reconstittion des symboles de départ avec détecteur seuil
Bande_filtre = pamdemod(decision8,M,0,'GRAY');
Bande_filtre2 = de2bi(Bande_filtre);
taille = size(Bande_filtre2);
Bits_reconstitue_4 = reshape(Bande_filtre2, 1, taille(1)*taille(2));

 %Calcul du taux d'erreur binaire sans bruit
TEB_3_SB= sum(Bits_reconstitue_4~=bits)/length(bits);


% 3.2) AVEC BRUIT

TES_3=zeros(1,9); % Initialisation tableau taux d'erreur symbole 
TES_Theo_3=zeros(1,9); %Initialisation tableau taux d'erreur symbole théorique
Puissance=mean(abs(signalModule).^2);

for i=1:length(EbNo)
    sigma = sqrt((Puissance*Ns)./(2*log2(M2).*10^(EbNo(i)/10))); %Sigma carré

    %Calcul du bruit
    bruit = sigma*randn(1,length(signalModule));

    %Ajout du bruit
    SignalModuleBruit= signalModule + bruit;
    signalDemodule = filter(hr, 1, SignalModuleBruit);
    
    %Echantillonnage en sortie du filtre de reception
    decision= signalDemodule(n0: Ns :length(signalDemodule));
    decision8 = decision ./Ns;

    % Demodulation et calcul du TES
    
    % Demodulation : reconstitution des symboles
    Bande_filtre = pamdemod(decision8,M,0,'GRAY');
    Bande_filtre2 = de2bi(Bande_filtre);
    taille = size(Bande_filtre2);
    Bits_reconstitue = reshape(Bande_filtre2, 1, taille(1)*taille(2));
    
    %Calcul taux d'erreur symbole
    TES_3(i) = sum(Bits_reconstitue~=bits)/length(bits)* log2(M);
    TES_Theo_3(i)= (3/2) * qfunc(sqrt((4/5)*10^(EbNo(i)/10)));
 
end

%Tracé du TES pratique et théorique en fonction du rapport Eb/N0
figure, semilogy(EbNo, TES_3);
hold on
semilogy(EbNo, TES_Theo_3);
legend('TES pratique', 'TES théorique');
title("Le taux d'erreur symbole en fonction du rapport signal à bruit")
xlabel("Eb/N0 (Db)")
ylabel("TES")

%Calcul du taux d'erreur binaire pratique et  théorique
TEB_3=TES_3./(log2(M2));
TEB_Theo_3= TES_Theo_3/2;

%Tracé du taux d'erreur pratique et théorique 
figure, semilogy(EbNo, TEB_3);
hold on
semilogy(EbNo, TEB_Theo_3);
legend('TEB pratique', 'TEB théorique');
title("Le taux d'erreur binaire en fonction du rapport signal à bruit")
xlabel("Eb/N0 (Db)")
ylabel("TEB")

%Tracé  du TEB de la partie 1 et du TEB de la partie 2
figure, semilogy(TEB);
hold on
semilogy(TEB_3);
legend('TEB filtre adapté', 'TEB filtre non adapté');
title("Comparaison TEB ")
xlabel("Db")
ylabel("TEB")