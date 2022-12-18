clc
clear all;
format long;

%%%%%%%%%%%%
% PARAMÈTRES
%%%%%%%%%%%%

% taille de la matrice symétrique
n = 200;

% type de la matrice (voir matgen_csad)
% imat == 1 valeurs propres D(i) = i
% imat == 2 valeurs propres D(i) = random(1/cond, 1) avec leur logarithmes
%                                  uniformément répartie, cond = 1e10
% imat == 3 valeurs propres D(i) = cond**(-(i-1)/(n-1)) avec cond = 1e5
% imat == 4 valeurs propres D(i) = 1 - ((i-1)/(n-1))*(1 - 1/cond) avec cond = 1e2
imat = 1;

% tolérance
eps = 1e-8;
% nombre d'itérations max pour atteindre la convergence
maxit = 10000;

% on génère la matrice (1) ou on lit dans un fichier (0)
genere = 1;

% nombre de valeurs propres cherchées (v0)
m = 20;

%% Test de la méthode subspace_iter_v0

v = 0;

[W, V, flag] = eigen_2021_modified(imat, n, v, m, eps, maxit, [], [], genere);

%% Test de la méthode subspace_iter_v1 %%

v = 1;

[W, V, flag] = eigen_2021_modified(imat, n, v, m, eps, maxit, [], [], genere);

%% Test de la méthode subspace_iter_v2

% v = 2;
% 
% p = 2;
% 
% [W, V, flag] = eigen_2021_modified(imat, n, v, m, eps, maxit, [], p, genere);
% 
%% Test de la méthode subspace_iter_v3

v = 3;

p = 10;

[W, V, flag] = eigen_2021_modified(imat, n, v, m, eps, maxit, [], p, genere);
