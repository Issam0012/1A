%--------------------------------------------------------------
% Iniialisation des variables
%--------------------------------------------------------------


load('donnees1.mat','bits_utilisateur1');    % Le premier message
load('donnees2.mat','bits_utilisateur2');    % Le deuxième message                            
T=40e-3;                                     % La durée du timeslot
fe=120000;                                   % La fréquence d'échantillonnage
Te= 1/fe;                                    % La période d'échantillonnage
Ns=(T/Te)/length(bits_utilisateur1);         % Le nombre total des échantillons



%--------------------------------------------------------------
% Modulation Bande base
%--------------------------------------------------------------


% La création des deux signaux (les deux varient entre 0 et 1)
signal_1 = kron(bits_utilisateur1, ones(1,Ns));    
signal_2 = kron(bits_utilisateur2, ones(1,Ns));    


% L'adaptation des signaux pour qu'ils varient entre -1 et 1
signal_1 = signal_1*2-1;                           
signal_2 = signal_2*2-1;


% La création de l'échelle temporelle
temps = linspace (1,T/Te, T/Te);


% Le tracé des deux signaux avec une échelle temporelle en secondes.
%figure, plot(temps, signal_1, '*');
%ylabel('m1(t)');
%xlabel('temps(s)');
%title('Le tracé du signal m1')
%figure, plot(temps, signal_2, '*');
%ylabel('m2(t)');
%xlabel('temps(s)');
%title('Le tracé du signal m2')


% Le transformée de fourrier des deux signaux
fourrier_1=abs(fft(signal_1)).^2;
fourrier_2=abs(fft(signal_2)).^2;


% La création de l'échelle fréquencielle
frequence_1 = linspace (0, T/Te, T/Te);


% Le tracé des densités spectrales de puissance des deux signaux avec une échelle fréquentielle en Hz.
%figure, plot(frequence_1, fourrier_1);
%ylabel('DSP_{m1}(f)');
%xlabel('frequence(Hz)');
%title('densité spectrale de puissance de m1(t)')
%figure, plot(frequence_1, fourrier_2);
%ylabel('DSP_{m2}(f)');
%xlabel('frequence(Hz)');
%title('densité spectrale de puissance de m2(t)')



%--------------------------------------------------------------
% Construction du signal MF-TDMA
%--------------------------------------------------------------


% Génération de deux signaux comportant 5 slots chacun
slot_2 = zeros(1, 5 * T/Te);                    %J'ai noté slot_2 car le signal utile va se mettre au deuxième slot de même pour slot_5
slot_5 = zeros(1, 5 * T/Te);


% La placement des signaux au slot aloué
slot_2(T/Te+1:2*(T/Te)) = signal_1;
slot_5(4*(T/Te)+1:5*(T/Te)) = signal_2;


% Le nouveau échelle temporelle
temps = 0 : Te : 5 * T - Te;


% Le tracé des signaux résultants
%figure, plot(temps, slot_2);
%ylabel('signal résultant_2');
%xlabel('temps(s)');
%title('le signal résultant pour le premier message')
%figure, plot(temps, slot_5);
%ylabel('signal résultant_5');
%xlabel('temps(s)');
%title('le signal résultant pour le deuxième message')


% La modulation d'amplitude


% Les fréquences porteuses
f_p1 = 0;
f_p2 = 46e+3;


% Le produit des signaux par les fréquences porteuses
x1 = slot_2 .* cos(2 * pi * f_p1 * temps);
x2 = slot_5 .* cos(2 * pi * f_p2 * temps);


% Le tracé des deux signaux résultants
%figure
%plot(temps, x1);
%ylabel('x1(t)');
%xlabel('temps(s)');
%figure
%plot(temps, x2);
%ylabel('x2(t)');
%xlabel('temps(s)');


% La somme des deux signaux
signal_somme = x1 + x2;


% L'ajout du bruit gaussien
RSB = 100;                                      % Le rapport signal sur bruit
P_s = mean(abs(signal_somme).^2);               % La puissance du signal
P_bruit= P_s * 10^(-RSB/10);                    % La puissance du bruit
Bruit = randn(1, 5*(T/Te)) * sqrt(P_bruit);     % La matrice qui contient le bruit
x = signal_somme + Bruit;                       % Le signal final x(t)


% Le tracé du signal MF-TDMA
%figure
%plot(temps, x);
%ylabel('x(t)');
%xlabel('temps(s)');
%title('Le tracé du signal MF-TDMA')


% Le tracé la densité spectrale de puissance du signal MF-TDMA
DSP_x=abs(fftshift(fft(x))).^2;                          % La densité spectrale de puissance
frequence = linspace(-1/(2*Te), 1/(2*Te), length(x));    % L'échelle fréquentielle
%figure
%plot(frequence, DSP_x);
%ylabel('DSP_x(f)');
%xlabel('frequence(Hz)');
%title('La densité spectrale de puissance du signal MF-TDMA')



%--------------------------------------------------------------
% Synthèse du filtre passe-bas
%--------------------------------------------------------------


ordre = 121;                                        % L'ordre du filtre
k = [-(ordre-1)/2:1:(ordre-1)/2+1];
fc=23000;                                           % La fréquence de coupure
h_pb = 2 * (fc/fe) * sinc(2 * (fc/fe) * k);         % La réponse impulsionnelle du filtre passe-bas 
passe_bas = filter(h_pb ,1 , x);                    % Le signal filtré


% Le tracé de la réponse impulsionnelle et la réponse en fréquence du filtre implanté

%figure
%plot(h_pb);
%title('La réponse impulsionnelle');
%ylabel('h(t)')
%xlabel('temps')
%figure
%plot(abs(fftshift(fft(h_pb))).^2);
%title('La réponse en fréquence');
%ylabel('H(f)')
%xlabel('frequence')


% Le tracé du la densité spectrale de puissance du signal MF-TDMA reçu et le module de la réponse en fréquences du filtre implanté.

%figure
%subplot(2,1,1)
%plot(frequence, DSP_x);
%hold on
%plot(linspace(-fe/2,fe/2,length(h_pb)), 12*fftshift(abs(fft(h_pb)))*10^5);
%legend('signal original', 'le filtre passe-bas');
%title('le signal original');
%xlabel('frequence(Hz)');
%subplot(2,1,2)
%plot(frequence, abs(fftshift(fft(passe_bas))).^2);
%title('signal filtré');
%xlabel('frequence(Hz)');



%--------------------------------------------------------------
% Synthèse du filtre passe-haut
%--------------------------------------------------------------


% La réponse impulsionnelle d'un filtre passe-haut
h_ph = -h_pb;                                          
h_ph((length(h_ph))/2) = 1 - h_pb(length(h_pb)/2);

passe_haut = filter(h_ph ,1 , x);                      % Le signal filtré

% Le tracé de la réponse impulsionnelle et la réponse en fréquence du filtre implanté

% figure
% plot(h_ph);
% title('La réponse impulsionnelle');
% ylabel('h(t)')
% xlabel('temps')
% figure
% plot(abs(fftshift(fft(h_ph))).^2);
% title('La réponse en fréquence');
% ylabel('H(f)')
%xlabel('frequence')


% Le tracé du la densité spectrale de puissance du signal MF-TDMA reçu et le module de la réponse en fréquences du filtre implanté.

% figure
% subplot(2,1,1)
% plot(frequence, DSP_x);
% hold on
% plot(linspace(-fe/2,fe/2,length(h_ph)), 12*fftshift(abs(fft(h_ph)))*10^5);
% legend('signal original', 'le filtre passe-haut');
% title('le signal original');
% xlabel('frequence(Hz)');
% subplot(2,1,2)
% plot(frequence, abs(fftshift(fft(passe_haut))).^2);
% title('signal filtré');
% xlabel('frequence(Hz)');



%--------------------------------------------------------------
% Le filtrage
%--------------------------------------------------------------


% L'ajout de zéros
x_zeros = [x, zeros(1, (ordre-1)/2)];

% Le filtrage
x1_til = filter(h_pb ,1 , x_zeros);
x2_til = filter(h_ph ,1 , x_zeros);

% L'élimination des zéros ajoutés
x1_til = x1_til (1, (ordre-1)/2+1 : end);
x2_til = x2_til (1, (ordre-1)/2+1 : end);


% Le tracé des deux signaux filtré en échelle temporelle
% figure, plot(temps, x1_til);
% ylabel('x1\_til(t)');
% xlabel('temps(s)');
% title('le signal filtré par le filtre passe-bas')
% figure, plot(temps, x2_til);
% ylabel('x2\_til(s)');
% xlabel('temps(s)');
% title('le signal filtré par le filtre passe-haut')


%--------------------------------------------------------------
% Le retour en bande de base
%--------------------------------------------------------------

x1_til = x1_til .* cos(2 * pi * f_p1 * temps);
x2_til = x2_til .* cos(2 * pi * f_p2 * temps);


%--------------------------------------------------------------
% Détection du slot utile
%--------------------------------------------------------------
energie = [];                                                                 % La matrice qui va contenir les énergies


% La division du signal en 5 parties et la prise de l'énergie de chaque partie
for i = 0:4
    X = x1_til (1 , i*(T/Te)+1 : (i+1)*(T/Te));
    energie = [energie, mean(abs(X).^2)];
end

[utile indice_utile_1] = max(energie);
bits1 = x1_til (1 , (indice_utile_1-1)*(T/Te)+1 : indice_utile_1*(T/Te));    % Le signal utilse se trouve où l'énergie est maximum


% De même pour l'autre signal
energie = [];

for i = 0:4
    X = x2_til (1 , i*(T/Te)+1 : (i+1)*(T/Te));
    energie = [energie, mean(abs(X).^2)];
end

[utile indice_utile_2] = max(energie);
bits2 = x2_til (1 , (indice_utile_2-1)*(T/Te)+1 : indice_utile_2*(T/Te));



%--------------------------------------------------------------
% Démodulation bande de base
%--------------------------------------------------------------


% L'extraction du premier texte du premier signal
SignalFiltre_1 = filter(ones(1,Ns),1,bits1) ;
SignalEchantillonne_1 = SignalFiltre_1(Ns :Ns :end) ;
BitsRecuperes_1 = (sign(SignalEchantillonne_1)+1)/2 ;
indice_1 = bin2str(BitsRecuperes_1) ;                    % L'utilisation du bin2str pour retrouver le premier texte indice


% L'extraction du deuxième texte du deuxième signal
SignalFiltre_2 = filter(ones(1,Ns),1,bits2) ;
SignalEchantillonne_2 = SignalFiltre_2(Ns :Ns :end) ;
BitsRecuperes_2 = (sign(SignalEchantillonne_2)+1)/2 ;
indice_2 = bin2str(BitsRecuperes_2) ;                    % L'utilisation du bin2str pour retrouver le deuxième texte indice

