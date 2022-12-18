clear;
clc
close all

%% Données
Fe = 24000;                        % Fréquence d'échantillonnage
Te = 1/Fe;                         % Période d'échantiollonnage
Rb = 6000;                         % Débit binaire
Tb = 1/Rb;                         % Période binaire
M = 2;                             % Ordre de la modulation
n = log2(M);                       % Nombre de bits par symbole                        
Rs = Rb/n;                         % Débit symbole
Ts = 1/Rs;                         % Période symbole
Ns = Ts/Te;                        % Facteur de suréchantillonnage
h = ones(1, Ns);                   % filtre de mise en forme
hr = fliplr(h);                    % filtre de réception
nb_bits = 50000;                   % Nombre de bits à transmettre

%% Gérération de l'information binaire :
bits = randi([0,1], 1, nb_bits);
symboles = (2*bits -1);                                % Mapping binaire à moyenne nulle
impulsions = kron(symboles, [1 zeros(1, Ns-1)]);       % Génération des impulsions
enveloppe_complexe = filter(h, 1, impulsions);         % L'enveloppe complexe

%% Récepteur cas sans bruit et sans erreur de phase
signal_recu_1 = filter(hr, 1, enveloppe_complexe);     % Signal reçu

%Decision et Demapping
n0 = Ns;                                               % Instant optimal d'échantillonnage
decision_1 = signal_recu_1(n0:Ns:end); 
TEB_1 = sum((decision_1>0)~=bits)/length(decision_1);

%Constellation
% scatterplot(decision); 

%% Récepteur cas sans bruit et avec erreur de phase
%L'enveloppe complexe est déphasé avant d'entrer en filtre de récéption
Phi = 40*pi/180;                          % Erreur de phase (en rad)
signal_dephase = enveloppe_complexe*exp(i*Phi);

signal_recu_2 = filter(hr, 1, signal_dephase); %Signal reçu

%Decision et Demapping
decision_2 = signal_recu_2(n0:Ns:end); 
TEB_2 = sum((decision_2>0)~=bits)/length(decision_2);

%Constellation
%scatterplot(decision_2); 

%% Récepteur cas bruit et erreur de phase
Puissance = mean(abs(enveloppe_complexe).^2); % Puissance du signal reçu
EbNo= (0:1:6);                                % Différentes valeur du rapport Eb/N0
TEB=zeros(1,7);                               % Initialisation tableau TEB simulé 
TEB40=zeros(1,7);                             % Initialisation tableau TEB simulé avec phi = 40
TEB100=zeros(1,7);                            % Initialisation tableau TEB simulé avec phi = 100
TEB_Theo = zeros(1,7);                        % Initialisation tableau TEB théorique
% Erreurs de phase
Phi1 = 0;
Phi2 = 40*pi/180;
Phi3 = 100*pi/180;

for k=1:length(EbNo)

    Sigma = (Puissance*Ns)./(2*log2(M).*10^(EbNo(k)/10));
    bruit = sqrt(Sigma)*randn(1, length(enveloppe_complexe)) +i*sqrt(Sigma)*randn(1, length(enveloppe_complexe));
    
    enveloppe_bruite = enveloppe_complexe + bruit; %Ajout du bruit à l'enveloppe
    
    %Multiplication par l'erreur de phase porteuse pour les valeurs 0, 40
    %et 100 degrès respectivement
    enveloppe_bruite_dephase_Phi1 = enveloppe_bruite*exp(i*Phi1); 
    enveloppe_bruite_dephase_Phi2 = enveloppe_bruite*exp(i*Phi2);
    enveloppe_bruite_dephase_Phi3 = enveloppe_bruite*exp(i*Phi3);

    % Filtrage et échantillonnage des 3 signaux déphasés (calcul des décisions)
    signal_recu_Phi1 = filter(hr, 1, enveloppe_bruite_dephase_Phi1);
    decision = real(signal_recu_Phi1(n0:Ns:end));

    signal_recu_Phi2 = filter(hr, 1, enveloppe_bruite_dephase_Phi2);
    decision40 = real(signal_recu_Phi2(n0:Ns:end));

    signal_recu_Phi3 = filter(hr, 1, enveloppe_bruite_dephase_Phi3);
    decision100 = real(signal_recu_Phi3(n0:Ns:end));

    TEB_Theo(k) = qfunc(real(exp(1i*Phi*pi/180))*sqrt(2*10^(EbNo(k)/10)));
    TEB(k) = sum((decision>0)~=bits)/length(decision);
    TEB40(k) = sum((decision40>0)~=bits)/length(decision40);
    TEB100(k) = sum((decision100>0)~=bits)/length(decision100);
end

%% Tracé des TEB théoriques et mesurés (40°) en fonction de Eb/N0 en dB
figure, 
semilogy(EbNo, TEB_Theo, EbNo, TEB40, '*-');
xlabel 'Eb/No (dB)'
ylabel 'TEB'
legend 'TEB theorique 40°' 'TEB mesure 40°'
title '  Tracé des TEB théoriques et mesurés (40°) '

%% Tracé des TEB mesurés (0 et 40°) en fonction de Eb/N0 en dB
figure,
semilogy(EbNo, TEB, EbNo, TEB40, '*-');
xlabel 'Eb/No (dB)'
ylabel 'TEB'
legend 'TEB mesuré 0°' 'TEB mesure 40°'
title '  Tracé des TEB mesurés (0 et 40°) '

%% Tracé des TEB mesurés (100 et 40°) en fonction de Eb/N0 en dB
figure,
semilogy(EbNo, TEB100, EbNo, TEB40, '*-');
xlabel 'Eb/No (dB)'
ylabel 'TEB'
legend 'TEB mesure 100°' 'TEB mesure 40°'
title 'Tracé des TEB mesurés (100 et 40°)'