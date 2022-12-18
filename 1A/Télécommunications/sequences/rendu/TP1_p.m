clear;
close all;
clc;

%----------------------
% L'initialiasation des paramètres
%----------------------

nb_bits = 1000;                      % Le nombre de bits
Fe = 24000;                          % La fréquence d'échantillonage 
Te = 1/Fe;                           % La période d'échantillonage
Rb = 3000;                           % Debit binaire 
Tb = 1/Rb;                           % Période binaire                          

%----------------------
% Le signal aléatoire généré
%----------------------

signal = randi([0 1], 1, nb_bits);

%----------------------
% Le premier modulateur
%----------------------

M=2;                                                  % nombre de symboles differents (1,-1) 
n=log2(M);                                            % nombre de bits par symbole ici 2 (bit 1, bit 0)
nb_symboles = nb_bits / n;                            % Le nombre de symboles
Ts1=n*Tb;                                             % Periode symbole
Rs=Rb/n;                                              % Debit symbole
Ns1 = Ts1/Te;                                         % nomdre de peiodes d'echantillonnage par periode symbole
h1 = ones(1, Ns1);                                    % Le filtre de mise en forme

symboles1 = signal * 2 - 1;                           % Le mapping binaire à moyenne nulle
impulsions1 = kron(symboles1, [1 zeros(1, Ns1-1)]);   % génération des impulsions
x1 = filter(h1, 1, impulsions1);
t_axis = [Te:Te:Te*length(x1)];
figure, plot(t_axis,x1)
axis([0 (nb_bits-1)*Te -1.5 1.5]);
title('Modulateur 1');
xlabel('temps(s)')

%----------------------
% Le deuxième modulateur
%----------------------

M=4;                                                  % nombre de symboles differents (-3,-1,1,-1) 
n=log2(M);                                            % nombre de bits par symbole ici 2 (bit 1, bit 0)
nb_symboles = nb_bits / n;                            % Le nombre de symboles
Ts2=n*Tb;                                             % Periode symbole
Rs=Rb/n;                                              % Debit symbole
Ns2 = Ts2/Te;                                         % nomdre de peiodes d'echantillonnage par periode symbole
h2 = ones(1, Ns2);                                    % Le filtre de mise en forme

% Mapping 4-aires à moyenne nulle : 01 -> -1, 00 -> -3, 10 -> 1, 11 -> 3
symboles2 = (bi2de(reshape(signal, [2 nb_bits/2])') * 2 - 3)'; % mapping 4-aires à moyenne nulle
impulsions2 = kron(symboles2, [1 zeros(1, Ns2-1)]);    % génération des impulsions
x2 = filter(h2, 1, impulsions2);                       
t_axis = [Te:Te:Te*length(x2)];
figure, plot(t_axis,x2)
axis([0 (nb_bits-1)*Te -5 5]);
title('Modulateur 2');
xlabel('temps(s)')

%----------------------
% Le troisième modulateur
%----------------------

M=2;                                                  % nombre de symboles differents (1,-1) 
n=log2(M);                                            % nombre de bits par symbole ici 2 (bit 1, bit 0)
nb_symboles = nb_bits / n;                            % Le nombre de symboles
Ts3=n*Tb;                                             % Periode symbole
Rs=Rb/n;                                              % Debit symbole
Ns3 = Ts3/Te;                                         % nomdre de peiodes d'echantillonnage par periode symbole

h3 = rcosdesign(0.5, 4, Ns3);
symboles3 = signal * 2 - 1;  % Le mapping binaire à moyenne nulle
impulsions3 = kron(symboles3, [1 zeros(1, Ns3-1)]);
x3 = filter(h3, 1, impulsions3);
t_axis = [Te:Te:Te*length(x3)];
figure, plot(t_axis,x3)
axis([0 (nb_bits-1)*Te -1 1]);
title('Modulateur 3');
xlabel('temps(s)')


%% ----------------------
% La DSP pratique et théorique du chaque signal transmis
%----------------------

n_fft = 1024;
freq = linspace(-Fe/2, Fe/2,n_fft); % L'échelle de fréquence

% Théoriques :
DSP_theo1 = (1/Ts1) * abs(fft(h1 , n_fft)).^ 2;
DSP_theo2 = (1/Ts2) * abs(fft(h2, n_fft)).^ 2;
DSP_theo3 = (1/Ts3) * abs(fft(h3, n_fft)).^ 2;

% Estimées :
DSP_prat1 = (1/n_fft) * abs(fft(x1, n_fft)).^ 2;
DSP_prat2 = (1/n_fft) * abs(fft(x2, n_fft)).^ 2;
DSP_prat3 = (1/n_fft) * abs(fft(x3, n_fft)).^ 2;

% Tracage des différents densités de fréquences :
figure;
semilogy(freq, fftshift(DSP_theo1/max(DSP_theo1)), 'g', freq, fftshift(DSP_prat1/max(DSP_prat1)), 'r');
legend('DSP théorique', 'DSP pratique');
title('Densités spectrales de puissance du signal x1(t)');
xlabel('fréquence (Hz)')
ylabel('Densité spectrale de puissance')
figure;
semilogy(freq, fftshift(DSP_theo2/max(DSP_theo2)), 'g', freq, fftshift(DSP_prat2/max(DSP_prat2)), 'r');
legend('DSP théorique', 'DSP pratique');
title('Densités spectrales de puissance du signal x2(t)');
xlabel('fréquence (Hz)')
ylabel('Densité spectrale de puissance')
figure;
semilogy(freq, fftshift(DSP_theo3/max(DSP_theo3)), 'g', freq, fftshift(DSP_prat3/max(DSP_prat3)), 'r');
legend('DSP théorique', 'DSP pratique');
title('Densités spectrales de puissance du signal x3(t)');
xlabel('fréquence (Hz)')
ylabel('Densité spectrale de puissance')

%% La comparaison des DSP des signaux générés par les différents modulateurs
figure;
semilogy(freq, fftshift(DSP_prat1/max(DSP_prat1)), 'g', freq, fftshift(DSP_prat2/max(DSP_prat2)), 'r',freq, fftshift(DSP_prat3/max(DSP_prat3)), 'b');
legend('DSP du modulateur 1', 'DSP du modulateur 2', 'DSP du modulateur 3');
title('Les DSP générées par les 3 modulateurs');
xlabel('fréquence (Hz)')
ylabel('Densité spectrale de puissance')
