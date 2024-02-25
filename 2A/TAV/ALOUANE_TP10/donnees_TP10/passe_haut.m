function Y_modifie = passe_haut(Y, valeurs_f, n)
    Y_modifie = Y .* (valeurs_f' > n);
end