close all;

%% Données :
Fe = 24000;
Te = 1/Fe;
Rb = 3000;
n_fft = 1024;

% Durée symbole en nombre d'échantillons :
Ns1 = 8;
Ns2 = 16;
Ns3 = 8;
freq1 = linspace(-Fe/2, Fe/2,n_fft);
freq2 = linspace(-Fe/2, Fe/2,n_fft);
freq3 = linspace(-Fe/2, Fe/2,n_fft);

% Nombre de bits générés :
nb_bits = 1000;
Ts = nb_bits/Rb;

% Gérération de l'information binaire :
bits = randi ([0, 1], 1, nb_bits);

%% Implantation du modulateur 1 :
% Mapping binaire à moyenne nulle : 0 -> +1, 1 -> -1
Symboles1 = 2*bits - 1;

% Génération des impulsions :
Impulsions1 = kron(Symboles1, [1 zeros(1, Ns1-1)]);

% Génération de la réponse impulsionnelle du filtre de mise en forme :
h1 = ones (1, Ns1);

% Filtrage de mise en forme :
x1 = filter (h1, 1, Impulsions1);

% Affichage du signal généré :
figure; plot(x1);
title('modulateur 1');
axis([0 nb_bits-1 -1.5 1.5]);

%% Implantation du modulateur 2 :
% Mapping 4-aires à moyenne nulle : 01 -> -1, 00 -> -3, 10 -> 1, 11 -> 3
%x = bits(1 : 2 : end)*2 + bits(2:2:end);
%Symboles2 = 2*x - 3;
suite_bits_decimal = bi2de(reshape(bits, [nb_bits/2,2]));

Symboles2 = transpose(suite_bits_decimal)-1.5;

% Génération des impulsions :
Impulsions2 = kron(Symboles2, [1 zeros(1, Ns2-1)]);

% Génération de la réponse impulsionnelle du filtre de mise en forme :
h2 = ones (1, Ns2);

% Filtrage de mise en forme :
x2 = filter (h2, 1, Impulsions2);

% Affichage du signal généré :
figure; plot(x2);
title('modulateur 2');
axis([0 nb_bits-1 -5 5]);

%% Implantation du modulateur 3 :
% Mapping binaire à moyenne nulle : 0 -> +1,1 -> -1
Symboles3 = 2*bits - 1;

% Génération des impulsions :
Impulsions3 = kron(Symboles3, [1 zeros(1, Ns3-1)]);

% Génération de la réponse impulsionnelle du filtre de mise en forme :
h3 = rcosdesign(0.5, 10, Ns3);

% Filtrage de mise en forme :
x3 = filter (h3, 1, Impulsions3);

% Affichage du signal généré :
figure; plot(x3);
title('modulateur 3');
axis([0 nb_bits-1 -5 5]);

%% Calcul de la DSP :
% Théoriques :
s1 = (1/Ts) * abs(fft(h1 , n_fft)).^ 2;
s2 = (1/Ts) * abs(fft(h2, n_fft)).^ 2;
s3 = (1/Ts) * abs(fft(h3, n_fft)).^ 2;

% Estimées :
S1 = (1/n_fft) * abs(fft(x1, n_fft)).^ 2;
S2 = (1/n_fft) * abs(fft(x2, n_fft)).^ 2;
S3 = (1/n_fft) * abs(fft(x3, n_fft)).^ 2;

%% Tracage des différents densités de fréquences :
figure;
semilogy(freq1, fftshift(s1), 'g', freq1, fftshift(S1), 'r');
title('Densités spectrales de puissance du signal x1(t)');
xlabel("Fréquencee")
ylabel("Densité spectrale de puissance")
figure;
semilogy(freq2, fftshift(s2), 'g', freq2, fftshift(S2), 'r');
title('Densités spectrales de puissance du signal x2(t)');
xlabel("Fréquence")
ylabel("Densité spectrale de puissance")
figure;
semilogy(freq3, fftshift(s3), 'g', freq3, fftshift(S3), 'r');
title('Densités spectrales de puissance du signal x3(t)');
xlabel("Fréquence")
ylabel("Densité spectrale de puissance")