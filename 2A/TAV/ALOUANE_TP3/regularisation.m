function s = regularisation(k_voisins,p,q)
    P = p*ones(size(k_voisins));
    Q = q*ones(size(k_voisins));
    s = sum(sum(k_voisins ~= P)) + sum(sum(k_voisins ~= Q));
end