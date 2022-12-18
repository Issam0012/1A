clc 
close all
clear

%%Données 

Rb= 2000; % debit binaire
Tb=1/Rb; % periode binaire
Fe = 10000; % freq echant
Te= 1/Fe; % periode echant
fp = 2000; % freq porteuse
alpha = 0.35; % roll off
nb_bits = 10000; % nombre de bits emis
M=4; % nombre de symboles dans la constellation
Ts=log2(M)*Tb ; % periode symbole
Rs=Rb/log2(M); % débit symbole
Ns = Ts/Te; % nombre de periode echant / periode symbole
EbN0dB= (0:1:6);
EbN0=10.^(EbN0dB./10);
SPAN=10 ; % le filtre introduit un retard de 10/2=5 periodes symbole
h= rcosdesign(alpha,SPAN,Ns);
hr=fliplr(h);
nb_symb=nb_bits/log2(M);
t0=length(h);

% Generation des bits

bits = randi ([0, 1], 1, nb_bits);
%% MODULATION %%

% Mapping
Signal=zeros(1,length(bits)/2);

bits_re = reshape(bits, length(bits)/2,2);
bits_re1 = bi2de(bits_re);
% offset = pi/M en quadrature de phase, en phase faut prendre offset = 0
bits_re2 = pskmod(bits_re1,M,pi/M);

Impulsion1 = [kron(bits_re2.', [1 zeros(1, Ns-1)]) zeros(1,t0)]; % generation peigne de Dirac
bits_filtre = filter(h,1,Impulsion1); % signal passe-bas

Puissance= mean(abs(bits_filtre).^2); % Puissance du signal à bruiter
TEB=zeros(1,7);                        % Tableau des TEB simulé 
TEB_Theo = zeros(1,7);                 % Tableau des TEB théorique 

for k=1:length(EbN0) 

    sigma = (Puissance*Ns)./(2*log2(M).*EbN0(k));  %sigma carré

    %génération du bruit
    bruit = sqrt(sigma)*randn(1,length(bits_filtre))*(1+i);

    signalBruite = bits_filtre + bruit;

    Bande_filtre1 = filter(hr,1, signalBruite);
    Bande_filtre_echant = Bande_filtre1(t0:Ns:Ns*nb_symb+t0-1);

    % Demapping

    Bande_filtre2 = pskdemod(Bande_filtre_echant, M, pi/M);

    Bande_filtre3 = de2bi(Bande_filtre2);

    taille = size(Bande_filtre3);

    Bits_reconstitue = reshape(Bande_filtre3, 1, taille(1)*taille(2));

    TEB(k) =  sum(Bits_reconstitue~=bits)/length(bits);
    TEB_Theo(k)= 2* qfunc(sqrt(2*log2(M)*EbN0(k))* sin(pi/M))/log2(M);

end

figure;
semilogy(TEB);
hold on
semilogy(TEB_Theo);
legend("TEB pratique", "TEB Théorique");

%%IMPLANTATION figure1%%





