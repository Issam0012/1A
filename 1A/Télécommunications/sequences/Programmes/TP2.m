clear
close all
clc

%% Données :
nb_bits = 1000;              % Nombre de bits générés :
Fe = 24000;                  % Fréquence d'échantillonage
Te = 1/Fe;                   % Période d'échantillonage
Rb = 3000;                   % débit binaire
Tb = 1/Rb;                   % Période binaire
M=2;                         % nombre de symboles differents (1,-1) 
n=log2(M);                   % nombre de bits par symbole ici 2 (bit 1, bit 0)
nb_symboles = nb_bits / n;   % Le nombre de symboles
Ts=n*Tb;                     % Periode symbole
Rs=Rb/n;                     % Debit symbole
Ns = Ts/Te;                  % nomdre de peiodes d'echantillonnage par periode symbole

% Gérération de l'information binaire :
bits = randi ([0, 1], 1, nb_bits);

% Génération de la réponse impulsionnelle du filtre de mise en forme :
h = ones (1, Ns);

% Génération de la réponse impulsionnelle du filtre de réception :
hr = fliplr(h);

% Mapping binaire à moyenne nulle : 0 -> -1, 1 -> +1 :
bits_map = bits * 2 - 1;

% Génération des impulsions :
Impulsions1 = [kron(bits_map, [1 zeros(1, Ns-1)]) zeros(1,length(h))];

% La modulation et démodulation
signalModule = filter(h, 1, Impulsions1);
signalDemodule = filter(hr, 1, signalModule);

% Le tracé du signal résultant
t_axis = [Te:Te:Te*length(signalDemodule)];
figure, plot(t_axis,signalDemodule);
title('le signal en sortie du filtre de réception');
xlabel('temps (s)')
axis([0 (nb_bits-1)*Te -10 10]);

% La réponse impulsionnelle globale
g = conv(h,hr);
figure, plot(linspace(0, 20*Ts, length(g)), g);
title('la réponse impulsionnelle globale de la chaine de transmission, g');

% l'instant n0 optimal permettant l'échantillonage voulu
n0 = Ns;

% Le diagramme de l’oeil en sortie du filtre de réception
figure, plot(reshape(signalDemodule,Ns,length(signalDemodule)/Ns));
title('Le diagramme de l’oeil en sortie du filtre de réception sans canal');

% L'échantillonage du signal en sortie du filtre de réception à n0 + mNs
I = Ns: Ns :length(signalDemodule);
signalE = signalDemodule(I);
t_axis = [Te:Te:Te*length(signalE)];
figure, plot(t_axis, signalE);
title('signal échantilloné');
xlabel('temps (s)')

% Le calcul du taux d'erreur binaire
decision = signalDemodule(n0+1: Ns :length(signalDemodule));
TEB_1 = sum((decision>0)~=bits)/length(decision);

% % L'échantillonage du signal en sortie du filtre de réception à n0 + mNs
% tq n0 = 3
n0 = 3;
I = n0: Ns :length(signalDemodule)-Ns;
signalE = signalDemodule(I);
t_axis = [Te:Te:Te*length(signalE)];
figure, plot(t_axis, signalE);
title('signal échantilloné');
xlabel('temps (s)')

% Le calcul du taux d'erreur binaire
decision = signalDemodule(n0+1: Ns :length(signalDemodule)-Ns);
TEB_2 = sum((decision>0)~=bits)/length(decision);


%% Etude avec canal de propagation sans bruit

n0 = Ns;

% L'implantation du filtre pass-bas
fc = 8000;                                   % Fréquence de coupure
N = 51;                                      % L'ordre du filtre
k = [-(N-1)/2:1:(N-1)/2+1];            
hc = (2 * fc/Fe) * sinc(2 * (fc/Fe) * k);    % La réponse impulsionnelle du filtre passe-bas

signalModule = filter(h, 1, Impulsions1);

signalM = filter(hc, 1 , signalModule);

signalG = filter(hr, 1, signalM);

signalG = signalG(1, (Ns + (N-1)/2) : end);

% La réponse impulsionnelle globale
g = conv(h,hr);
figure, plot(linspace(0, 20*Ts, length(g)), g);
title('la réponse impulsionnelle globale de la chaine de transmission, g');


% Le diagramme de l’oeil en sortie du filtre de réception
figure, plot(reshape(signalG,Ns,length(signalG)/Ns));
title('Le diagramme de l’oeil à la sortie du filtre de réception');


% La reprénsetation des réponses en fréquence des différents filtres
n_fft = 1024;
H1 = abs(fftshift(fft(g, n_fft)));
Hc = abs(fftshift(fft(hc, n_fft)));
frequence = linspace(-Fe/2, Fe/2, length(H1));

figure, plot(frequence, H1);
hold on
plot(frequence, 60 * Hc);
title('Les réponses en fréquences')
legend ('Hr.H', 'Hc')
xlabel('fréquence (Hz)')


% L'échantillonage du signal en sortie du filtre de réception à n0 + mNs
I = Ns: Ns :length(signalG);
signalE_C = signalG(I);
figure, plot(signalE_C);
title('signal échantilloné');

% Le calcul du taux d'erreur binaire
decision = signalDemodule(n0+1: Ns :length(signalDemodule));
TEB_3 = sum((decision>0)~=bits)/length(decision);


%% BW = 1000
% L'implantation du filtre pass-bas
fc = 1000;                                   % Fréquence de coupure
N = 51;                                      % L'ordre du filtre
k = [-(N-1)/2:1:(N-1)/2+1];            
hc = (2 * fc/Fe) * sinc(2 * (fc/Fe) * k);    % La réponse impulsionnelle du filtre passe-bas

signalModule = filter(h, 1, Impulsions1);

signalM = filter(hc, 1 , signalModule);

signalG = filter(hr, 1, signalM);

signalG = signalG(1, (Ns + (N-1)/2) : end);


% Le diagramme de l’oeil en sortie du filtre de réception
figure, plot(reshape(signalG,Ns,length(signalG)/Ns));
title('Le diagramme de l’oeil en sortie du filtre de réception');


% La reprénsetation des réponses en fréquence des différents filtres
H1 = abs(fftshift(fft(g, n_fft)));
Hc = abs(fftshift(fft(hc, n_fft)));
frequence = linspace(-Fe/2, Fe/2, length(H1));

figure, plot(frequence, H1);
hold on
plot(frequence, 60 * Hc);
title('Les réponses en fréquences')
legend ('Hr.H', 'Hc')
xlabel('fréquence (Hz)')


% L'échantillonage du signal en sortie du filtre de réception à n0 + mNs
I = Ns: Ns :length(signalG);
signalE_C = signalG(I);
figure, plot(signalE_C);
title('signal échantilloné');

% Le calcul du taux d'erreur binaire
decision = signalDemodule(n0+1: Ns :length(signalDemodule));
TEB_4 = sum((decision>0)~=bits)/length(decision);