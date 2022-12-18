clear
close all
clc

%% Données :
Fe = 24000;
Te = 1/Fe;
Rb = 3000;
Tb=1/Rb;
M=2; % nombre de symboles dans la constellation
n=log2(M); % nombre de bits par symbole
Rs=Rb/n;
Ts=n*Tb;
nb_bits = 1000;
Ns = Ts/Te;

% h = ones (1, Ns);
alpha=0.25;
SPAN=6; % le filtre dure SPAN = 6 périodes symboles
h=rcosdesign(alpha,SPAN,Ns);
hr = h;
% n0 = Ns; % ne vaut que si h=hr=ones(1,Ns) car Ns=Ns/2+Ns/2
n0=length(h); % car length(h)=length(h)/2+length(h)/2 le retard total, c'est la somme des retards


bits = randi ([0, 1], 1, nb_bits);
bits_map = bits * 2 - 1;
Impulsions1 = [kron(bits_map, [1 zeros(1, Ns-1)]) zeros(1,length(h))];
signalModule = filter(h, 1, Impulsions1);
signalDemodule = filter(hr, 1, signalModule);

decision = signalDemodule(n0+1: Ns :length(signalDemodule));
TEB = sum((decision>0)~=bits)/length(decision)

t_axis=[1:length(signalModule)];
figure
stem(1:Ns:length(bits_map)*Ns,bits_map)
hold on
plot(t_axis,signalModule)
plot(t_axis,signalDemodule)
stem(n0+1:Ns:length(signalDemodule),decision)
legend('a(t)','x(t)','z(t)','z(mTs)')

eyediagram(signalDemodule(n0:end),Ns,Ns)



