function resultats = recherche_simplifiee(identifiants, bdd)
    resultats = [];
    for i=1:length(identifiants)
        identifiant = identifiants(i);
        if bdd.isKey(identifiant)
            entrees = bdd(identifiant);
            resultats = [resultats;entrees(:,2)];
        end
    end
end