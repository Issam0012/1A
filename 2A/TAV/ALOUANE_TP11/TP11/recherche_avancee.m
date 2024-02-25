function resultats = recherche_avancee(identifiants, instants, bdd)
    resultats = [];
    
    for i = 1:length(identifiants)
        identifiant = identifiants(i);
        
        if bdd.isKey(identifiant)
            entrees = bdd(identifiant);
            
            for j = 1:size(entrees, 1)
                occurences_morceau = entrees(j, 1);
                
                for k = 1:length(occurences_morceau)
                    diff_temporelle = instants(i) - occurences_morceau(k);
                    resultats = [resultats;entrees(j,2), diff_temporelle];
                end
            end
        end
    end


end
